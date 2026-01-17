import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';
import 'movie_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: const MoviesApp(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),

      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE3F2FD), // Light Blue Background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF64B5F6), // Soft Blue AppBar
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
