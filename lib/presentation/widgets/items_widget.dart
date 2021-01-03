import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemsWidget extends StatefulWidget {
  final DocumentSnapshot document;
  final VoidCallback callback;
  const ItemsWidget({Key key, @required this.document, @required this.callback})
      : assert(document != null),
        assert(callback != null),
        super(key: key);

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.callback(),
      child: Container(
        height: 200,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.hardEdge,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          shadowColor: Colors.blueGrey,
          margin: EdgeInsets.all(16),
          child: Stack(children: [
            Container(
              width: double.infinity,
              child: Image(
                image: NetworkImage(widget.document.data()['image']),
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.black87,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.amber,
                        size: 30,
                      ),
                      Text(
                        widget.document.data()['rate'].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        widget.document.data()['name'],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
