import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nosso_primeiro_projeto/models/movie.dart';

import '../secrets/secrets.dart';

class TmdbService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = Secrets.tmdbApiKey;

  Future<List<Movie>> discoverMovies() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/discover/movie?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Map<String, dynamic>> results =
          List<Map<String, dynamic>>.from(data['results']);

      List<Movie> movies =
          results.map((movieData) => Movie.fromJson(movieData)).toList();

      return movies;
    } else {
      throw Exception('Erro ao carregar lista de filmes');
    }
  }
}
