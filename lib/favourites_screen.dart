import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    if (provider.favourites.isEmpty) {
      return const Scaffold(body: Center(child: Text("No favourites yet")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Favourites")),
      body: ListView.builder(
        itemCount: provider.favourites.length,
        itemBuilder: (context, index) {
          final movie = provider.favourites[index];
          return ListTile(title: Text(movie["title"]));
        },
      ),
    );
  }
}