import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static Future<void> addToFavorites(Map<String, String> webtoon) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList('favorites') ?? [];

    if (!favorites.contains(webtoon['title'])) {
      favorites.add(webtoon['title']!); // Use the title for storing
    }

    await prefs.setStringList('favorites', favorites);

    // Save webtoon details separately
    await prefs.setString(webtoon['title']!, webtoon['image']!);
  }

  static Future<List<Map<String, String>>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList('favorites') ?? [];
    List<Map<String, String>> favoriteItems = [];

    for (String title in favorites) {
      String? image = prefs.getString(title);
      if (image != null) {
        favoriteItems.add({'title': title, 'image': image});
      }
    }

    return favoriteItems;
  }

  // Store the rating for a specific webtoon
  static Future<void> addRating(String title, double rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('rating_$title', rating); // Store the rating by title
  }

  // Retrieve the user's rating for a specific webtoon
  static Future<double> getUserRating(String title) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('rating_$title') ??
        0.0; // Return 0 if no rating exists
  }

  // Retrieve the average rating for a webtoon (for now, it's based only on the user's local rating)
  static Future<double> getAverageRating(String title) async {
    // This is a placeholder since average rating from multiple users is not stored
    return await getUserRating(title);
  }
}
