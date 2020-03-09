import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'models/league_detail.dart';

class LeagueModel {
  final String data;

  LeagueModel(this.data);

  LeagueModel.fromJson(Map json) : data = json['data'];
}

class League extends StatefulWidget {
  final String title;
  League({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => LeagueState();
}

class LeagueState extends State<League> {
  List<dynamic> rs = [];

  void fetchData() async {
    try {
      Response res = await Dio().get("http://localhost:18208/api/getleagues");
      //Map<String, dynamic> ttt = json.decode(res.data.toString());
      var ttt = new List<dynamic>.from(res.data['leagues']);
      print(ttt.length);
      setState(() {
        rs = ttt;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            FlatButton(
                onPressed: () => _onGoBack(context),
                child: Text('go back to the home page')),
            Text('The league page'),
          ]..addAll(rs.map((item) => LeagueDetail(item)).toList()),
        ));
  }

  _onGoBack(BuildContext context) {
    Navigator.pop(context);
  }
}
