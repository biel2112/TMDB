import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nosso_primeiro_projeto/components/movies.dart';
import 'package:nosso_primeiro_projeto/components/search.dart';
import 'package:nosso_primeiro_projeto/models/movie.dart';
import 'package:nosso_primeiro_projeto/services/tmdb_service.dart';
import 'package:nosso_primeiro_projeto/utils/app_colors.dart';



// ignore: constant_identifier_names
enum MovieOrder { Recent, Alphabetical }

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final TmdbService _tmdbService = TmdbService();
  late List<Movie> _movies;
  late List<Movie> _filteredMovies;
  late MovieOrder _currentOrder;
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _movies = [];
    _filteredMovies = [];
    _currentOrder = MovieOrder.Recent;
    _searchQuery = '';
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final List<Movie> movies = await _tmdbService.discoverMovies();
    _sortMovies(movies);
  }

  void _sortMovies(List<Movie> movies) {
    setState(() {
      _movies = movies;
      _applyFilters();
    });
  }

  void _applyFilters() {
    List<Movie> filteredMovies = List.from(_movies);
    if (_currentOrder == MovieOrder.Alphabetical) {
      filteredMovies.sort((a, b) => a.originalTitle.compareTo(b.originalTitle));
    }
    if (_searchQuery.isNotEmpty) {
      filteredMovies = filteredMovies
          .where((movie) => movie.originalTitle
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredMovies = filteredMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB',
            style:
                GoogleFonts.pacifico(fontSize: 25, color: AppColors.logoColor)),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              _toggleOrder();
            },
            icon: Icon(_currentOrder == MovieOrder.Recent
                ? Icons.access_time
                : Icons.sort_by_alpha),
          ),
          IconButton(
            onPressed: () async {
              final String? query = await showSearch<String>(
                context: context,
                delegate: MovieSearchDelegate(_movies),
              );
              if (query != null) {
                _searchMovies(query);
              }
            },
            icon: const Icon(
              Icons.search,
              size: 25,
            ),
          ),
        ],
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 110.0),
          child: _filteredMovies.isNotEmpty
              ? ListView.builder(
                  itemCount: _filteredMovies.length,
                  itemBuilder: (context, index) {
                    final Movie movie = _filteredMovies[index];
                    return MovieWidget(movie: movie);
                  },
                )
              : const Center(
                  child: Text(
                    'Nenhum filme encontrado.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
        ),
      ),
    );
  }

  void _searchMovies(String query) {
    setState(() {
      _searchQuery = query;
      _applyFilters();
    });
  }

  void _toggleOrder() {
    setState(() {
      _currentOrder = _currentOrder == MovieOrder.Recent
          ? MovieOrder.Alphabetical
          : MovieOrder.Recent;
      _applyFilters();
    });
  }
}

