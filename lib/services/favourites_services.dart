import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static Future<void> addToFavorites(Map<String, String> webtoon) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList('favorites') ?? [];

    if (!favorites.contains(webtoon['title'])) {
      favorites.add(webtoon['title']!);
    }

    await prefs.setStringList('favorites', favorites);

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

  static Future<void> addRating(String title, double rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('rating_$title', rating);
  }

  static Future<double> getUserRating(String title) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('rating_$title') ?? 0.0;
  }

  static Future<void> setAverageRating(
      String title, double averageRating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('average_rating_$title', averageRating);
  }

  static Future<double> getAverageRating(String title) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('average_rating_$title') ?? 0.0;
  }

  static Future<void> updateRatings(String title, double userRating) async {
    await addRating(title, userRating);
    await setAverageRating(title, userRating);
  }
}
