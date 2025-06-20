import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_templat/core/data/repositories/event_repository.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEventController extends BaseControoler {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final ticketController = TextEditingController();

  final image = Rx<File?>(null);
  final selectedType = Rx<String?>(null);
  final selectedDate = Rx<DateTime?>(null);
  final selectedLocation = Rx<LatLng?>(null);
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

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  void setLocation(LatLng location) {
    selectedLocation.value = location;
  }

  void reset() {
    nameController.clear();
    priceController.clear();
    ticketController.clear();
    image.value = null;
    selectedType.value = null;
    selectedDate.value = null;
    selectedLocation.value = null;
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
    required String name,
    required DateTime selectedDate,
    required String selectedType,
    required LatLng selectedLocation,
    required String price,
    required String tickets,
  }) {
    if (name.isEmpty ||
        selectedType.isEmpty ||
        price.isEmpty ||
        tickets.isEmpty) {
      CustomToast.showMessage(
        messageType: MessagType.REJECTED,
        message: "Please complete all fields",
      );
      return;
    }

    runFullLoadingFunction(
      function: repo
          .createEvent(
            name: name,
            date: selectedDate,
            image: "ssssss",
            location: selectedLocation,
            interest: selectedType,
            tickets: int.tryParse(tickets) ?? 0,
            price: int.tryParse(price) ?? 0,
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
