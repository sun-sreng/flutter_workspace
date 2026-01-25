import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
  String toCustomString() {
    String period = this.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hourOfPeriod.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}
