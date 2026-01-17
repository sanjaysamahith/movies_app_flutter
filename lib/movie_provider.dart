import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  List favourites = [];
  List watchlist = [];

  void addFavourite(movie) {
    if (!favourites.contains(movie)) {
      favourites.add(movie);
      notifyListeners();
    }
  }

  void addWatchlist(movie) {
    if (!watchlist.contains(movie)) {
      watchlist.add(movie);
      notifyListeners();
    }
  }
}