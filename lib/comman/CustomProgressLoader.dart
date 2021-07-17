import 'package:flutter/material.dart';
import 'package:yaamfoo/values/ColorValues.dart';

class CustomProgressLoader{
  static showLoader(context) {
    showDialog(
      builder: (context) => new Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new Padding(
                padding: new EdgeInsets.all(30.0),
                child: new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(ColorValues.TEXT_COLOR,),
                )),
            new Padding(
                padding: new EdgeInsets.all(30.0), child: new Text("Loading")),
          ],
        ),
      ), context: context,
      barrierDismissible: false,
    );
  }

  static cancelLoader(context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }


  static void showDialogBackDialog(context1) {
    // flutter defined function
    showDialog(
      context: context1,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Are you sure you want to exit?",
            style: TextStyle(fontSize: 15.0),
          ),
          // content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
