import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'login_screen.dart'; // Importa tus pantallas
import 'home_screen.dart';
import 'add_element_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/add',
          builder: (context, state) => AddMovieScreen(),
        ),
        GoRoute(
          path: '/detail',
          builder: (context, state) {
            final club = state.extra as DocumentSnapshot; // Pasar el DocumentSnapshot como argumento
            return ElementDetailScreen(club: club);
          },
        ),
      ],
    );

    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}