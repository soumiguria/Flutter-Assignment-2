// import 'package:flutter/material.dart';
// import 'package:ghackk_technologies/services/favourites_services.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class DetailScreen extends StatefulWidget {
//   final Map<String, String> webtoon;

//   DetailScreen({required this.webtoon});

//   @override
//   _DetailScreenState createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   double _currentRating = 0.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.webtoon['title']!)),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset(widget.webtoon['image']!),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Description: A thrilling journey awaits in ${widget.webtoon['title']}...',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () =>
//                   FavoritesService.addToFavorites(widget.webtoon['title']!),
//               child: Text(
//                 'Add to Favorites',
//                 style: TextStyle(color: Colors.white),
//               ),
//               style:
//                   ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
//             ),
//             SizedBox(height: 20),
//             Text('Rate this Webtoon:', style: TextStyle(color: Colors.white)),
//             RatingBar.builder(
//               initialRating: _currentRating,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemBuilder: (context, _) => Icon(
//                 Icons.star,
//                 color: Colors.amber,
//               ),
//               onRatingUpdate: (rating) {
//                 setState(() {
//                   _currentRating = rating;
//                 });
//               },
//             ),
//             SizedBox(height: 10),
//             Text('Current Rating: $_currentRating'),
//           ],
//         ),
//       ),
//     );
//   }
// }




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
                  content: Text('${widget.webtoon['title']} added to favorites!'),
                ));
              },
              child: Text(
                'Add to Favorites',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
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
              },
            ),
            SizedBox(height: 10),
            Text('Current Rating: $_currentRating'),
          ],
        ),
      ),
    );
  }
}
