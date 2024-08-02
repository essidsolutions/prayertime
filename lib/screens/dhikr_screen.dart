import 'package:flutter/material.dart';

class DhikrScreen extends StatelessWidget {
  final List<Map<String, String>> dhikrList = [
    {'arabic': 'سُبْحَانَ ٱللَّٰهِ', 'english': 'SubhanAllah'},
    {'arabic': 'ٱلْحَمْدُ لِلَّٰهِ', 'english': 'Alhamdulillah'},
    {'arabic': 'لَا إِلٰهَ إِلَّا ٱللَّٰهُ', 'english': 'La ilaha illallah'},
    {'arabic': 'ٱللَّٰهُ أَكْبَرُ', 'english': 'Allahu Akbar'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dhikr'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: dhikrList.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: ListTile(
              title: Text(dhikrList[index]['arabic']!),
              subtitle: Text(dhikrList[index]['english']!),
            ),
          );
        },
      ),
    );
  }
}
