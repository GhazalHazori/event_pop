import 'package:flutter_templat/core/data/models/event_map_model.dart';
import 'package:flutter_templat/core/data/repositories/event_repository.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends BaseControoler {
  final Rx<CameraPosition> initialPosition = const CameraPosition(
    target: LatLng(35.0, 38.5), // Default position for Syria
    zoom: 10,
  ).obs;

  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxBool isLoading = true.obs;
  final Map<String, BitmapDescriptor> markerIcons = {};
  RxList<PlaceModel> placeevent = <PlaceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getEventForMap();
    _loadMarkerIcons();
  }

  Future<void> _loadMarkerIcons() async {
    // You can load custom icons here if needed
    // For now, we'll use default markers with different colors
  }

  Future<void> getEventForMap() async {
    try {
      final result = await EventRepository().getEventformap();
      result.fold(
        (error) {
          // Handle error
          print('Error fetching events: $error');
        },
        (events) {
          placeevent.assignAll(events);
          // Convert PlaceModel list to format expected by _addMarkers
          final locations = events
              .map((event) => {
                    'id': event.id,
                    'coordinates': [
                      event.coordinates?.lat ?? 0.0,
                      event.coordinates?.lng ?? 0.0,
                    ],
                    'name': event.name ?? 'No Name',
                    'interest': event.interest ?? 'other',
                  })
              .toList();
          _addMarkers(locations);
        },
      );
    } catch (e) {
      print('Exception in getEventForMap: $e');
    } finally {
      isLoading.value = false;
    }
  }

  BitmapDescriptor _getMarkerIcon(String interest) {
    switch (interest.toLowerCase()) {
      case 'sport':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 'music':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case 'art':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'food':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  void _addMarkers(List<dynamic> locations) {
    markers.clear();
    for (var location in locations) {
      try {
        final lat = location['coordinates'][1]?.toDouble() ?? 0.0;
        final lng = location['coordinates'][0]?.toDouble() ?? 0.0;

        // Skip invalid coordinates
        if (lat == 0.0 && lng == 0.0) continue;

        final eventName = location['name']?.toString() ?? 'Unknown Location';
        final interest = location['interest']?.toString() ?? 'غير محدد';

        final marker = Marker(
          markerId: MarkerId(location['id']?.toString() ??
              '${DateTime.now().millisecondsSinceEpoch}'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: '$eventName ($interest)',
            snippet: 'انقر للمزيد من التفاصيل',
          ),
          icon: _getMarkerIcon(location['interest'] ?? 'other'),
        );
        markers.add(marker);
        print(
            'Added marker at: $lat, $lng - ${location['name']} (${location['interest']})');
        print(markers.length);
        print(markers);
      } catch (e) {
        print('Error creating marker: $e');
      }
    }
  }
}
