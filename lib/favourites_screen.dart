import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart';
import 'movie_details_screen.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    if (provider.favourites.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No favourites yet")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Favourites")),
      body: ListView.builder(
        itemCount: provider.favourites.length,
        itemBuilder: (context, index) {
          final movie = provider.favourites[index];

          return ListTile(
            leading: Image.network(
              "https://image.tmdb.org/t/p/w200${movie["poster_path"]}",
              width: 50,
              fit: BoxFit.cover,
            ),
            title: Text(movie["title"]),
            trailing: const Icon(Icons.favorite, color: Colors.red),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetailsScreen(movie: movie),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
