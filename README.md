# Webtoon Explorer App

Welcome to the **Webtoon Explorer App**! This Flutter-based mobile application allows users to browse popular webtoon categories, view detailed information about each webtoon, save their favorites, and rate their favorite webtoons. The app is fully equipped with persistent storage for user favorites and ratings using Flutter's SharedPreferences package, ensuring that user data is stored locally across sessions.

## Features

### 1. **Home Screen: Browse Webtoon Categories**
   - Displays a list of top webtoon categories inspired by "Top 10 Popular Webtoons with Over 50 Million Views".
   - Each category includes a **title** and a **thumbnail image**.
   - Categories are listed dynamically and visually, making it easy for users to explore various webtoons.

### 2. **Detail Screen: Webtoon Information**
   - Upon selecting a category, users are navigated to the detail screen of a specific webtoon.
   - Example webtoon: **"Lore Olympus Webtoon: Jaw Dropping Seen on Media"**.
   - This screen includes:
     - A high-quality image of the webtoon.
     - A brief description.
     - A button to add the webtoon to **Favorites**.
   - Users can rate the webtoon using a 1-5 star rating system, with the rating stored locally.

### 3. **Favorites Screen: Manage Favorite Webtoons**
   - Users can view their saved favorite webtoons.
   - Favorites are stored locally using Flutter's **SharedPreferences** package, ensuring persistence across app restarts.
   - Users can view each webtoon’s details or remove them from favorites.

### 4. **Rating Feature**
   - Users can rate their favorite webtoons with a **1 to 5-star rating** system.
   - The app dynamically calculates and displays the **average rating** on the detail screen.
   - The user's rating and the average rating are both stored locally using SharedPreferences.

## Screenshots



## Installation

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/soumiguria/Flutter-Assignment-2.git

## Navigate to the project directory:

    ```bash
    cd Flutter-Assignment-2

    flutter pub get

    flutter run
    ```

## Technologies Used

- **Flutter**: Framework for building natively compiled applications for mobile.
- **Dart**: Programming language for Flutter.
- **SharedPreferences**: Used for local, persistent storage.
- **flutter_rating_bar**: For implementing the rating feature.

## How the App Works

### Home Screen:
- Displays top webtoon categories with an image and title.
- On selecting a category, users are navigated to the **Detail Screen**.

### Detail Screen:
- Users can see detailed information about the selected webtoon.
- A button allows users to add or remove the webtoon from their **Favorites**.
- Users can also rate the webtoon (1-5 stars) using the rating bar, and the rating is saved locally.

### Favorites Screen:
- Shows the list of webtoons added to favorites.
- Data is persistent, so even if the app is closed and reopened, the user's favorites and ratings are stored.

### Persistent Storage:
- All favorites and ratings are stored using **SharedPreferences** to ensure that user preferences persist across app sessions.

## Future Improvements

- **Hive Integration**: For more efficient local storage and to support storing additional metadata.
- **Search Functionality**: Adding a search bar to filter webtoons.
- **Cloud Sync**: Integrating cloud storage (e.g., Firebase) to sync favorites across multiple devices.