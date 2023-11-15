import 'package:flutter/material.dart';

import 'package:nosso_primeiro_projeto/screens/initial_screen.dart';
import 'package:nosso_primeiro_projeto/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          hintColor: AppColors.secondaryColor,
        ),
        home: const InitialScreen());
  }
}
