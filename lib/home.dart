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
  final storage = new LocalStorage("localisation");
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
                  storage.setItem("localisation", v);
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
                child: Text('goto the league page'))
          ],
        ),
      ),
    );
  }

  _onGoto(BuildContext context) {
    Navigator.pushNamed(context, LeaguePage);
  }
}
