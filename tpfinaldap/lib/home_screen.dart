import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clubes")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Clubes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var Clubes = snapshot.data.docs[index];
              return ListTile(
                title: Text(Clubes['title']),
                subtitle: Text(Clubes['description']),
                onTap: () {
  context.go('/detail', extra: Clubes); // Pasa el DocumentSnapshot como extra
},
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/add'),
      ),
    );
  }
}

extension on Object? {
  get docs => null;
}