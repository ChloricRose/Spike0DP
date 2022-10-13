import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_is_my_car/Cars/ListCarScreen/Providers/listCarsProvider.dart';
import 'package:where_is_my_car/Cars/ListCarScreen/Views/Screens/listCarsScreen.dart';
import 'package:where_is_my_car/Cars/providers/carProvider.dart';
import 'package:where_is_my_car/Map/Providers/MapScreenProvider.dart';
import 'package:where_is_my_car/Map/Views/Screens/MapScreen.dart';
import 'package:where_is_my_car/implementatios/CarsDbInterface/GeolocatorInterface/GeolocatorImplementation.dart';
import 'package:where_is_my_car/implementatios/CarsDbInterface/LocalCarsDb.dart';
import 'package:where_is_my_car/interfaces/CarsDbInterface.dart';
import 'package:where_is_my_car/interfaces/GeolocatorInterface.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    CarsDbInterface carsDb = LocalCarsDb();
    GeolocatorInterface geo = GeolocatorImplementation();

    return MaterialApp(
      title: 'Where is my car',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(providers: [
        /* Provider<ListCarsProvider>(create: (_) => ListCarsProvider(carsDb)),
          Provider<CarProvider>(create: (_) => CarProvider(carsDb)),
          Provider<MapScreenProvider>(create: (_) => MapScreenProvider(geo, carsDb)), */
        ChangeNotifierProvider.value(value: ListCarsProvider(carsDb)),
        ChangeNotifierProvider.value(value: CarProvider(carsDb)),
        ChangeNotifierProvider.value(value: MapScreenProvider(geo, carsDb)),
      ], child: const CommonScreen()),
    );
  }
}

class CommonScreen extends StatelessWidget {
  const CommonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* Material page with tabs to change between screens */
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Where is my car'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.map)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ListCarsScreen(),
            MapScreen(),
          ],
        ),
      ),
    );
  }
}
