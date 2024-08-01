import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dhikr_screen.dart';

class PrayerTimesScreen extends StatefulWidget {
  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  Map<String, dynamic>? prayerTimes;
  LocationData? _currentPosition;
  Location location = Location();

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
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _getLocation,
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DhikrScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: prayerTimes == null
            ? CircularProgressIndicator()
            : ListView(
          children: prayerTimes!.entries.map((entry) {
            return ListTile(
              title: Text(entry.key),
              subtitle: Text(entry.value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
