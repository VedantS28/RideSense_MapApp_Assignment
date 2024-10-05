# RideSense Map App Assignment

This Flutter app allows users to input a location and display it on a map, demonstrating basic user input handling, map integration, and adherence to Flutter best practices.

## Features

- Location input screen with basic validation
- Map display screen showing the entered location
- Error handling for invalid locations
- Geolocation services integration

## Screenshots

### Location Input Screen

![WhatsApp Image 2024-10-05 at 15 00 35_fcd7e6e5](https://github.com/user-attachments/assets/9ba669e8-05a1-4289-a8d1-4beda99891e3)

### Map Display Screen

![WhatsApp Image 2024-10-05 at 15 00 34_f2071625](https://github.com/user-attachments/assets/a5c71e44-9389-4147-9aa2-1cb4d3388547)
![WhatsApp Image 2024-10-05 at 15 00 34_139acbb0](https://github.com/user-attachments/assets/a8c50d7e-8cab-43b9-a62d-12cbacea8de4)



## Project Structure

```
lib/
├── models/
│   └── location.dart
├── providers/
│   ├── location_input_provider.dart
│   └── map_screen_provider.dart
├── screen/
│   ├── location_input_screen.dart
│   └── map_screen.dart
├── services/
│   └── location_service.dart
├── widgets/
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (version ^3.5.3)
- Dart (compatible with Flutter SDK version)
- Android Studio / VS Code / IntelliJ IDEA

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/VedantS28/RideSense_MapApp_Assignment.git
   ```

2. Navigate to the project directory:
   ```
   cd RideSense_MapApp_Assignment
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

### Running the App

1. Ensure you have an emulator running or a physical device connected.

2. Run the app:
   ```
   flutter run
   ```

   Or use the "Run without Debug" option in your IDE.

## Dependencies

- [flutter_map](https://pub.dev/packages/flutter_map): ^4.0.0
- [geocoding](https://pub.dev/packages/geocoding): ^2.1.0
- [geolocator](https://pub.dev/packages/geolocator): ^13.0.1
- [latlong2](https://pub.dev/packages/latlong2): ^0.8.1
- [provider](https://pub.dev/packages/provider): ^6.0.5

