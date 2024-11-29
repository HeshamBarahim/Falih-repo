import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerController extends GetxController {
  final DateTime currentDate = DateTime.now();

  // Variable to hold the selected date
  DateTime? selectedDate = DateTime.now();

  // Function to show the DatePicker dialog and handle the selected date
  Future<void> dateSelectList(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(), // Initial date
      firstDate: DateTime.now(), // Minimum date
      lastDate: DateTime(2050), // Set the last date to current date
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      update();
    }
  }
}
