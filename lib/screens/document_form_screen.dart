import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/document.dart';
import '../providers/document_provider.dart';
import '../theme/app_theme.dart';

class DocumentFormScreen extends StatefulWidget {
  const DocumentFormScreen({super.key, this.document});

  final EvrakDocument? document;

  @override
  State<DocumentFormScreen> createState() => _DocumentFormScreenState();
}

class _DocumentFormScreenState extends State<DocumentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _tagsController;
  late String _category;
  late EvrakFileType _fileType;
  late DateTime _date;

  bool get _isEditing => widget.document != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.document?.title);
    _descriptionController = TextEditingController(text: widget.document?.description);
    _tagsController = TextEditingController(text: widget.document?.tags.join(', '));
    _category = widget.document?.category ?? evrakCategories.first.name;
    _fileType = widget.document?.fileType ?? EvrakFileType.pdf;
    _date = widget.document?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final tags = _tagsController.text
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    final provider = context.read<DocumentProvider>();
    if (_isEditing) {
      final updated = widget.document!.copyWith(
        title: _titleController.text.trim(),
        category: _category,
        fileType: _fileType,
        description: _descriptionController.text.trim(),
        tags: tags,
        date: _date,
      );
      await provider.updateDocument(updated);
    } else {
      await provider.addDocument(
        title: _titleController.text.trim(),
        category: _category,
        fileType: _fileType,
        fileSizeKB: 128,
        description: _descriptionController.text.trim(),
        tags: tags,
        date: _date,
      );
    }

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fieldBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Evrakı Düzenle' : 'Yeni Evrak'),
        actions: [
          IconButton(onPressed: _save, icon: const Icon(Icons.check)),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Başlık',
                filled: true,
                fillColor: fieldBg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
              validator: (value) => (value == null || value.trim().isEmpty) ? 'Başlık zorunludur' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: InputDecoration(
                labelText: 'Kategori',
                filled: true,
                fillColor: fieldBg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
              items: evrakCategories
                  .map((c) => DropdownMenuItem(value: c.name, child: Text(c.name)))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _category = value);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<EvrakFileType>(
              value: _fileType,
              decoration: InputDecoration(
                labelText: 'Dosya Türü',
                filled: true,
                fillColor: fieldBg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
              items: EvrakFileType.values
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.label)))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _fileType = value);
              },
            ),
            const SizedBox(height: 16),
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: _pickDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Tarih',
                  filled: true,
                  fillColor: fieldBg,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
                child: Text('${_date.day}.${_date.month}.${_date.year}'),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Açıklama',
                filled: true,
                fillColor: fieldBg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tagsController,
              decoration: InputDecoration(
                labelText: 'Etiketler (virgülle ayırın)',
                filled: true,
                fillColor: fieldBg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(_isEditing ? 'Kaydet' : 'Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
