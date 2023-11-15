import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nosso_primeiro_projeto/components/info.dart';
import 'package:nosso_primeiro_projeto/models/movie.dart';
import 'package:nosso_primeiro_projeto/utils/app_colors.dart';

class InfoScreen extends StatelessWidget {
  final Movie movie;

  const InfoScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TMDB',
          style: GoogleFonts.pacifico(fontSize: 25, color: AppColors.logoColor),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
          color: AppColors.backgroundColor,
          height: 1200,
          child: Info(movie: movie)),
    );
  }
}
