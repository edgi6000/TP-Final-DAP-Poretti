import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddMovieScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _addClub() async {
    await FirebaseFirestore.instance.collection('club').add({
      'title': _titleController.text,
      'description': _descriptionController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar Club")),
      body: Column(
        children: [
          TextField(controller: _titleController, decoration: InputDecoration(hintText: 'Título')),
          TextField(controller: _descriptionController, decoration: InputDecoration(hintText: 'Descripción')),
          ElevatedButton(onPressed: () {_addClub(); context.go('/home'); // Regresar a la pantalla de inicio después de agregar
  },
  child: Text("Agregar"),
)
        ],
      ),
    );
  }
}
