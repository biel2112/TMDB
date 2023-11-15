class Movie {
  final int id;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final String title;
  final double voteAverage;
  final String posterPath;
  final int voteCount;

  Movie(
      {required this.id,
      required this.originalTitle,
      required this.overview,
      required this.releaseDate,
      required this.title,
      required this.voteAverage,
      required this.posterPath,
      required this.voteCount});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      title: json['title'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      posterPath: json['poster_path'] ?? '',
      voteCount: (json['vote_count'] as num).toInt(),
    );
  }
}
