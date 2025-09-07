import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_templat/core/services/location_services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'add_event_controller.dart';
import 'package:image_picker/image_picker.dart';

class AddEventScreen extends StatelessWidget {
  final AddEventController controller = Get.put(AddEventController());
  final TextEditingController descriptionController = TextEditingController();

  // Future<void> _pickImage() async {
  //   final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (picked != null) {
  //     controller.setImage(File(picked.path));
  //   }
  // }
  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
          controller.selectedDate.value ?? DateTime.now()),
    );

    if (pickedTime != null) {
      final selectedDateTime = DateTime(
        controller.selectedDate.value?.year ?? DateTime.now().year,
        controller.selectedDate.value?.month ?? DateTime.now().month,
        controller.selectedDate.value?.day ?? DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );
      controller
          .setTime(selectedDateTime); // تحديث التاريخ والوقت في الـ controller
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.setDate(picked);
    }
  }

  Future<void> _pickLocation(BuildContext context) async {
    final LatLng? location = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MapPickerScreen()),
    );
    if (location != null) {
      await controller.setLocation(location);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(0xFF4C6EF5);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add an event'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Event Name and Image
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Event name :", style: TextStyle(fontSize: 19)),
                        SizedBox(height: 20),
                        TextField(
                          controller: controller.nameController,
                          decoration: InputDecoration(
                            hintText: 'example',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Description:", style: TextStyle(fontSize: 19)),
                        SizedBox(height: 8),
                        TextField(
                          controller: descriptionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Describe your event',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () async {
                      final picked = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (picked != null) {
                        controller.setImage(File(picked.path));
                      }
                    },
                    child: Obx(() => Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: themeColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: controller.image.value != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    controller.image.value!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/event_details.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// Event Type
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Event Type:", style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.eventTypes.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12),
                  itemBuilder: (ctx, i) {
                    final type = controller.eventTypes[i];
                    return Obx(() {
                      final selected =
                          controller.selectedType.value == type['label'];
                      return GestureDetector(
                        onTap: () => controller.setType(type['label']),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 23,
                              backgroundColor:
                                  selected ? Colors.blue : Colors.grey[200],
                              child: Icon(
                                type['icon'],
                                color: selected ? Colors.white : Colors.grey,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(type['label']),
                          ],
                        ),
                      );
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// Date
              Obx(() => ListTile(
                    onTap: () => _selectDate(context),
                    leading: Icon(Icons.calendar_today, color: themeColor),
                    title: Text(
                      controller.selectedDate.value != null
                          ? DateFormat.yMMMd()
                              .format(controller.selectedDate.value!)
                          : 'Choose from calendar',
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  )),
              const SizedBox(height: 20),
              Obx(() => ListTile(
                    onTap: () =>
                        _selectTime(context), // استدعاء دالة اختيار الوقت
                    leading: Icon(Icons.access_time,
                        color: themeColor), // رمز الساعة
                    title: Text(
                      controller.selectedDate.value != null
                          ? DateFormat.Hm().format(controller.selectedDate
                              .value!) // تنسيق الوقت (الساعة والدقيقة)
                          : 'Choose time', // النص الافتراضي إذا لم يتم اختيار الوقت
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  )),

              /// Location
              Obx(() => ListTile(
                    onTap: () => _pickLocation(context),
                    leading: Icon(Icons.location_on, color: themeColor),
                    title: Text('Pick location on map'),
                    subtitle: controller.selectedLocation.value != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (controller.selectedAddress.value != null)
                                Text(
                                  controller.selectedAddress.value!,
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                              Text(
                                'Lat: ${controller.selectedLocation.value!.latitude}, Lng: ${controller.selectedLocation.value!.longitude}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          )
                        : null,
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  )),
              const SizedBox(height: 20),

              /// Price & Tickets
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        suffixText: '\$',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: controller.ticketController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Number of tickets',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade400),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: controller.reset,
                child: Text(
                  'RESET',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  controller.submitEvent(
                    selectedTime: controller.selectedTime.value!,
                    description: descriptionController.text,
                    name: controller.nameController.text,
                    selectedDate: controller.selectedDate.value!,
                    selectedType: controller.selectedType.value!,
                    selectedLocation: controller.selectedLocation.value!,
                    price: controller.priceController.text,
                    tickets: controller.ticketController.text,
                    defaultImageAsset: 'assets/images/event_details.png',
                  );
                },
                child: Text(
                  'PLACE EVENT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
