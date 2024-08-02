import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrayerTimesScreen extends StatefulWidget {
  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  Map<String, dynamic>? prayerTimes;
  LocationData? _currentPosition;
  Location location = Location();

  final Map<String, IconData> prayerIcons = {
    'Fajr': Icons.wb_sunny,
    'Dhuhr': Icons.brightness_5,
    'Asr': Icons.brightness_6,
    'Maghrib': Icons.brightness_3,
    'Isha': Icons.nightlight_round,
  };

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _getPrayerTimes();
  }

  _getPrayerTimes() async {
    if (_currentPosition != null) {
      final response = await http.get(Uri.parse(
          'https://api.aladhan.com/v1/timings/${DateTime.now().millisecondsSinceEpoch ~/ 1000}?latitude=${_currentPosition!.latitude}&longitude=${_currentPosition!.longitude}&method=2'));
      if (response.statusCode == 200) {
        setState(() {
          prayerTimes = json.decode(response.body)['data']['timings'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Times'),
      ),
      body: Center(
        child: prayerTimes == null
            ? CircularProgressIndicator()
            : ListView(
          padding: EdgeInsets.all(8.0),
          children: prayerTimes!.entries
              .where((entry) => entry.key != "Imsak" && entry.key != "Midnight" && entry.key != "Firstthird")
              .map((entry) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: ListTile(
                leading: Icon(prayerIcons[entry.key] ?? Icons.access_time),
                title: Text('${entry.key} - ${entry.value}'),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
