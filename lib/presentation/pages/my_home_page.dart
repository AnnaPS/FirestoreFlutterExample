import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore_example/presentation/pages/widgets/items_widget.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference gameNames =
        FirebaseFirestore.instance.collection('gamenames');
    return Scaffold(
      appBar: AppBar(
        title: Text('Games'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getAllDocuments('gamenames'),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return (snapshot.hasError)
              ? Center(
                  child: Text(
                  'Something went wrong',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ))
              : (snapshot.connectionState == ConnectionState.waiting)
                  ? CircularProgressIndicator()
                  : ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return ItemsWidget(document);
                      }).toList(),
                    );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addGame(gameNames);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

Stream<QuerySnapshot> _getAllDocuments(String dataBaseName) {
  return FirebaseFirestore.instance.collection(dataBaseName).snapshots();
}

Future<Transaction> _updateData(DocumentSnapshot document) {
  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot freshSnap = await transaction.get(document.reference);
    await transaction
        .update(freshSnap.reference, {'Rocket league': freshSnap['name']});
  });
}

Future<void> _addGame(CollectionReference dataBaseName) {
  return dataBaseName
      .doc(Random().toString())
      .set({
        'name': "Rocket league",
        'rate': 5,
        'image':
            'https://assets.tonica.la/__export/1595441950093/sites/debate/img/2020/07/22/rocket-league-serx-free-to-play.jpg_759710130.jpg'
      })
      .then((value) => print("Game Added"))
      .catchError((error) => print("Failed to add game: $error"));
}
