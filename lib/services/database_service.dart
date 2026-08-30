import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../models/document.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService instance = DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'evrak.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE documents (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            category TEXT NOT NULL,
            fileType TEXT NOT NULL,
            fileSizeKB INTEGER NOT NULL,
            description TEXT,
            tags TEXT,
            date TEXT NOT NULL,
            createdAt TEXT NOT NULL,
            isFavorite INTEGER NOT NULL DEFAULT 0
          )
        ''');
        await _seedSampleData(db);
      },
    );
  }

  Future<void> _seedSampleData(Database db) async {
    const uuid = Uuid();
    final now = DateTime.now();

    final samples = <EvrakDocument>[
      EvrakDocument(
        id: uuid.v4(),
        title: 'Görevlendirme Onay Formu',
        category: 'Atama ve Görevlendirme',
        fileType: EvrakFileType.pdf,
        fileSizeKB: 245,
        description: 'Öğretmenlerin görevlendirme işlemleri için kullanılan onay formudur.',
        tags: const ['Görevlendirme', 'Atama', 'Form'],
        date: now.subtract(const Duration(days: 2)),
        createdAt: now.subtract(const Duration(days: 2)),
        isFavorite: true,
      ),
      EvrakDocument(
        id: uuid.v4(),
        title: 'Atama Talep Dilekçesi',
        category: 'Atama ve Görevlendirme',
        fileType: EvrakFileType.docx,
        fileSizeKB: 132,
        description: 'Atama talebinde bulunmak için doldurulan dilekçe örneğidir.',
        tags: const ['Atama', 'Dilekçe'],
        date: now.subtract(const Duration(days: 5)),
        createdAt: now.subtract(const Duration(days: 5)),
      ),
      EvrakDocument(
        id: uuid.v4(),
        title: 'Norm Kadro Fazlası Formu',
        category: 'Atama ve Görevlendirme',
        fileType: EvrakFileType.pdf,
        fileSizeKB: 210,
        description: 'Norm kadro fazlası durumunda kullanılan bildirim formudur.',
        tags: const ['Norm Kadro', 'Form'],
        date: now.subtract(const Duration(days: 8)),
        createdAt: now.subtract(const Duration(days: 8)),
      ),
      EvrakDocument(
        id: uuid.v4(),
        title: 'Okul İçi Görevlendirme Formu',
        category: 'Atama ve Görevlendirme',
        fileType: EvrakFileType.xlsx,
        fileSizeKB: 98,
        description: 'Okul içi görev dağılımı için kullanılan tablo formudur.',
        tags: const ['Görevlendirme', 'Okul İçi'],
        date: now.subtract(const Duration(days: 10)),
        createdAt: now.subtract(const Duration(days: 10)),
      ),
      EvrakDocument(
        id: uuid.v4(),
        title: 'Görevlendirme İptal Dilekçesi',
        category: 'Atama ve Görevlendirme',
        fileType: EvrakFileType.docx,
        fileSizeKB: 115,
        description: 'Onaylanmış bir görevlendirmenin iptali için kullanılan dilekçedir.',
        tags: const ['Görevlendirme', 'İptal', 'Dilekçe'],
        date: now.subtract(const Duration(days: 12)),
        createdAt: now.subtract(const Duration(days: 12)),
      ),
      EvrakDocument(
        id: uuid.v4(),
        title: 'Yer Değiştirme Başvuru Formu',
        category: 'Atama ve Görevlendirme',
        fileType: EvrakFileType.pdf,
        fileSizeKB: 220,
        description: 'İl/ilçe içi veya iller arası yer değiştirme başvurusu için kullanılır.',
        tags: const ['Yer Değiştirme', 'Başvuru'],
        date: now.subtract(const Duration(days: 15)),
        createdAt: now.subtract(const Duration(days: 15)),
      ),
      EvrakDocument(
        id: uuid.v4(),
        title: 'Yıllık İzin Dilekçesi',
        category: 'İzin İşlemleri',
        fileType: EvrakFileType.docx,
        fileSizeKB: 120,
        description: 'Yıllık izin talebinde bulunmak için kullanılan dilekçe örneğidir.',
        tags: const ['İzin', 'Dilekçe'],
        date: now.subtract(const Duration(days: 1)),
        createdAt: now.subtract(const Duration(days: 1)),
        isFavorite: true,
      ),
      EvrakDocument(
        id: uuid.v4(),
        title: 'Maaş Bordro Örneği',
        category: 'Maaş ve Ek Ders',
        fileType: EvrakFileType.pdf,
        fileSizeKB: 180,
        description: 'Aylık maaş bordrosu örnek çıktısıdır.',
        tags: const ['Maaş', 'Bordro'],
        date: now.subtract(const Duration(days: 20)),
        createdAt: now.subtract(const Duration(days: 20)),
      ),
      EvrakDocument(
        id: uuid.v4(),
        title: 'Harcirah Bildirim Formu',
        category: 'Maaş ve Ek Ders',
        fileType: EvrakFileType.xlsx,
        fileSizeKB: 95,
        description: 'Görev yolluğu (harcirah) bildirimi için kullanılan formdur.',
        tags: const ['Harcirah', 'Form'],
        date: now.subtract(const Duration(days: 25)),
        createdAt: now.subtract(const Duration(days: 25)),
      ),
    ];

    for (final doc in samples) {
      await db.insert('documents', doc.toMap());
    }
  }

  Future<List<EvrakDocument>> fetchAll() async {
    final db = await database;
    final rows = await db.query('documents', orderBy: 'date DESC');
    return rows.map((row) => EvrakDocument.fromMap(row)).toList();
  }

  Future<void> insert(EvrakDocument document) async {
    final db = await database;
    await db.insert(
      'documents',
      document.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(EvrakDocument document) async {
    final db = await database;
    await db.update(
      'documents',
      document.toMap(),
      where: 'id = ?',
      whereArgs: [document.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await database;
    await db.delete('documents', where: 'id = ?', whereArgs: [id]);
  }
}
