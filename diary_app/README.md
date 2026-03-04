# Daily Diary 📔

**A private, secure, and beautiful personal journal app built with Flutter**

Daily Diary is your safe space to write daily thoughts, track moods, and reflect on your emotional journey — all stored locally on your device.

[![Flutter](https://img.shields.io/badge/Flutter-3.19%2B-blue?logo=flutter)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Platform](https://img.shields.io/badge/platform-Android-lightgrey)

## ✨ Features

- **Secure Authentication** – Email/password login with Firebase
- **Biometric Unlock** – Fingerprint protection for privacy
- **Mood Tracking** – 8 moods: Happy 😊, Sad 😢, Excited 😍, Calm 😌, Angry 😤, Anxious 😰, Confident 😎, Neutral 😐
- **Full Offline Support** – Write and read entries without internet
- **Search Entries** – Find by title, date, or content
- **Dark Mode** – Beautiful light/dark theme
- **Streak Counter** – Track consecutive writing days
- **Daily Prompts** – Inspiration when you don't know what to write
- **No Screenshots** – Extra privacy protection

## 📱 Screenshots

<img width="784" height="1168" alt="imag1" src="https://github.com/user-attachments/assets/ba983080-a820-4444-9d7a-f1f6cede125d" />
<img width="784" height="1168" alt="image2" src="https://github.com/user-attachments/assets/b631f210-1f48-49b7-90ff-a5e4474e723a" />

## 🚀 Quick Start

### Prerequisites
- Flutter SDK
- Android Studio / VS Code
- Firebase project

### Installation
```bash
git clone https://github.com/Sumeyahassen/mobile-app-course/edit/main/diary_app
cd diary_app
flutter pub get
flutter run
Build APK
Bashflutter build apk --release --split-per-abi
APKs will be in build/app/outputs/flutter-apk/
🛠️ Tech Stack

Framework: Flutter (Dart)
Authentication: Firebase Auth
Local Database: SQLite (sqflite)
Biometrics: local_auth
Privacy: no_screenshot package
Fonts: Google Fonts (Playfair Display)

📂 Project Structure
textlib/
├── main.dart
├── constants.dart
├── models/
│   └── diary_model.dart
├── services/
│   ├── auth_service.dart
│   ├── database_service.dart
│   └── fingerprint_service.dart
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── fingerprint_enable_screen.dart
│   ├── fingerprint_unlock_screen.dart
│   ├── home_screen.dart
│   └── add_edit_diary_screen.dart
🔒 Privacy & Security

All data stored locally only
No internet required after login
Screenshots blocked
Secure biometric lock

📄 License
This project is licensed under the MIT License - see LICENSE for details.
👩‍💻 Author
Sumeya
Mobile App Development Student
Feel free to star ⭐ the repo if you like it!

Thank you for visiting my project!
Your feedback means a lot ❤️
text### How to Make It Even Better

1. **Add real screenshots**:
   - Create folder `screenshots/`
   - Use emulator recording (as we discussed)
   - Save as `login.png`, `home.png`, etc.

2. **Add badges** (optional):
   - Stars, forks will appear automatically on GitHub

3. **Create `LICENSE` file** (MIT License)

4. **Push to GitHub**:
   ```bash
   git add .
   git commit -m "Add professional README"
   git push
to downlode  app to use this link
https://bit.ly/DihariApp
