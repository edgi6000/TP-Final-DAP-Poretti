import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tpfinaldap/Providers/ListProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tpfinaldap/Entities/Post.dart';

class EditScreen extends ConsumerWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(listProvider);
    final pressed = ref.watch(pressedProvider);
    
    // Inicialización de las variables
    String title = '';
    String imagesrc = '';
    late TextEditingController title_controller;
    late TextEditingController description_controller;
    late TextEditingController text_controller;
    late TextEditingController imgsrc_controller;

    if (pressed == -1) {
      // Si no hay elemento seleccionado, es un nuevo elemento
      title = 'Nuevo Club';
      title_controller = TextEditingController();
      description_controller = TextEditingController();
      text_controller = TextEditingController();
      imgsrc_controller = TextEditingController();
      imagesrc =
          'https://upload.wikimedia.org/wikipedia/commons/8/85/Logo_lpf_afa.png'; // Logo predeterminado
    } else {
      // Si ya hay un equipo seleccionado, cargamos sus datos
      listAsync.when(
        data: (list) {
          title = list[pressed].title;
          title_controller = TextEditingController(text: list[pressed].title);
          description_controller =
              TextEditingController(text: list[pressed].description);
          text_controller = TextEditingController(text: list[pressed].text);
          imgsrc_controller =
              TextEditingController(text: list[pressed].imagesrc);
          imagesrc = list[pressed].imagesrc;
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Imagen de muestra
                Image.network(
                  imagesrc,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                
                // Título
                TextField(
                  controller: title_controller,
                  decoration: const InputDecoration(
                    labelText: "Nombre del Club",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                
                // Descripción
                TextField(
                  controller: description_controller,
                  decoration: const InputDecoration(
                    labelText: "Descripción",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                
                // Texto descriptivo
                TextField(
                  controller: text_controller,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: "Texto descriptivo",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                
                // URL de la imagen
                TextField(
                  controller: imgsrc_controller,
                  decoration: const InputDecoration(
                    labelText: "URL de la Imagen",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Botón para guardar
                ElevatedButton(
                    onPressed: () async {
                      listAsync.when(
                        data: (list) async {
                          if (pressed != -1) {
                            // Editamos un club existente
                            final updatedPost = Post(
                              title: title_controller.text,
                              description: description_controller.text,
                              text: text_controller.text,
                              imagesrc: imgsrc_controller.text,
                            );
                            
                            // Actualizamos el club en Firestore
                            await FirebaseFirestore.instance
                                .collection('club')
                                .doc(list[pressed].id) // Usamos el id para identificar el documento
                                .update({
                              'title': updatedPost.title,
                              'description': updatedPost.description,
                              'text': updatedPost.text,
                              'imagesrc': updatedPost.imagesrc,
                            });
                            context.go('/home');
                          } else {
                            // Si no hay selección, creamos un nuevo club
                            if (title_controller.text == '' ||
                                description_controller.text == '' ||
                                text_controller.text == '' ||
                                imgsrc_controller.text == '') {
                              // Validación de campos vacíos
                              SnackBar snackBar = const SnackBar(
                                content:
                                    Text("Todos los campos son obligatorios"),
                                duration: Duration(seconds: 3),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              // Agregamos un nuevo club
                              await FirebaseFirestore.instance
                                  .collection('club')
                                  .add({
                                'title': title_controller.text,
                                'description': description_controller.text,
                                'text': text_controller.text,
                                'imagesrc': imgsrc_controller.text,
                              });
                              context.push('/home');
                            }
                          }
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stackTrace) => Text('Error: $error'),
                      );
                    },
                    child: const Text("Guardar")),
              ],
            ),
          ),
        ));
  }
}