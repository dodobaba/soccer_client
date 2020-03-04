import 'package:flutter/material.dart';
import 'mydrawer.dart';

class League extends StatelessWidget {
  final String title;

  League({Key key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: <Widget>[
            FlatButton(
                onPressed: () => _onGoBack(context),
                child: Text('go back to the home page')),
            Text('The league page')
          ],
        ));
  }

  _onGoBack(BuildContext context) {
    Navigator.pop(context);
  }
}
