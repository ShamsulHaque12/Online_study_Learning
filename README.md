# Online Study

**সংক্ষিপ্ত বর্ণনা — Short description**

Online Study is a Flutter-based AI-enabled learning app with features for
listening, speaking, role-play, quizzes, streak tracking, user profiles,
and server-driven AI practice. The project uses GetX for state & routing,
Firebase Auth for authentication, and multiple audio/AI integrations.

---

## Main features ✨

- 🔊 Text-to-Speech (TTS) and Speech-to-Text (STT)
- 🎙️ Voice recording + waveform support (recording, playback, upload)
- 🤖 AI: role-play, flashcards, story & dialogue generation, evaluation
- 📚 Lessons, quizzes, mastery levels, leaderboards and progress tracking
- 🔁 Streak / calendar view (TableCalendar)
- 🔐 Firebase Auth + Google Sign-In + JWT session handling
- 📂 Local storage (GetStorage), image picker, share, charts, notifications
- 🎨 Light/Dark theme + multilingual support

---

## Tech & notable packages 🔧

- Flutter (SDK >= 3.10.1)
- get, get_storage, get_storage
- flutter_tts, speech_to_text, record, audioplayers
- firebase_core, firebase_auth, google_sign_in
- table_calendar, fl_chart, share_plus, flutter_screenutil

---

## Quick start (run locally) ⚡

1. Prereqs:
   - Flutter SDK (>= 3.10.1)
   - Android or iOS tooling (Android SDK / Xcode)

2. Open project folder (you are in `d:\online_study`).

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Configure Firebase (if using auth features):
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`

5. Configure API / AI servers (important):
   - Edit `lib/services/api_endpoints.dart` and set `baseUrl` / `aiBaseUrl`

6. Run the app:

   ```bash
   flutter run
   # or for Windows desktop (since your OS is Windows):
   flutter run -d windows
   ```

7. Optional: generate launcher icons:

   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

---

## Important files & structure 📁

- App entry: `lib/main.dart`
- Routing + pages: `lib/route/` (AppRoutes / AppPages)
- Features & UI: `lib/features/`
- Services / networking: `lib/services/` (`NetworkCaller`, `api_endpoints`)
- Global services: `lib/global/`
- Assets: `assets/images/`, `assets/icons/`

---

## Configuration notes / gotchas ⚠️

- Set `aiBaseUrl` in `lib/services/api_endpoints.dart` for AI endpoints to work.
- Add Firebase config files to enable auth flows (Google sign-in, etc.).
- Microphone & storage permissions required for recording features —
  check `AndroidManifest.xml` / `Info.plist` and `permission_handler` use.

---

## Dev commands & tips ✅

- Run tests: `flutter test`
- Analyze: `flutter analyze`
- Format: `dart format .`
- Hot reload: save changes during `flutter run`

---

## Contributing & license

- Fork → feature branch → PR. Add a `LICENSE` file if you plan to publish.

---

If you want I can further translate this README fully to Bangla or add a
short 'How to test AI features' section — tell me which part to expand.
