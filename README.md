# Todo App

A feature-rich Todo App built with Flutter and Firebase. This app supports user authentication, cloud-based task storage, image uploads, OCR-based text extraction, push notifications, and more.

## Features

- **User Authentication** (Google Sign-In with Firebase Authentication)
- **Task Management** (Add, Edit, Delete tasks with Firestore)
- **Image Uploads** (Firebase Storage)
- **OCR Support** (Extract text from images using Google ML Kit)
- **Push Notifications** (Task reminders with Firebase Cloud Messaging & Local Notifications)
- **Time-based Task Scheduling** (Notifies 10 minutes before the deadline)
- **Cross-Platform Support** (Works on Android, iOS, macOS)

## Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase (Firestore, Authentication, Storage, Messaging)
- **State Management:** Provider
- **Notifications:** Firebase Cloud Messaging & Flutter Local Notifications
- **OCR & AI:** Google ML Kit

## Installation

### Prerequisites
- Flutter SDK installed ([Flutter installation guide](https://flutter.dev/docs/get-started/install))
- Firebase project setup ([Firebase console](https://console.firebase.google.com/))
- CocoaPods installed (for iOS: `sudo gem install cocoapods`)

### Setup Steps

1. **Clone the repository**
   ```sh
   git clone https://github.com/your-repo/todo-app.git
   cd todo-app
   ```

2. **Install dependencies**
   ```sh
   flutter pub get
   ```

3. **Configure Firebase**
   ```sh
   dart run flutterfire_cli configure
   ```

4. **Run the application**
   ```sh
   flutter run
   ```

## File Structure
```
lib/
 ├── main.dart                     # Entry point
 ├── app.dart                      # MaterialApp configuration
 ├── services/                      # Firebase & other logic
 │    ├── auth_service.dart          # Firebase Authentication
 │    ├── firestore_service.dart     # Firestore operations
 │    ├── storage_service.dart       # Image uploads (Firebase Storage)
 │    ├── ocr_service.dart           # OCR for text extraction
 │    ├── notification_service.dart  # Local notification management
 ├── models/                        # Data models
 │    ├── task_model.dart            # Task model
 ├── providers/                      # State management (Provider, Riverpod, Bloc)
 │    ├── auth_provider.dart         # User authentication provider
 │    ├── task_provider.dart         # Task management provider
 ├── screens/                        # UI Screens
 │    ├── login_screen.dart          # Login screen
 │    ├── home_screen.dart           # Task list
 │    ├── add_task_screen.dart       # Add task
 │    ├── task_detail_screen.dart    # Task details
 ├── widgets/                        # Reusable UI components
 │    ├── task_card.dart             # Task list card UI
 │    ├── image_picker_widget.dart   # Image picker widget
```

## Troubleshooting

### 1. Firebase Initialization Error
```sh
[core/not-initialized] Firebase has not been correctly initialized.
```
**Solution:** Ensure `Firebase.initializeApp()` is called before using Firebase services. Also, verify Firebase is configured properly.

### 2. iOS CocoaPods Issues
```sh
[!] CocoaPods could not find compatible versions for pod "google_mlkit_text_recognition"
```
**Solution:**
```sh
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
flutter clean
flutter pub get
```