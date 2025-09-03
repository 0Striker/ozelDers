# Özel Ders Uygulaması - İskelet

Bu repo; Flutter (iOS/Android/Web), Riverpod, Firebase (Auth/Firestore/Storage/Messaging), go_router ve temel CI ile başlangıç iskeletidir.

## Gereksinimler
- Flutter 3.32.x (stable)
- Dart 3.8.x
- Firebase proje bilgileri

## Kurulum
bash
flutter pub get
flutter run -d chrome


### Ortam Değişkenleri (.env)
Proje köküne .env oluşturun:

FIREBASE_API_KEY=
FIREBASE_APP_ID=
FIREBASE_MESSAGING_SENDER_ID=
FIREBASE_PROJECT_ID=
FIREBASE_AUTH_DOMAIN=
FIREBASE_STORAGE_BUCKET=
FIREBASE_MEASUREMENT_ID=

Not: .env repoya eklenmez (ör. .gitignore).

## Yapı
- lib/app → router, theme, App widget
- lib/features → modüler ekranlar (auth, home, splash)
- lib/infra → firebase adapterleri, bildirim, vb.

## CI
GitHub Actions ile analyze, test, build web çalışır: .github/workflows/flutter-ci.yml.

## Sonraki Adımlar
- Auth akışı (FirebaseAuth + Google/Apple)
- Firestore repository/modeller
- Course/Lesson akışları
- Ödeme entegrasyonları

## Mimari ve Özellikler
- *Hedef platformlar*: iOS, Android, Web (Flutter)
- *Durum yönetimi*: Riverpod (alternatif: Bloc)
- *Veri*: Cloud Firestore (+ offline cache)
- *Dosya*: Firebase Storage
- *Kimlik*: Firebase Auth (e-posta/şifre + Google/Apple)
- *Bildirim*: Firebase Cloud Messaging (FCM)
- *Sunucu mantığı (opsiyonel)*: Cloud Functions (TypeScript) – iş kuralları ve ödeme webhooks
- *Gerçek zamanlı*: Firestore snapshot’lar + Presence
- *Takvim*: device_calendar + (opsiyonel) Google Calendar OAuth
- *Görüntülü ders*: Agora/100ms/Zoom SDK (Flutter eklentileri)
- *Ödeme*: IAP (StoreKit/Billing) veya iyzico/PayTR WebView + Functions webhook
- *Analitik/Crash*: Firebase Analytics + Crashlytics
- *A/B ve Remote ayar*: Firebase Remote Config
- *CI/CD*: GitHub Actions (alternatif: Codemagic)

## Firestore Koleksiyon Şeması
text
users {uid, role: 'student'|'teacher'|'admin', name, email, photoUrl, phone, grade, bio, tags[], createdAt}
courses {id, title, subject, level, teacherId, coverUrl, price, isLive, createdAt}
lessons {id, courseId, title, startAt, endAt, type:'live'|'recorded', meetUrl, recordingUrl, materials[], capacity}
enrollments {id, courseId, userId, status:'active'|'completed'|'refunded', progress, createdAt}
assignments {id, courseId, lessonId?, title, desc, dueAt, attachments[]}
submissions {id, assignmentId, studentId, answerText, files[], score?, feedback?, submittedAt, gradedAt?}
ai_reviews {id, submissionId, classes[], suggestions[], rubric{}, createdAt}
chats {id, members:[uid], courseId?, lastMsg, updatedAt}
messages {id, chatId, senderId, text, files[], createdAt, readBy[]}
payments {id, userId, courseId, amount, currency, provider, status, createdAt}
notifications {id, userId, type, title, body, ref, createdAt, read:false}
presence {uid, lastSeen, isOnline}
reports {id, userId, period, metrics{studyTime, completion, weakTopics[]}, createdAt}


