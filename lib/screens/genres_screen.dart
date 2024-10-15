import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ghackk_technologies/screens/video_screen.dart';
import 'package:provider/provider.dart';
import 'package:ghackk_technologies/provider/theme_provider.dart';
import 'package:ghackk_technologies/screens/webtoon_list_screen.dart';
import 'package:ghackk_technologies/screens/favourites_screen.dart';
import 'package:ghackk_technologies/services/favourites_services.dart';

class FloatingCard {
  Offset position;
  Offset velocity;

  FloatingCard(this.position, this.velocity);
}

class GenresScreen extends StatefulWidget {
  @override
  _GenresScreenState createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> genres = [
    {'title': 'Romance', 'image': 'assets/webtoons/romance.jfif'},
    {'title': 'Fantasy', 'image': 'assets/webtoons/fantasy.jfif'},
    {'title': 'Action', 'image': 'assets/webtoons/action.jfif'},
    {'title': 'Thriller', 'image': 'assets/webtoons/thriller.jfif'},
    {'title': 'Horror', 'image': 'assets/webtoons/horror.jfif'},
    {'title': 'Comedy', 'image': 'assets/webtoons/comedy.webp'},
    {'title': 'Fiction', 'image': 'assets/webtoons/fiction.jfif'},
    {'title': 'School Life', 'image': 'assets/webtoons/school_life.jfif'},
  ];

  late Timer _timer;
  List<FloatingCard> _floatingCards = [];
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _initializeFloatingCards();
    _startAnimation();
  }

  void _initializeFloatingCards() {
    final random = Random();
    _floatingCards = List.generate(genres.length, (index) {
      return FloatingCard(
        Offset(random.nextDouble() * 300, random.nextDouble() * 500),
        Offset(
            (random.nextDouble() - 0.5) * 5, (random.nextDouble() - 0.5) * 5),
      );
    });
  }

  void _startAnimation() {
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (!_isTapped) {
        setState(() {
          for (var card in _floatingCards) {
            card.position += card.velocity;

            // Bounce off walls (Assuming a screen size of 300x500 for simplicity)
            if (card.position.dx <= 0 || card.position.dx >= 300) {
              card.velocity = Offset(-card.velocity.dx, card.velocity.dy);
            }
            if (card.position.dy <= 0 || card.position.dy >= 500) {
              card.velocity = Offset(card.velocity.dx, -card.velocity.dy);
            }
          }
        });
      }
    });
  }

  void _alignCards() {
    setState(() {
      const double spacing = 170;
      for (var i = 0; i < _floatingCards.length; i++) {
        final row = i ~/ 2; // Two cards per row
        final col = i % 2;

        _floatingCards[i].position =
            Offset(col * spacing + 50, row * spacing + 50);
        _floatingCards[i].velocity = Offset.zero; // Stop movement
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Webtoon Genres',
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
              color: Colors.white,
            ),
            onPressed: () {
              themeProvider.toggleTheme(!themeProvider.isDarkMode);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (!_isTapped) {
                _alignCards(); // Align the cards when the screen is tapped
              }
            },
            child: Stack(
              children: _floatingCards.map((floatingCard) {
                final index = _floatingCards.indexOf(floatingCard);
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  left: floatingCard.position.dx,
                  top: floatingCard.position.dy,
                  child: GestureDetector(
                    onTap: () {
                      if (!_isTapped) {
                        _alignCards();
                      }
                      // Navigate to the VideoScreen first, and then to the WebtoonsListScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoScreen(
                            genre: genres[index][
                                'title']!, // Pass the genre to the video screen
                            nextScreen: WebtoonsListScreen(
                              genre: genres[index]['title']!,
                            ),
                          ),
                        ),
                      );
                    },
                    // onLongPress: () async {
                    //   // Add the webtoon to favorites on long press
                    //   await FavoritesService.addToFavorites(
                    //       genres[index]['title']!);
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: Text(
                    //         '${genres[index]['title']} added to favorites!'),
                    //   ));
                    // },

                    // Inside your _GenresScreenState class

                    onLongPress: () async {
                      await FavoritesService.addToFavorites({
                        'title': genres[index]['title']!,
                        'image': genres[index]['image']!,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            '${genres[index]['title']} added to favorites!'),
                      ));
                    },

                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              genres[index]['image']!,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                            Container(
                              color: Colors.transparent,
                              child: Text(
                                genres[index]['title']!,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.blueGrey,
                                      offset: Offset(3.0, 3.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritesScreen(),
                    ),
                  );
                },
                child: Text('View Favorites'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
