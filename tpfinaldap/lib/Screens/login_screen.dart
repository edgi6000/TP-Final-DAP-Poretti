import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tpfinaldap/Providers/UserProvider.dart';

TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuariosAsync = ref.watch(userProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Logueo",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: userController,
              decoration: const InputDecoration(
                hintText: 'Usuario',
                icon: Icon(Icons.person),
              ),
            ),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Contraseña',
                icon: Icon(Icons.key),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                usuariosAsync.when(
                  data: (usuarios) {
                    for (var usuario in usuarios) {
                      if (usuario.email == userController.text &&
                          usuario.password == passController.text) {
                        context.go('/home');
                        ref.read(loggedProvider.notifier).state =
                            userController.text;
                        return;
                      }
                    }

                    // Si no coincide, muestra un mensaje de error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Usuario o contraseña incorrectos"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  loading: () {
                    // Mientras se cargan los usuarios, muestra un mensaje
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Cargando usuarios..."),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  error: (error, _) {
                    // Manejo de errores
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error: $error"),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                );
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

