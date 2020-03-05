import 'package:flutter/material.dart';

import 'home.dart';
import 'league.dart';

void main() => runApp(MyApp());

const Home = "/";
const LeaguePage = '/leaguepage';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    RouteFactory _routers(){
      return (settings){
        // final Map<String, dynamic> arguments = settings.arguments;
        Widget screen;
        switch (settings.name) {
          case Home:
            screen = MyHomePage(title: 'TSI: The Soccer Infomation');
            break;
          case LeaguePage:
            screen = League(title:'TSI: The League Page');
            break;
          default:
            screen = MyHomePage(title: 'TSI: The Soccer Infomation');
        }
        return MaterialPageRoute(builder: (BuildContext context) => screen);
      };
    }

    return MaterialApp(
      title: 'The Soccer Infomation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _routers(),
      // home:  MyHomePage(title: 'TSI: The Soccer Infomation'),
    );
  }
}

