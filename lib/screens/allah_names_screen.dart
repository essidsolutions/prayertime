import 'package:flutter/material.dart';

class AllahNamesScreen extends StatelessWidget {
  final List<Map<String, String>> namesOfAllah = [
    {'arabic': 'الرَّحْمَنُ', 'english': 'Ar-Rahman (The Beneficent)'},
    {'arabic': 'الرَّحِيمُ', 'english': 'Ar-Raheem (The Merciful)'},
    {'arabic': 'الْمَلِكُ', 'english': 'Al-Malik (The King)'},
    // Add all 99 names here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('99 Names of Allah'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: namesOfAllah.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: ListTile(
              title: Text(namesOfAllah[index]['arabic']!),
              subtitle: Text(namesOfAllah[index]['english']!),
            ),
          );
        },
      ),
    );
  }
}
