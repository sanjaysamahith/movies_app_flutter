import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  List favourites = [];
  List watchlist = [];

  bool isFavourite(dynamic movie) {
    return favourites.any((m) => m['id'] == movie['id']);
  }

  bool isInWatchlist(dynamic movie) {
    return watchlist.any((m) => m['id'] == movie['id']);
  }

  void toggleFavourite(dynamic movie) {
    if (isFavourite(movie)) {
      favourites.removeWhere((m) => m['id'] == movie['id']);
    } else {
      favourites.add(movie);
    }
    notifyListeners();
  }

  void toggleWatchlist(dynamic movie) {
    if (isInWatchlist(movie)) {
      watchlist.removeWhere((m) => m['id'] == movie['id']);
    } else {
      watchlist.add(movie);
    }
    notifyListeners();
  }
}
