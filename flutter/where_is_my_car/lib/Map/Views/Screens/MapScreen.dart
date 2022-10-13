import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:where_is_my_car/Cars/ListCarScreen/Views/Widgets/carCard.dart';
import 'package:where_is_my_car/Map/Providers/MapScreenProvider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  LatLng center = LatLng(0, 0);

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> setUserPosition() async {
    Provider.of<MapScreenProvider>(context, listen: false).clear();
    context.read<MapScreenProvider>().setCenter();
    context.read<MapScreenProvider>().getCars();
  }

  Future<void> updateCarPosition() async{
    print("Updating car position");
  }

  @override
  Widget build(BuildContext context) {
    print("Loading");
    return Scaffold(
      /* Floating action button */
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await updateCarPosition();
        },
        child: SvgPicture.asset("assets/svgs/mapMarker.svg", color: Colors.white, width: 30, height: 30),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              mapController: context.watch<MapScreenProvider>().controller,
              options: MapOptions(
                onMapReady: () {
                  setUserPosition();
                },
                center: context.watch<MapScreenProvider>().center,
                /* center: center, */
                zoom: 9.2,
                /* Disable rotation for map */
                interactiveFlags:
                    InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              ),
              nonRotatedChildren: [
                AttributionWidget.defaultWidget(
                  source: 'OpenStreetMap contributors',
                  onSourceTapped: null,
                ),
              ],
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                    markers: context.watch<MapScreenProvider>().markers),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: context.watch<MapScreenProvider>().detailedCar,
            ),
          )
        ],
      ),
    );
  }
}
