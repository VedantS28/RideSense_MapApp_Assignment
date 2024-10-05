import 'package:geocoding/geocoding.dart';
import '../models/location.dart';

/// A service class for handling location-related operations.
class LocationService {
  /// Converts a string address to latitude, longitude, and a formatted location name.
  
  /// Throws an exception if the location is not found.
  static Future<LocationData> getLocationFromAddress(String address) async {
    // Convert the address string to geographic coordinates
    List<Location> locations = await locationFromAddress(address);
    if (locations.isEmpty) {
      throw Exception('Location not found');
    }

    // Get more detailed location information from the coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(
        locations.first.latitude, locations.first.longitude);

    // Determine the most appropriate name for the location
    String name = address;
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      // Use the most specific location name available, falling back to the original address
      name = place.locality ??
          place.subAdministrativeArea ??
          place.administrativeArea ??
          address;
    }

    // Return a LocationData object with the gathered information
    return LocationData(
      latitude: locations.first.latitude,
      longitude: locations.first.longitude,
      name: name,
    );
  }

  /// Converts latitude and longitude coordinates to a formatted location name.
  static Future<LocationData> getLocationFromCoordinates(
      double latitude, double longitude) async {
    // Get detailed location information from the coordinates
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    // Determine the most appropriate name for the location
    String name = 'Unknown Location';
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      // Use the most specific location name available, falling back to 'Unknown Location'
      name = place.locality ??
          place.subAdministrativeArea ??
          place.administrativeArea ??
          'Unknown Location';
    }

    // Return a LocationData object with the gathered information
    return LocationData(
      latitude: latitude,
      longitude: longitude,
      name: name,
    );
  }
}
