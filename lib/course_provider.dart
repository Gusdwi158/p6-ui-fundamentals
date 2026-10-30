import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  final Set<String> favorites = {};

  bool isFavorite(String id) {
    return favorites.contains(id);
  }

  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    notifyListeners();
  }

  int get favoriteCount => favorites.length;
}
