import 'package:flutter/material.dart';
import 'package:ghackk_technologies/services/favourites_services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, String> webtoon;

  DetailScreen({required this.webtoon});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _currentRating = 0.0;
  double _averageRating = 0.0;

  @override
  void initState() {
    super.initState();
    _loadAverageRating();
  }

  Future<void> _loadAverageRating() async {
    double averageRating =
        await FavoritesService.getAverageRating(widget.webtoon['title']!);
    setState(() {
      _averageRating = averageRating;
    });
  }

  Future<void> _rateWebtoon(double rating) async {
    await FavoritesService.addRating(widget.webtoon['title']!, rating);
    await _loadAverageRating();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('You rated ${widget.webtoon['title']} $rating stars!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.webtoon['title']!)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.webtoon['image']!),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Description: A thrilling journey awaits in ${widget.webtoon['title']}...',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Add the webtoon to favorites
                await FavoritesService.addToFavorites({
                  'title': widget.webtoon['title']!,
                  'image': widget.webtoon['image']!,
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text('${widget.webtoon['title']} added to favorites!'),
                ));
              },
              child: Text(
                'Add to Favorites',
                style: TextStyle(color: Colors.white),
              ),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            ),
            SizedBox(height: 20),
            Text('Rate this Webtoon:', style: TextStyle(color: Colors.white)),
            RatingBar.builder(
              initialRating: _currentRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _currentRating = rating;
                });
                _rateWebtoon(rating); // Store the rating and update the average
              },
            ),
            SizedBox(height: 10),
            Text(
              'Your Rating: $_currentRating',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Average Rating: $_averageRating',
              style: TextStyle(fontSize: 18, color: Colors.amber),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
