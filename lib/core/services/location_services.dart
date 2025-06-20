import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPickerScreen extends StatefulWidget {
  @override
  _MapPickerScreenState createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  GoogleMapController? _mapController;
  LatLng _initialPosition = LatLng(35.0, 38.5); // مركز سوريا
  LatLng? _selectedLocation;
  bool _locationEnabled = false;

  final Location _locationService = Location();

  final List<Map<String, dynamic>> syrianGovernorates = [
    {'name': 'دمشق', 'lat': 33.5138, 'lng': 36.2765},
    {'name': 'حلب', 'lat': 36.2021, 'lng': 37.1343},
    {'name': 'حمص', 'lat': 34.7324, 'lng': 36.7138},
    {'name': 'حماة', 'lat': 35.1318, 'lng': 36.7578},
    {'name': 'اللاذقية', 'lat': 35.5306, 'lng': 35.7915},
    {'name': 'طرطوس', 'lat': 34.8890, 'lng': 35.8866},
    {'name': 'إدلب', 'lat': 35.9306, 'lng': 36.6339},
    {'name': 'دير الزور', 'lat': 35.3361, 'lng': 40.1408},
    {'name': 'الرقة', 'lat': 35.9500, 'lng': 39.0083},
    {'name': 'الحسكة', 'lat': 36.4900, 'lng': 40.7500},
    {'name': 'درعا', 'lat': 32.6189, 'lng': 36.1026},
    {'name': 'السويداء', 'lat': 32.7090, 'lng': 36.5684},
    {'name': 'القنيطرة', 'lat': 33.1250, 'lng': 35.8208},
  ];

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    bool serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
    }

    PermissionStatus permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
    }

    if (permissionGranted == PermissionStatus.granted) {
      final userLocation = await _locationService.getLocation();
      setState(() {
        _locationEnabled = true;
        _initialPosition = LatLng(
          userLocation.latitude!,
          userLocation.longitude!,
        );
      });

      // ✅ حرك الكاميرا إن تم تهيئة الخريطة
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(_initialPosition, 12),
        );
      }
    }
  }

  Set<Marker> _getMarkers() {
    Set<Marker> markers = syrianGovernorates.map((gov) {
      return Marker(
        markerId: MarkerId(gov['name']),
        position: LatLng(gov['lat'], gov['lng']),
        infoWindow: InfoWindow(title: gov['name']),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
    }).toSet();

    if (_selectedLocation != null) {
      markers.add(
        Marker(
          markerId: MarkerId("selected"),
          position: _selectedLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: "الموقع المحدد"),
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("اختر الموقع")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 6.5,
        ),
        onMapCreated: (controller) {
          _mapController = controller;

          if (_locationEnabled) {
            _mapController!.animateCamera(
              CameraUpdate.newLatLngZoom(_initialPosition, 12),
            );
          }
        },
        onTap: (latLng) {
          setState(() => _selectedLocation = latLng);
        },
        myLocationEnabled: _locationEnabled,
        myLocationButtonEnabled: true,
        markers: _getMarkers(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_selectedLocation != null) {
            Navigator.pop(context, _selectedLocation);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("يرجى اختيار موقع أولاً")),
            );
          }
        },
        label: Text("تأكيد"),
        icon: Icon(Icons.check),
      ),
    );
  }
}
