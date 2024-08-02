import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YouTubeVideoScreen extends StatelessWidget {
  final List<Map<String, String>> videos = [
    {
      'thumbnail': 'https://img.youtube.com/vi/VIDEO_ID_1/0.jpg',
      'url': 'https://www.youtube.com/live/dcUCik12LX4?si=0DyzxSDXrD5YgXj5'
    },
    {
      'thumbnail': 'https://img.youtube.com/vi/VIDEO_ID_2/0.jpg',
      'url': 'https://www.youtube.com/live/dcUCik12LX4?si=0DyzxSDXrD5YgXj5'
    },
    {
      'thumbnail': 'https://img.youtube.com/vi/VIDEO_ID_3/0.jpg',
      'url': 'https://www.youtube.com/live/dcUCik12LX4?si=0DyzxSDXrD5YgXj5'
    },
    // Add more videos as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Videos'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              final url = videos[index]['url']!;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Card(
              child: Image.network(
                videos[index]['thumbnail']!,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
