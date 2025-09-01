# Özel Ders Uygulaması - İskelet

Bu repo; Flutter (iOS/Android/Web), Riverpod, Firebase (Auth/Firestore/Storage/Messaging), go_router ve temel CI ile başlangıç iskeletidir.

## Gereksinimler
- Flutter 3.32.x (stable)
- Dart 3.8.x
- Firebase proje bilgileri

## Kurulum
```bash
flutter pub get
flutter run -d chrome
```

### Ortam Değişkenleri (.env)
Proje köküne `.env` oluşturun:
```
FIREBASE_API_KEY=
FIREBASE_APP_ID=
FIREBASE_MESSAGING_SENDER_ID=
FIREBASE_PROJECT_ID=
FIREBASE_AUTH_DOMAIN=
FIREBASE_STORAGE_BUCKET=
FIREBASE_MEASUREMENT_ID=
```
Not: `.env` repoya eklenmez (ör. .gitignore).

## Yapı
- `lib/app` → router, theme, App widget
- `lib/features` → modüler ekranlar (auth, home, splash)
- `lib/infra` → firebase adapterleri, bildirim, vb.

## CI
GitHub Actions ile analyze, test, build web çalışır: `.github/workflows/flutter-ci.yml`.

## Sonraki Adımlar
- Auth akışı (FirebaseAuth + Google/Apple)
- Firestore repository/modeller
- Course/Lesson akışları
- Ödeme entegrasyonları
