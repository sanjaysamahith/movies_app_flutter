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
  String? errorMessage;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final data = await tmdbService.fetchMovies();
      setState(() {
        movies = data;
        filteredMovies = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load movies";
        isLoading = false;
      });
    }
  }

  void searchMovies(String query) {
    setState(() {
      searchQuery = query;
      filteredMovies = movies
          .where((movie) => movie['title']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()))
          .toList();
    });
  }

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
    return ids.map((id) => genres[id] ?? "").join(", ");
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),

        leading: filteredMovies.isEmpty && searchQuery.isNotEmpty
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              searchQuery = "";
              filteredMovies = movies;
            });
          },
        )
            : null,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: searchMovies,
              decoration: InputDecoration(
                hintText: "Search movies...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())

          : errorMessage != null
          ? Center(child: Text(errorMessage!))

          : GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount:
        filteredMovies.isEmpty ? 1 : filteredMovies.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          /// 🔴 EMPTY SEARCH STATE
          if (filteredMovies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No movies found"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        searchQuery = "";
                        filteredMovies = movies;
                      });
                    },
                    child: const Text("Back to Movies"),
                  ),
                ],
              ),
            );
          }

          final movie = filteredMovies[index];
          bool isFav = provider.favourites.contains(movie);
          bool isWatch = provider.watchlist.contains(movie);
          double rating = (movie["vote_average"] ?? 0) / 10;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      MovieDetailsScreen(movie: movie),
                ),
              );
            },
            child: Card(
              elevation: 4,
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
                      fit: BoxFit.cover,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      movie['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Text(
                    getGenres(movie["genre_ids"] ?? []),
                    style: const TextStyle(
                        fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 6),

                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: rating,
                          strokeWidth: 5,
                        ),
                        Text(
                          "${(rating * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFav
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.redAccent,
                        ),
                        onPressed: () =>
                            provider.toggleFavourite(movie),
                      ),
                      IconButton(
                        icon: Icon(
                          isWatch
                              ? Icons.watch_later
                              : Icons.watch_later_outlined,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () =>
                            provider.toggleWatchlist(movie),
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