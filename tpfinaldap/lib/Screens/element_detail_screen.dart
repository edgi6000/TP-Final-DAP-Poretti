import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tpfinaldap/Providers/ListProvider.dart';

class ElementDetailScreen extends ConsumerWidget {
  final int index; // Indice para acceder al equipo seleccionado

  // Constructor que recibe el índice
  const ElementDetailScreen({required this.index, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(listProvider);

    return Scaffold(
      appBar: AppBar(
        title: listAsync.when(
          data: (list) => Text(list[index].title),
          loading: () => const Text('Cargando'),
          error: (error, stackTrace) => Text('Error: $error'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: listAsync.when(
        data: (list) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagen del equipo
                Image.network(
                  list[index].imagesrc,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),

                // Título del equipo
                Text(
                  list[index].title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Descripción breve del equipo
                Text(
                  list[index].description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),

                // Detalles del equipo
                Text(
                  list[index].text,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}