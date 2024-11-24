import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tpfinaldap/Screens/login_screen.dart'; // Importa LoginScreen
import 'package:tpfinaldap/Screens/home_screen.dart';   // Importa HomeScreen
import 'package:tpfinaldap/Screens/element_detail_screen.dart'; // Importa ElementDetailScreen
import 'firebase_options.dart';  // Asegúrate de tener la configuración de Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore App',
      initialRoute: '/login', // Define la ruta inicial
      routes: {
        '/login': (context) => const LoginScreen(),  // Ruta para LoginScreen
        '/home': (context) => const HomeScreen(),    // Ruta para HomeScreen
        '/detail': (context) => const ElementDetailScreen(),  // Ruta para ElementDetailScreen
      },
    );
  }
}