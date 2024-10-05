import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridesense_map_app_assignment/screen/location_input_screen.dart';
import 'models/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Location Map App',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue, 
        ),
        home: LocationInputScreen(),
      ),
    );
  }
}
