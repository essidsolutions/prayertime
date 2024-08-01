import 'package:flutter/material.dart';
import 'screens/prayer_times_screen.dart';
import 'screens/dhikr_screen.dart';

void main() {
  runApp(PrayerApp());
}

class PrayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer Times & Dhikr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrayerTimesScreen(),
    );
  }
}
