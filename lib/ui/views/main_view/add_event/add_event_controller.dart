import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_templat/core/data/repositories/event_repository.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class AddEventController extends BaseControoler {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final ticketController = TextEditingController();

  final image = Rx<File?>(null);
  final selectedType = Rx<String?>(null);
  final selectedDate = Rx<DateTime?>(null);

  final selectedTime = Rx<DateTime?>(null);
  final selectedLocation = Rx<LatLng?>(null);
  final selectedAddress = Rx<String?>(null);
  final RxList<Map<String, dynamic>> eventTypes = RxList([
    {'label': 'Sports', 'icon': Icons.sports_basketball},
    {'label': 'Music', 'icon': Icons.music_note},
    {'label': 'Art', 'icon': Icons.brush},
    {'label': 'Food', 'icon': Icons.fastfood},
  ]);

  final EventRepository repo = EventRepository();

  void setImage(File file) {
    image.value = file;
  }

  void setType(String type) {
    selectedType.value = type;
  }

  void setTime(DateTime time) {
    selectedTime.value = time;
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> setLocation(LatLng location) async {
    selectedLocation.value = location;
    // Try to reverse geocode to a readable address
    try {
      final placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final candidates = <String?>[
          p.locality, // city
          p.subAdministrativeArea, // district/county
          p.administrativeArea, // governorate/state
          p.country, // fallback
        ];
        final city = candidates.firstWhere(
          (e) => (e ?? '').trim().isNotEmpty,
          orElse: () => null,
        );
        selectedAddress.value = city;
      } else {
        selectedAddress.value = null;
      }
    } catch (_) {
      selectedAddress.value = null;
    }

    // Fallback: try Nominatim if still no city name
    if (selectedAddress.value == null && selectedLocation.value != null) {
      final city = await _fetchCityFromNominatim(
        selectedLocation.value!.latitude,
        selectedLocation.value!.longitude,
      );
      if (city != null && city.trim().isNotEmpty) {
        selectedAddress.value = city;
      }
    }
  }

  Future<String?> _fetchCityFromNominatim(double lat, double lon) async {
    try {
      final uri = Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon&zoom=10&accept-language=ar');
      final res = await http.get(
        uri,
        headers: {
          'User-Agent': 'event_pop_app/1.0 (contact: example@example.com)'
        },
      );
      if (res.statusCode == 200) {
        final data = json.decode(res.body) as Map<String, dynamic>;
        final addr = (data['address'] ?? {}) as Map<String, dynamic>;
        final candidates = [
          addr['city'],
          addr['town'],
          addr['village'],
          addr['county'],
          addr['state'],
          addr['region'],
          addr['country'],
        ];
        return candidates
            .firstWhere(
              (e) => (e?.toString() ?? '').trim().isNotEmpty,
              orElse: () => null,
            )
            ?.toString();
      }
    } catch (_) {
      // ignore
    }
    return null;
  }

  void reset() {
    nameController.clear();
    priceController.clear();
    ticketController.clear();
    image.value = null;
    selectedType.value = null;
    selectedDate.value = null;
    selectedLocation.value = null;
    selectedAddress.value = null;
  }

  void showLoading() {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    if (Get.isDialogOpen ?? false) Get.back();
  }

  void submitEvent({
    required DateTime selectedTime,
    required String name,
    required DateTime selectedDate,
    required String selectedType,
    required LatLng selectedLocation,
    required String price,
    required String tickets,
    required String description,
    required String defaultImageAsset,
  }) async {
    if (name.isEmpty ||
        selectedType.isEmpty ||
        price.isEmpty ||
        tickets.isEmpty ||
        description.isEmpty) {
      CustomToast.showMessage(
        messageType: MessagType.REJECTED,
        message: "Please complete all fields",
      );
      return;
    }

    File? imageFile = image.value;
    if (imageFile == null) {
      // Load default asset image as File
      final byteData = await rootBundle.load(defaultImageAsset);
      final tempDir = Directory.systemTemp;
      final file = await File('${tempDir.path}/event_details.png').writeAsBytes(
        byteData.buffer.asUint8List(),
      );
      imageFile = file;
    }

    runFullLoadingFunction(
      function: repo
          .createEvent(
            name: name,
            date: selectedDate,
            time: selectedTime,
            image: imageFile,
            location: selectedLocation,
            interest: selectedType,
            tickets: int.tryParse(tickets) ?? 0,
            price: int.tryParse(price) ?? 0,
            description: description,
          )
          .then(
            (value) => value.fold(
              (l) {
                CustomToast.showMessage(
                  messageType: MessagType.REJECTED,
                  message: l,
                );
              },
              (r) {
                CustomToast.showMessage(
                  messageType: MessagType.SUCCSESS,
                  message: "Succed add event",
                );
                reset();
              },
            ),
          ),
    );
  }
}
