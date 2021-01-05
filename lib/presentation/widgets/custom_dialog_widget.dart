import 'package:flutter/material.dart';

class CustomDialogWidget extends StatefulWidget {
  final String title;
  final String hintName;
  final String hintRate;
  final String hintImage;
  final String urlAvatar;
  const CustomDialogWidget({
    Key key,
    @required this.title,
    @required this.hintName,
    @required this.hintRate,
    @required this.hintImage,
    @required this.urlAvatar,
  })  : assert(title != null),
        assert(hintName != null),
        assert(hintRate != null),
        assert(hintImage != null),
        assert(urlAvatar != null),
        super(key: key);

  @override
  _CustomDialogWidgetState createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    Map<String, dynamic> data = Map<String, dynamic>();

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: avatarRadius + padding,
            bottom: padding * 0.6,
            left: padding,
            right: padding,
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                TextField(
                  onChanged: (value) {},
                  controller: _textFiledNameController,
                  decoration: InputDecoration(
                    labelText: widget.hintName,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  onChanged: (value) {},
                  controller: _textFiledRateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: widget.hintRate,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                TextField(
                  onChanged: (value) {},
                  controller: _textFieldImageController,
                  decoration: InputDecoration(
                    labelText: widget.hintImage,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.grey,
                        textColor: Colors.black,
                        child: Text('Cancel'),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      ),
                      SizedBox(width: 8.0),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
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
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: padding,
          left: padding,
          right: padding,
          child: CircleAvatar(
            radius: 53,
            backgroundColor: Colors.amber,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                widget.urlAvatar,
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
