import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Importa go_router

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clubes")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Clubs').snapshots(),
        builder: (context, snapshot) {
          // Verificar si hay datos en el snapshot
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Mostrar indicador mientras se carga
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error al cargar los datos"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No hay clubes disponibles"));
          }

          // Aquí obtenemos los documentos de la colección
          final clubs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: clubs.length,
            itemBuilder: (context, index) {
              var club = clubs[index]; // Acceso a un DocumentSnapshot

              // Asegúrate de que los campos que estás utilizando existan en Firestore
              return ListTile(
                title: Text(club['title'] ?? 'Sin título'),
                subtitle: Text(club['description'] ?? 'Sin descripción'),
                onTap: () {
                  // Navegar a la pantalla de detalle y pasar el DocumentSnapshot
                  context.push('/detail', extra: club);
                },
              );
            },
          );
        },
      ),
    );
  }
}