## Güvenlik Kuralları (Özet)
- users/{uid}: yalnızca sahibi okuyup/yazar; role yazımı sadece admin Functions tarafından yapılır.
- Öğrenci: sadece kendi enrollments, submissions, messages kayıtlarını okur/yazar.
- Öğretmen: kendi courses/lessons/assignments yönetir, kendi kursundaki submissions notlayabilir.
- Yazma tarafında kritik alanlar Functions ile doğrulanır (örn: ödeme durumunu yalnızca webhook günceller).
- Storage kuralları ve Firestore kuralları PII minimizasyonu ve erişim denetimi ile uyumlu olmalıdır.

## Flutter Akışları
- *Kayıt/Giriş*: firebase_auth (+ reCAPTCHA telefon varsa)
- *Profil*: users dokümanı oluştur/güncelle
- *Kurs keşfi*: Firestore query + sayfalama
- *Kursa kayıt*: payments → provider webhook → Functions ile enrollments yarat
- *Ders planı*: lessons stream + cihaz takvimine ekleme
- *Canlı ders*: SDK join/leave + presence güncelle
- *Materyal*: Storage’dan imzalı URL veya kurallı doğrudan indirme
- *Ödev yükleme*: Storage upload → submissions yaz
- *AI ödev analizi*: Functions → Vertex/OpenAI → ai_reviews yaz (alternatif: cihaz içi sınıflandırma)
- *Mesajlaşma*: chats/messages stream, typing/read receipts
- *Bildirim*: FCM topic + user-scoped token; background handler

## Çekirdek Paketler
- *Firebase*: firebase_core, firebase_auth, cloud_firestore, firebase_storage, firebase_messaging, firebase_analytics, firebase_crashlytics, firebase_remote_config
- *Durum*: flutter_riverpod (alternatif: bloc)
- *Router*: go_router
- *Form/Validation*: reactive_forms (alternatif: formz)
- *Medya*: file_picker, image_picker, video_player, just_audio, cached_network_image, flutter_markdown
- *Takvim*: device_calendar
- *Canlı ders*: agora_rtc_engine (ihtiyaç olduğunda eklenir)
- *Ödeme*: in_app_purchase + dış sağlayıcı için webview_flutter
- *Yardımcılar*: intl, flutter_dotenv, uuid, equatable, json_annotation

## Klasör Yapısı
text
lib/
  app/            # router, theme, App widget
  features/
    auth/
    profile/
    courses/
    lessons/
    assignments/
    submissions/
    chat/
    payments/
    analytics/
  common/         # widgets, utils, services (ilerleyen adımda)
  data/           # repositories, models, dto, mappers (ilerleyen adımda)
  infra/          # firebase adapters, notifications, calendar, video
functions/        # Cloud Functions (TypeScript) - planlanan


## Cloud Functions (Plan)
- onPaymentWebhook: provider doğrula → payments güncelle → enrollments oluştur
- onUserCreate: users/{uid} default rol ve indeks alanları
- gradeSubmission: öğretmen veya AI talebiyle puanlama kaydı
- notifyLessonStart: lessons.startAt - 15m için FCM hatırlatma
- presenceMonitor: disconnect/timeout işlemleri

## Güvenlik ve Uyumluluk
- Firestore + Storage kuralları sıkılaştırılmış erişim ile uygulanır.
- PII minimizasyonu: Loglarda kişisel veri tutulmaz.
- iOS’ta Apple Sign-in şartlarını karşılama.
- KVKK/GDPR: açık rıza; veriyi silme talebi için Functions endpoint.

## CI/CD
- GitHub Actions ile analyze, test, build web çalışır.
- Alternatif: Codemagic pipeline.

## Yol Haritası
1) Proje çatısı, paketler, ortamlar (.env)
2) Auth + Profil akışı ve kurallar
3) Kurs/lesson listeleme ve canlı ders entegrasyonu
4) Ödeme akışı ve webhook
5) Ödev–teslim–değerlendirme + AI inceleme
6) Mesajlaşma + Bildirim
7) Analitik raporlar, Remote Config ile A/B
8) Testler, CI/CD, Store yayınları