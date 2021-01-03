import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore_example/presentation/utils/StringUtils.dart';
import 'package:flutter_firestore_example/presentation/widgets/alert_dialog_widget.dart';
import 'package:flutter_firestore_example/presentation/widgets/items_widget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> _data = Map<String, dynamic>();
  CollectionReference gameNames =
      FirebaseFirestore.instance.collection('gamenames');

  void updateLocalData(Map<String, dynamic> data) {
    setState(() {
      _data = data;
      _addGame(gameNames);
    });
  }

  Map<String, dynamic> get data => _data;

  @override
  Widget build(BuildContext context) {
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
                        return ItemsWidget(
                          document: document,
                          callback: () {
                            // _updateData(document);
                          },
                        );
                      }).toList(),
                    );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayDialog(context, gameNames);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _displayDialog(BuildContext context, CollectionReference dataBaseName) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialogWidget(
            title: 'Add new game',
            hintName: 'Game name',
            hintRate: 'Game rate',
            hintImage: 'Game url image',
          );
        }).then((val) {
      updateLocalData(val);
    });
  }

  Future<void> _addGame(CollectionReference dataBaseName) async {
    if (data != null)
      return await dataBaseName
          .doc(StringUtils.randomString(20))
          .set({
            'name': data['name'],
            'rate': int.parse(data['rate']),
            'image': data['image']
          })
          .then((value) => print("Game Added"))
          .catchError((error) => print("Failed to add game: $error"));
  }
}

Stream<QuerySnapshot> _getAllDocuments(String dataBaseName) {
  return FirebaseFirestore.instance.collection(dataBaseName).snapshots();
}

void _updateData(DocumentSnapshot document) {
  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot freshSnap = await transaction.get(document.reference);
    transaction.update(freshSnap.reference, {'name': 'Valorant'});
  });
}
