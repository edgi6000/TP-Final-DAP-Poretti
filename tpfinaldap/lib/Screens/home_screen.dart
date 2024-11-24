import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tpfinaldap/Providers/ListProvider.dart';
import 'package:tpfinaldap/Providers/UserProvider.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtenemos el estado de la lista de equipos de rugby desde el provider
    var postsAsync = ref.watch(ListProvider);
    // Obtenemos el nombre del usuario desde el provider
    String usuario = ref.watch(UserProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Hola $usuario"), // Muestra el nombre del usuario
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/login'); // Navega a la pantalla de login
              },
              child: const Text("Logout"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: postsAsync.when(
                data: (posts) {
                  // Si los datos se cargan correctamente, mostramos la lista de equipos
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index]; // Cada post es un equipo de rugby

                      return Card(
                        child: ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.description),
                          onTap: () {
                            // Guardamos el índice seleccionado y navegamos a la pantalla de detalle
                            ref.read(pressedProvider.notifier).state = index;
                            context.push('/card');
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () {
                  // Mientras se cargan los datos, mostramos un indicador de carga
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (error, stack) {
                  // Si ocurre un error al cargar los datos, mostramos un mensaje de error
                  return Center(
                    child: Text("Error al cargar equipos: $error"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Cuando se presiona el botón flotante, navegamos a la pantalla de edición
          ref.read(pressedProvider.notifier).state = -1;
          context.push('/edit');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Ubica el botón en la esquina inferior derecha
    );
  }
}

class ListProvider {
}