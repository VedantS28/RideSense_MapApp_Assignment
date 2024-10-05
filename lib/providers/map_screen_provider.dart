import 'package:flutter/foundation.dart';

/// A provider class that manages map type selection and related operations.
class MapProvider with ChangeNotifier {
  // The currently selected map type
  String _currentMapType = 'Streets';

  /// A map of available map types and their corresponding tile URLs.
  final Map<String, String> mapTypes = {
    'Streets': 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    'Satellite': 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
    'Terrain': 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
  };

  /// Getter for the current map type.
  String get currentMapType => _currentMapType;

  /// Sets the current map type and notifies listeners if it's a valid type.
  ///
  /// [mapType] The map type to set. Must be a key in the [mapTypes] map.
  void setMapType(String mapType) {
    if (mapTypes.containsKey(mapType)) {
      _currentMapType = mapType;
      notifyListeners();
    }
  }

  /// Getter for the URL of the current map type's tiles.
  String get currentMapUrl => mapTypes[_currentMapType]!;
}