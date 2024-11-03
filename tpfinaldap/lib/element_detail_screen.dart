import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MovieDetailScreen extends StatelessWidget {
  final DocumentSnapshot club;

  MovieDetailScreen({required this.club});

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _editMovie() async {
    await FirebaseFirestore.instance.collection('movies').doc(club.id).update({
      'title': _titleController.text,
      'description': _descriptionController.text,
    });
  }

  Future<void> _deleteMovie() async {
    await FirebaseFirestore.instance.collection('movies').doc(club.id).delete();
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = club['title'];
    _descriptionController.text = club['description'];

    return Scaffold(
      appBar: AppBar(title: Text("Detalle de Película")),
      body: Column(
        children: [
          TextField(controller: _titleController),
          TextField(controller: _descriptionController),
          ElevatedButton(onPressed: _editMovie, child: Text("Guardar cambios")),
          ElevatedButton(onPressed: _deleteMovie, child: Text("Eliminar")),
        ],
      ),
    );
  }
}