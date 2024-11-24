import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tpfinaldap/Entities/Post.dart';

var db = FirebaseFirestore.instance;

class MoviesNotifier extends StateNotifier<List<Post>> {
  MoviesNotifier() : super([]);

  Stream<List<Post>> getTeams() {
    return db.collection('teams').doc('teams').snapshots().map((snapshot) {
      List<Post> posts = [];
      var data = snapshot.data();
      if (data != null) {
        for (var element in data.entries) {
          posts.add(Post(
            title: element.key,
            description: element.value[0],
            text: element.value[1],
            imagesrc: element.value[2],
          ));
        }
      }
      return posts.reversed.toList(); // Invertimos para mostrar los equipos más recientes primero
    });
  }

  Future<void> addTeam(List<Post> teams) async {
    final doc = db.collection('teams').doc('teams');
    try {
      var upload = <String, dynamic>{};
      for (var team in teams) {
        upload[team.title] = [
          team.description,
          team.text,
          team.imagesrc,
        ];
      }
      await doc.set(upload);
    } catch (e) {
      print(e);
    }
  }
}

final listProvider = StreamProvider<List<Post>>((ref) {
  return MoviesNotifier().getTeams(); // Utiliza el método `getTeams` para obtener los equipos
});