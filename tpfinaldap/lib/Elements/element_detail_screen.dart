import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ElementDetailScreen extends StatelessWidget {
  final DocumentSnapshot club;

  // Constructor que recibe el DocumentSnapshot
  const ElementDetailScreen({required this.club});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalle del Elemento")),
      body: Column(
        children: [
          Text("Título: ${club['title']}"),  // Asegúrate de acceder a los campos correctamente
          Text("Descripción: ${club['description']}"),
        ],
      ),
    );
  }
}