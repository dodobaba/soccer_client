import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:dio/dio.dart';

class Teams extends StatefulWidget {
  final String title;
  Teams({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => TeamsState();
}

class TeamsState extends State<Teams> {
  final storage = LocalStorage("localization");
  List<dynamic> rs = [];
  String localization;

  void fetchData() async {
    try {
      Response res = await Dio().get("http://localhost:18208/api/getteams");
      //Map<String, dynamic> ttt = json.decode(res.data.toString());
      var ttt = new List<dynamic>.from(res.data['teams']);
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
    setState(() {
      this.localization = storage.getItem("localization");
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
