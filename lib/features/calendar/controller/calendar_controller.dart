import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/event_model.dart';

class CalendarController extends GetxController {
  final focusedDate = DateTime.now().obs;
  final selectedDate = DateTime.now().obs;
  final events = <Event>[].obs;
  final daysInMonth = <DateTime>[].obs;

  CalendarController() {
    final now = DateTime.now();
    final strippedDate = DateTime(now.year, now.month, now.day);
    focusedDate.value = strippedDate;
    selectedDate.value = strippedDate;
    _updateDaysInMonth();
  }

  void deleteEvent(Event event) {
    events.remove(event);
    update();
  }

  // Optional: Add method to edit events
  void editEvent(Event oldEvent, Event newEvent) {
    final index = events.indexOf(oldEvent);
    if (index != -1) {
      events[index] = newEvent;
      update();
    }
  }

  void addEvent(Event event) {
    events.add(event);
    update();
  }

  List<Event> getEventsForDate(DateTime date) {
    return events
        .where((event) =>
            event.date.year == date.year &&
            event.date.month == date.month &&
            event.date.day == date.day)
        .toList();
  }

  void _updateDaysInMonth() {
    final firstDayOfMonth =
        DateTime(focusedDate.value.year, focusedDate.value.month, 1);
    final lastDayOfMonth =
        DateTime(focusedDate.value.year, focusedDate.value.month + 1, 0);

    final List<DateTime> days = [];

    for (int i = 0; i < firstDayOfMonth.weekday - 1; i++) {
      days.add(firstDayOfMonth
          .subtract(Duration(days: firstDayOfMonth.weekday - i - 1)));
    }

    for (int i = 0; i < lastDayOfMonth.day; i++) {
      days.add(
          DateTime(focusedDate.value.year, focusedDate.value.month, i + 1));
    }

    for (int i = 0; days.length % 7 != 0; i++) {
      days.add(lastDayOfMonth.add(Duration(days: i + 1)));
    }

    daysInMonth.value = days;
  }

  void setDate(DateTime date) {
    if (date.year >= 1900 && date.year <= 2100) {
      focusedDate.value = DateTime(date.year, date.month, 1);
      _updateDaysInMonth();
      update();
    } else {
      Get.snackbar(
        'Failed',
        'Select a year between 1900 and 2100',
        backgroundColor: Color(0xFFE3E6F6),
        colorText: Color(0xff5e54c0),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }

  void previousMonth() {
    focusedDate.value =
        DateTime(focusedDate.value.year, focusedDate.value.month - 1);
    _updateDaysInMonth();
  }

  void nextMonth() {
    focusedDate.value =
        DateTime(focusedDate.value.year, focusedDate.value.month + 1);
    _updateDaysInMonth();
  }

  void selectDate(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);
    if (date.month != focusedDate.value.month) {
      focusedDate.value = DateTime(date.year, date.month, 1);
      _updateDaysInMonth();
    }
    update();
  }

  bool isSelectedDate(DateTime date) {
    return date.year == selectedDate.value.year &&
        date.month == selectedDate.value.month &&
        date.day == selectedDate.value.day;
  }
}
