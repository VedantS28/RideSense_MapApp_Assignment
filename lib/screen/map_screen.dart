import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:ridesense_map_app_assignment/providers/map_screen_provider.dart';
import '../models/location.dart';

/// A screen widget that displays a map with the selected location.
///
/// This screen uses [FlutterMap] to render the map and [MapProvider] to manage
/// its state. It allows users to view the selected location on the map and
/// change the map type.
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapProvider(),
      child: Consumer2<LocationModel, MapProvider>(
        builder: (context, locationModel, mapProvider, child) {
          final location = locationModel.location;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Location on Map'),
              actions: [
                // Popup menu for selecting map type
                PopupMenuButton<String>(
                  onSelected: mapProvider.setMapType,
                  itemBuilder: (BuildContext context) {
                    return mapProvider.mapTypes.keys.map((String type) {
                      return PopupMenuItem<String>(
                        value: type,
                        child: Row(
                          children: [
                            Text(type),
                            const SizedBox(width: 10),
                            // Show a check icon for the current map type
                            if (type == mapProvider.currentMapType)
                              const Icon(Icons.check, color: Colors.green),
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                // Display current map type
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Current Map Type: ${mapProvider.currentMapType}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                // Display current location name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Current Location: ${location.name}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                // Map view
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(location.latitude, location.longitude),
                      zoom: 13.0,
                    ),
                    children: [
                      // Tile layer for the map background
                      TileLayer(
                        urlTemplate: mapProvider.currentMapUrl,
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      // Marker layer to show the location point
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point:
                                LatLng(location.latitude, location.longitude),
                            builder: (ctx) => Container(
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
