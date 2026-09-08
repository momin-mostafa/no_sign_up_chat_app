# Addiits Technology Practical Test

A real-time chat application built with Flutter, Firebase Firestore, and Provider for state
management.

## Features

- Join a chat room with a display name
- Real-time messaging with Firestore
- Typing indicators
- Day separators between messages
- Member strip showing online users
- System messages for join/leave events

## Prerequisites

- **Flutter SDK** (>= 3.12.2) — [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Firebase CLI** — `npm install -g firebase-tools`
- **A Firebase project** with Firestore enabled
- **Android Studio** or **VS Code** with Flutter/Dart plugins

## Getting Started

### 1. Clone the repository

```bash
git clone <repository-url>
cd addiits_technology_practical_test
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

#### Option A — Use FlutterFire CLI (recommended)

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This regenerates `lib/firebase_options.dart` with your project's credentials.

#### Option B — Manual setup

1. Create or select a project in the [Firebase Console](https://console.firebase.google.com/).
2. Enable **Cloud Firestore** in the Firebase Console.
3. Register Android and iOS apps in the project.
4. Download `google-services.json` into `android/app/`.
5. Download `GoogleService-Info.plist` into `ios/Runner/`.
6. Replace the contents of `lib/firebase_options.dart` with the config from your Firebase project.

### 4. Run the app

```bash
# Android
flutter run

# iOS (macOS only)
cd ios && pod install && cd ..
flutter run -d ios

# Web
flutter run -d chrome
```

## Project Structure

```
lib/
├── main.dart                          # App entry point, Firebase init, Provider setup
├── theme.dart                         # App colors and theme constants
├── firebase_options.dart              # FlutterFire auto-generated config
└── features/
    ├── join/
    │   └── join.view.dart             # Join/entry screen
    └── chat_room/
        ├── chat_room.view.dart        # Main chat room screen
        ├── chat_provider.dart         # Chat state management (ChangeNotifier)
        ├── data/
        │   └── chat_repository.dart   # Firestore data layer
        ├── models/
        │   └── chat_models.dart       # Message and user models
        └── widgets/
            ├── chat_bubble.dart       # Individual message bubble
            ├── composer.dart          # Message input field
            ├── day_separator.dart     # Date separator widget
            ├── member_strip.dart      # Online members display
            ├── message_list.dart      # Scrollable message list
            ├── system_chip.dart       # System message chip
            └── typing_indicator.dart  # Typing indicator widget
```

## Tech Stack

| Layer    | Technology           |
|----------|----------------------|
| UI       | Flutter / Material   |
| State    | Provider             |
| Database | Cloud Firestore      |
| Auth     | Anonymous (Firebase) |

## Running Tests

```bash
flutter test
```

## Build for Production

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web
```

## Architectural short note

It uses basic MVVM architecture. Feature first folder structure. Tried to keep it as simple as
possible.

## partial work done : 

- features like push notification is not yet done. 
- The read/unread message option is not properly working. 

## License

This project is for practical assessment purposes.
