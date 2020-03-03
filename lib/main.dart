import 'package:flutter/material.dart';

import 'mydrawer.dart';

void main() => runApp(MyApp());

const Home = "/";
const LeaguePage = '/leaguepage';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    RouteFactory _routers(){
      return (settings){
        final Map<String, dynamic> arguments = settings.arguments;
        Widget screen;
        switch (settings.name) {
          case Home:
            screen = MyHomePage(title: 'TSI: The Soccer Infomation');
            break;
          case LeaguePage:
            screen = League();
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

class League extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Text('The league page');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          ],
        ),
      ),
    );
  }
}
