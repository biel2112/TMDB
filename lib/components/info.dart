import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nosso_primeiro_projeto/models/movie.dart';
import 'package:nosso_primeiro_projeto/utils/app_colors.dart';

class Info extends StatefulWidget {
  final Movie movie;

  const Info({Key? key, required this.movie}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool showFullOverview = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor,
                border: Border.all(color: AppColors.logoColor, width: 4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: 144,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w200${widget.movie.posterPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.movie.originalTitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoSlab(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.titleInfoColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Data de Lançamento: ${widget.movie.releaseDate}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.dateInfoColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            showFullOverview
                                ? widget.movie.overview
                                : _getShortenedOverview(),
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: AppColors.overviewInfoColor),
                          ),
                          const SizedBox(height: 8),
                          if (widget.movie.overview.length > 200)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  showFullOverview = !showFullOverview;
                                });
                              },
                              child: Text(
                                showFullOverview
                                    ? 'Mostrar Menos'
                                    : 'Mostrar Mais',
                                style: const TextStyle(
                                  color: AppColors.logoColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getShortenedOverview() {
    return widget.movie.overview.length > 200
        ? '${widget.movie.overview.substring(0, 200)}...'
        : widget.movie.overview;
  }
}
