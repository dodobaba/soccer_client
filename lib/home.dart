import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'main.dart';
import 'mydrawer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _value;
  final storage = new LocalStorage("localization");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'The Soccer Infomation Home Page',
            ),
            DropdownButton(
                value: _value,
                hint: Text('语言'),
                onChanged: (v) {
                  storage.setItem("localization", v);
                  setState(() {
                    _value = v;
                  });
                },
                items: [
                  DropdownMenuItem(value: 'CHS', child: Text('CHS')),
                  DropdownMenuItem(value: 'CHT', child: Text('CHT')),
                  DropdownMenuItem(value: 'EN', child: Text('EN')),
                ]),
            FlatButton(
                onPressed: () => _onGoto(context),
                child: Text('goto the league page')),
            FlatButton(
                onPressed: () => _onGoto2(context),
                child: Text('goto the teams page')),
            FlatButton(
                onPressed: () => _onGoto3(context),
                child: Text('goto the game schedule page')),
            FlatButton(
                onPressed: () => _onGoto4(context),
                child: Text('goto the index point page')),
          ],
        ),
      ),
    );
  }

  _onGoto(BuildContext context) {
    Navigator.pushNamed(context, LeaguePage);
  }

  _onGoto2(BuildContext context) {
    Navigator.pushNamed(context, TeamsPage);
  }

  _onGoto3(BuildContext context) {
    Navigator.pushNamed(context, GameSchedulePage);
  }

  _onGoto4(BuildContext context) {
    Navigator.pushNamed(context, IndexPointPage);
  }
}
