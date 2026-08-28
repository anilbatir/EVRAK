# EVRAK

Flutter tabanlı, iOS ve Android için tek koddan çalışan evrak/doküman yönetim uygulaması.

## Şu an neler var (altyapı)

- Evrak modeli: başlık, kategori, tarih, notlar
- Yerel veritabanı (SQLite / `sqflite`) ile kalıcı saklama
- Liste ekranı: arama + kategoriye göre filtreleme
- Evrak ekleme / düzenleme formu
- Evrak detay ekranı ve silme
- `provider` ile state yönetimi

Görsel tasarım henüz özelleştirilmedi; varsayılan Material 3 bileşenleri kullanılıyor. Tasarıma karar verildiğinde renk, tipografi ve layout bu altyapının üzerine eklenecek.

## Geliştirme ortamını kurma

```bash
flutter pub get
flutter run
```

iPad/iPhone'da çalıştırmak için Xcode ve bir Apple geliştirici hesabı; Android'de ise Android Studio / bir cihaz veya emülatör gerekir.

## Proje yapısı

```
lib/
  models/        # Veri modelleri
  services/       # Veritabanı erişimi
  providers/       # State yönetimi (ChangeNotifier)
  screens/         # Ekranlar (liste, detay, form)
```
