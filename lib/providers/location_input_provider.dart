import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ridesense_map_app_assignment/screen/map_screen.dart';
import 'package:ridesense_map_app_assignment/widgets/error_dialog.dart';
import '../models/location.dart';
import '../services/location_service.dart';

/// A provider class that manages location input and related operations.
class LocationInputProvider with ChangeNotifier {
  final TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  /// Submits the entered location and navigates to the map screen.
  Future<void> submitLocation(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    final navigator = Navigator.of(context);
    final locationModel = Provider.of<LocationModel>(context, listen: false);

    try {
      setLoading(true);
      // Convert the entered address to location data
      final locationData =
          await LocationService.getLocationFromAddress(locationController.text);

      if (!navigator.mounted) return;

      // Update the location model and navigate to the map screen
      locationModel.setLocation(locationData);
      navigator.push(
        MaterialPageRoute(builder: (context) => const MapScreen()),
      );
    } catch (e) {
      if (!navigator.mounted) return;
      _showErrorDialog(
          navigator.context, 'Failed to find location. Please try again.');
    } finally {
      setLoading(false);
    }
  }

  /// Gets the current device location and navigates to the map screen.
  Future<void> getCurrentLocation(BuildContext context) async {
    final navigator = Navigator.of(context);
    final locationModel = Provider.of<LocationModel>(context, listen: false);

    try {
      setLoading(true);

      // Check and request location permissions
      final permission = await _handleLocationPermission(navigator);
      if (permission == null) return;

      // Get the current device position
      Position position = await Geolocator.getCurrentPosition();
      final locationData = await LocationService.getLocationFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (!navigator.mounted) return;

      // Update the location model and navigate to the map screen
      locationModel.setLocation(locationData);
      navigator.push(
        MaterialPageRoute(builder: (context) => const MapScreen()),
      );
    } catch (e) {
      if (!navigator.mounted) return;
      _showErrorDialog(
          navigator.context, 'Failed to get current location: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  /// Handles location permission checks and requests.
  /// Returns the granted permission or null if permission is denied.
  Future<LocationPermission?> _handleLocationPermission(
      NavigatorState navigator) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!navigator.mounted) return null;
        _showErrorDialog(navigator.context,
            'Location permissions are denied. Please allow location access.');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!navigator.mounted) return null;
      _showErrorDialog(navigator.context,
          'Location permissions are permanently denied. Please enable them in settings.');
      return null;
    }

    return permission;
  }

  /// Shows an error dialog with the given message.
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => ErrorDialog(message: message),
    );
  }

  /// Sets the loading state and notifies listeners.
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }
}
