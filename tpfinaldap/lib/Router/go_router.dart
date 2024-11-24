import 'package:go_router/go_router.dart';
import 'package:tpfinaldap/screens/login_screen.dart';
import 'package:tpfinaldap/screens/home_screen.dart';
import 'package:tpfinaldap/screens/element_detail_screen.dart';
import 'package:tpfinaldap/screens/add_element_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/card',
      builder: (context, state) => const ElementDetailScreen(),
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) => const EditScreen(),
    ),
  ],
);