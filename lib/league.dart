import 'package:flutter/material.dart';
import 'mydrawer.dart';


class League extends StatelessWidget{
  final String title;

  League({Key key, this.title});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
       body:Text('The league page')
    );
  }
}