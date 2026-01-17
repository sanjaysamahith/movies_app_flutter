import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Map movie;

  const MovieDetailsScreen({super.key, required this.movie});

  static final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void showNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'movie_channel',
      'Movie Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(
      0,
      "Movie is Playing",
      "Enjoy your movie!",
      notificationDetails,
    );
  }

  /// Genre ID → Name Mapping
  String getGenres(List ids) {
    Map<int, String> genres = {
      28: "Action",
      12: "Adventure",
      16: "Animation",
      35: "Comedy",
      80: "Crime",
      18: "Drama",
      14: "Fantasy",
      27: "Horror",
      10749: "Romance",
      878: "Sci-Fi",
      53: "Thriller",
    };

    List<String> names = ids.map((id) => genres[id] ?? "Unknown").toList();
    return names.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    double rating = (movie["vote_average"] ?? 0) / 10;

    return Scaffold(
      appBar: AppBar(title: Text(movie["title"])),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Movie Banner
            Image.network(
              "https://image.tmdb.org/t/p/w500${movie["poster_path"]}",
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Movie Name
                  Text(
                    movie["title"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Release Date
                  Text("Release Date: ${movie["release_date"]}"),

                  const SizedBox(height: 6),

                  /// Genre
                  Text("Genre: ${getGenres(movie["genre_ids"] ?? [])}"),

                  const SizedBox(height: 16),

                  /// Circular Progress Bar rating
                  Row(
                    children: [
                      const Text("User Rating: "),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          value: rating,
                          strokeWidth: 5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text("${(rating * 100).toStringAsFixed(0)}%"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Overview
                  Text(movie["overview"] ?? "No description available"),

                  const SizedBox(height: 25),

                  ///  Notification
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Play Now"),
                      onPressed: () {
                        showNotification();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Movie is Playing")),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}