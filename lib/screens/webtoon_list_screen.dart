import 'package:flutter/material.dart';
import 'detail_screen.dart';

class WebtoonsListScreen extends StatelessWidget {
  final String genre;

  WebtoonsListScreen({required this.genre});

  final Map<String, List<Map<String, String>>> webtoonsByGenre = {
    'Thriller': [
      {'title': 'Sweet Home', 'image': 'assets/webtoons/sweet_home.webp'},
      {'title': 'Bastard', 'image': 'assets/webtoons/bastard.jfif'},
    ],
    'Fantasy': [
      {'title': 'Tower of God', 'image': 'assets/webtoons/tower_of_god'},
      {'title': 'Noblesse', 'image': 'assets/webtoons/noblesse.jfif'},
    ],
    'Romance': [
      {'title': 'Lore Olympus', 'image': 'assets/webtoons/lore_olympus'},
      {'title': 'Let’s Play', 'image': 'assets/webtoons/lets_play.jfif'},
    ],
    'Action': [
      {'title': 'Sweet Home', 'image': 'assets/webtoons/sweet_home.webp'},
      {'title': 'Bastard', 'image': 'assets/webtoons/bastard.jfif'},
    ],
    'Horror': [
      {'title': 'Tower of God', 'image': 'assets/webtoons/tower_of_god'},
      {'title': 'Noblesse', 'image': 'assets/webtoons/noblesse.jfif'},
    ],
    'Comedy': [
      {'title': 'Lore Olympus', 'image': 'assets/webtoons/lore_olympus'},
      {'title': 'Let’s Play', 'image': 'assets/webtoons/lets_play.jfif'},
    ],
    'Fiction': [
      {'title': 'Sweet Home', 'image': 'assets/webtoons/sweet_home.webp'},
      {'title': 'Bastard', 'image': 'assets/webtoons/bastard.jfif'},
    ],
    'School Life': [
      {'title': 'Tower of God', 'image': 'assets/webtoons/tower_of_god'},
      {'title': 'Noblesse', 'image': 'assets/webtoons/noblesse.jfif'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final webtoons = webtoonsByGenre[genre] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$genre Webtoons',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: webtoons.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 6,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    webtoons[index]['image']!,
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                ),
                title: Text(
                  webtoons[index]['title']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.deepPurple,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(webtoon: webtoons[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
