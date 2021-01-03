import 'package:flutter/material.dart';

class AlertDialogWidget extends StatefulWidget {
  final String title;
  final String hintName;
  final String hintRate;
  final String hintImage;
  const AlertDialogWidget({
    Key key,
    @required this.title,
    @required this.hintName,
    @required this.hintRate,
    @required this.hintImage,
  })  : assert(title != null),
        assert(hintName != null),
        assert(hintRate != null),
        assert(hintImage != null),
        super(key: key);

  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  final _textFiledNameController = TextEditingController();
  final _textFiledRateController = TextEditingController();
  final _textFieldImageController = TextEditingController();
  @override
  void dispose() {
    _textFiledNameController.dispose();
    _textFiledRateController.dispose();
    _textFieldImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = Map<String, dynamic>();
    String name, image, rate;

    return AlertDialog(
      title: Text(widget.title),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                name = value;
              },
              controller: _textFiledNameController,
              decoration: InputDecoration(hintText: widget.hintName),
            ),
            TextField(
              onChanged: (value) {
                rate = value;
              },
              controller: _textFiledRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: widget.hintRate),
            ),
            TextField(
              onChanged: (value) {
                image = value;
              },
              controller: _textFieldImageController,
              decoration: InputDecoration(hintText: widget.hintImage),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          color: Colors.grey,
          textColor: Colors.black,
          child: Text('Cancel'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              data['rate'] = _textFiledRateController.text;
              data['name'] = _textFiledNameController.text;
              data['image'] = _textFieldImageController.text;
              Navigator.pop(context, data);
            });
          },
          textColor: Colors.black,
          child: Text('Accept'),
          color: Colors.amber,
        )
      ],
    );
  }
}
