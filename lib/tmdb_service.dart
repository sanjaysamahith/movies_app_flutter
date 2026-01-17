import 'dart:convert';
import 'package:http/http.dart' as http;

class TMDBService {
  final String apiKey = "5892d800e3b5d0ef7f232e0dc66fb1c1";

  Future<List<dynamic>> fetchMovies() async {
    final url = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["results"];
    } else {
      throw Exception("Failed to load movies");
    }
  }
}