import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/models/movie.dart';

class MovieSearchDelegate extends SearchDelegate<String> {
  final List<Movie> movies;

  MovieSearchDelegate(this.movies);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Movie> suggestions = movies
        .where((movie) =>
            movie.originalTitle.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final Movie movie = suggestions[index];
        return ListTile(
          title: Text(movie.originalTitle),
          onTap: () {
            close(context, movie.originalTitle);
          },
        );
      },
    );
  }
}
