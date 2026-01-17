import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tmdb_service.dart';
import 'movie_provider.dart';
import 'movie_details_screen.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final TMDBService tmdbService = TMDBService();

  List movies = [];
  List filteredMovies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  void loadMovies() async {
    final result = await tmdbService.fetchMovies();
    setState(() {
      movies = result;
      filteredMovies = result;
      isLoading = false;
    });
  }

  void searchMovies(String query) {
    final results = movies.where((movie) {
      return movie["title"].toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredMovies = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: searchMovies,
              decoration: const InputDecoration(
                hintText: "Search movies...",
                filled: true,
              ),
            ),
          ),
        ),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: filteredMovies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
        ),

        itemBuilder: (context, index) {
          final movie = filteredMovies[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetailsScreen(movie: movie),
                ),
              );
            },

            child: Card(
              color: Colors.white,
              elevation: 3,
              child: Column(
                children: [
                  Image.network(
                    "https://image.tmdb.org/t/p/w500${movie["poster_path"]}",
                    height: 180,
                    fit: BoxFit.cover,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      movie["title"],
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          provider.favourites.contains(movie)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          provider.addFavourite(movie);
                        },
                      ),

                      IconButton(
                        icon: Icon(
                          provider.watchlist.contains(movie)
                              ? Icons.watch_later
                              : Icons.watch_later_outlined,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {
                          provider.addWatchlist(movie);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
