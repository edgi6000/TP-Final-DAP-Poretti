import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    context.go('/home'); // Cambia a context.go('/home');
  } catch (e) {
    print("Error en el login: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: _emailController, decoration: InputDecoration(hintText: 'Email')),
          TextField(controller: _passwordController, decoration: InputDecoration(hintText: 'Contraseña')),
          ElevatedButton(onPressed: _login, child: Text("Login"))
        ],
      ),
    );
  }
}