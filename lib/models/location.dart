import 'package:flutter/foundation.dart';

/// A model to represents a geographical location with latitude, longitude, and a name.
class LocationData {
  final double latitude;
  final double longitude;
  final String name;

  /// Constructor for creating a LocationData instance.
  /// All parameters are required.
  LocationData(
      {required this.latitude, required this.longitude, required this.name});
}

/// A model class for managing the current location in the application.
/// Extends ChangeNotifier to allow widgets to listen for changes.
class LocationModel extends ChangeNotifier {
  LocationData? _location;

  /// Getter for the current location.
  /// Throws an error if accessed when _location is null.
  LocationData get location => _location!;

  /// Sets a new location and notifies listeners of the change.
  /// [location] The new LocationData to set.
  void setLocation(LocationData location) {
    _location = location;
    notifyListeners();
  }
}
