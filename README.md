# 📲 PISCINE FLUTTER
This project's goal is to learn the [Dart](https://dart.dev/) language and the [Flutter](https://flutter.dev/) framework through several exercices (a.k.a. modules) to be able to build mobile applications. <br />

This project is part of the 42 school post-common-core curriculum.

# 👩🏻‍🏫 What I gained from the project

With this project, I learn the basics of Dart and Flutter to build mobile applications : <br />
- I learned to use widgets like Scaffold, ListView, TabBar, Container, etc, to organize my code
- I learned how to manipulate the design of my applications
- I learned to use [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) to handle states in a class
- I learned to manage data and API requests
- I learned basic authentification system with [Auth0](https://auth0.com/)
- I learned to handle a database for a mobile application with [SQLite (Flutter)](https://docs.flutter.dev/cookbook/persistence/sqlite)

# Prerequisites

## Install Flutter

For this project, you need to install Flutter first. <br />
Follow the link [here](https://docs.flutter.dev/get-started/install) to get started. <br />

## Setting Up an Android Emulator for Flutter

From the **module03** onwards, you will need an smartphone emulator. To set up an Android Emulator, follow these steps:

### Prerequisites

1) Install Android Studio: Make sure you have Android Studio installed on your computer. You can download it from [here](https://developer.android.com/studio).
2) Flutter SDK: Ensure you have the Flutter SDK installed. It would be normally be installed if you have installed Flutter.

### Steps to Set Up the Emulator

1) Open Android Studio:
    - Launch Android Studio on your computer.

2) Open the AVD Manager:
    - Navigate to Tools > AVD Manager. Alternatively, you can click on the AVD Manager icon in the toolbar.

3) Create a New Virtual Device:
    - In the AVD Manager, click on the Create Virtual Device button.
    - Choose a device from the list (e.g., Pixel 4) and click Next.

4) Select a System Image:
    - Select a system image (preferably one with the Play Store). You can choose the recommended option or any other as per your requirement.
    - Click Next.

5) Configure AVD:
    - Configure the AVD (Android Virtual Device) as per your needs. You can set the device orientation, scale, etc.
    - Click Finish to create the AVD.

6) Start the Emulator:
    - In the AVD Manager, find your newly created virtual device and click the Play button to start the emulator.
    - Wait for the emulator to boot up completely. This may take a few minutes.

### Running Your Flutter App

1) Open Your Flutter Project:
    - Open your Flutter project in your preferred IDE (e.g., Android Studio, VS Code).

2) Select the Emulator:
    - Ensure your emulator is running. You should see it listed in the device dropdown in the Flutter toolbar of your IDE.
    - Select the emulator from the dropdown list.

3) Run the App:
    - Run your Flutter app using the run button (usually a green play icon) or by executing flutter run in the terminal.

Your Flutter application should now start running on the Android emulator. If you encounter any issues, make sure your emulator is running and properly configured, and that your Flutter environment is set up correctly.

### Troubleshooting

- Emulator Performance: If the emulator is slow, consider enabling hardware acceleration in the Android Studio settings.
- Device Not Showing Up: Ensure the emulator is started and running. Restart the emulator if necessary.
- SDK Issues: Make sure your Android SDK and Flutter SDK are up to date.

For more detailed troubleshooting, refer to the [official Flutter documentation](https://docs.flutter.dev/) and [Android Studio documentation](https://developer.android.com/studio/run/emulator).

# More details

For more details about each module, click on the "mobileModules" folders.
