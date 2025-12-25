ramadan_nasheed_app/                  # Root folder (your project name)
├── android/                          # Android-specific files (auto-generated)
├── ios/                              # iOS-specific files (auto-generated)
├── lib/                              # Main Dart code
│   ├── main.dart                     # Entry point of the app
│   ├── screens/                      # All screens/widgets
│   │   ├── home_screen.dart          # List of nasheeds
│   │   └── player_screen.dart        # Optional: Detailed player view
│   ├── models/                       # Data models
│   │   └── nasheed_model.dart        # Class for nasheed data (title, language, file)
│   ├── services/                     # Audio service
│   │   └── audio_player_service.dart # Handles just_audio logic
│   └── widgets/                      # Reusable widgets
│       ├── nasheed_list_item.dart    # Single nasheed tile
│       └── mini_player.dart           # Bottom mini player controls
├── assets/                           # All static assets
│   ├── audio/                        # Your nasheed MP3 files
│   │   ├── sample_arabic_1.mp3       # Example files (add your own)
│   │   ├── sample_arabic_2.mp3
│   │   ├── sample_english_1.mp3
│   │   └── ... (up to 30 files)
│   ├── images/                       # App icons, backgrounds, etc.
│   │   └── app_icon.png
│   └── data/                         # Metadata
│       └── nasheeds.json             # List of nasheeds with titles, languages, files
├── test/                             # Unit/widget tests (optional for now)
├── pubspec.yaml                      # Dependencies and assets declaration
└── README.md                         # Project description