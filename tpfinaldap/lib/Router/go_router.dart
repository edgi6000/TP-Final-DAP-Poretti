import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tpfinaldap/Elements/add_element_screen.dart';
import 'package:tpfinaldap/Screens/home_screen.dart';
import 'package:tpfinaldap/Screens/login_screen.dart';
import 'package:tpfinaldap/Elements/element_detail_screen.dart';  // Asegúrate de importar ElementDetailScreen

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
            final club = state.extra as DocumentSnapshot;  // Obtener el DocumentSnapshot
            return ElementDetailScreen(club: club);  // Pasar el snapshot a la pantalla de detalle
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