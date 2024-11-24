import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tpfinaldap/Entities/User.dart';

// Instancia de Firebase Firestore
final FirebaseFirestore db = FirebaseFirestore.instance;

// Función para obtener usuarios desde Firestore
Stream<List<User>> fetchUsersFromFirestore() {
  return db.collection('user').doc('auth').snapshots().map((snapshot) {
    final usuarios = <User>[];
    final data = snapshot.data();
    if (data != null) {
      for (var element in data.entries) {
        usuarios.add(User(email: element.key, password: element.value));
      }
    }
    return usuarios;
  });
}

// Proveedor para usuarios
final userProvider = StreamProvider<List<User>>((ref) {
  return fetchUsersFromFirestore();
});

// Proveedor para el estado de login
final loggedProvider = StateProvider<String?>((ref) => null);