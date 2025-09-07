import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_templat/ui/views/Map_view/map_controller.dart';

class MapVieww extends StatefulWidget {
  const MapVieww({super.key});

  @override
  State<MapVieww> createState() => _MapViewwState();
}

class _MapViewwState extends State<MapVieww> {
  final MapController controller = Get.put(MapController());
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأحداث على الخريطة'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: controller.initialPosition.value,
              markers: controller.markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;
                _goToInitialPosition();
              },
            ),
            if (controller.markers.isEmpty && !controller.isLoading.value)
              Center(
                child: Text(
                  'لا توجد أحداث متاحة حالياً',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToInitialPosition,
        child: const Icon(Icons.my_location),
      ),
    );
  }

  Future<void> _goToInitialPosition() async {
    final GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(controller.initialPosition.value),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
