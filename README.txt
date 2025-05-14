
Dream Log App

Dream Log App is a Flutter-based application that allows users to log their dreams, track moods, and gain insights through journaling and mood analysis. The app integrates Firebase for authentication and cloud storage, ensuring a seamless and secure user experience.

🛠 Setup Steps

1. Clone the Repository:
   ```bash
   git clone <repository_url>
   cd dream_log_app
   ```

2. Install Flutter:
   Ensure you have Flutter installed. Follow the [official Flutter setup guide](https://flutter.dev/docs/get-started/install).

3. Install Dependencies:
   Run the following command to install all required packages:
   ```bash
   flutter pub get
   ```

4. Set Up Firebase:
   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Add Android and iOS apps to your project.
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files and place them in the respective directories:
     - `android/app/google-services.json`
     - `ios/Runner/GoogleService-Info.plist`
   - Enable Firebase Authentication and Firestore Database in your Firebase Console.

5. Run the App:
   Launch the app on an emulator or a physical device:
   ```bash
   flutter run
   ```

📚 Tech Stack Used

- Framework: Flutter
- State Management: Provider
- Backend: Firebase (Authentication & Firestore Database)
- UI Design: Material Design (Flutter)

📊 Libraries for Animations & Charts

- Animations:
  - `flutter_animate`: Smooth and pre-defined animation effects.
  - `rive_flutter`: Interactive and advanced animations (optional).

- Charts:
  - `fl_chart`: Customizable and feature-rich charts for visual data representation.

🐞 Known Bugs

1. Firebase Configuration:
   - Ensure that Firebase is properly configured; otherwise, the app will not authenticate users or save data.

2. Theme Compatibility:
   - Some widgets may not fully adapt to dark mode in certain Android/iOS versions.

3. Navigation State:
   - On rapid switching between screens, the state of some widgets may reset unexpectedly.

4. Error Handling:
   - Error messages for failed Firebase connections may not provide sufficient details to the user.

Feel free to contribute or report issues by opening a pull request or issue in the repository. 😊
