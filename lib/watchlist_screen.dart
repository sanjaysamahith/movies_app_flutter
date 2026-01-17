import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    if (provider.watchlist.isEmpty) {
      return const Scaffold(body: Center(child: Text("No watchlist yet")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Watchlist")),
      body: ListView.builder(
        itemCount: provider.watchlist.length,
        itemBuilder: (context, index) {
          final movie = provider.watchlist[index];
          return ListTile(title: Text(movie["title"]));
        },
      ),
    );
  }
}