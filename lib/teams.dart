import 'dart:math';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:dio/dio.dart';

import 'models/teams_detail.dart';

class Teams extends StatefulWidget {
  final String title;
  Teams({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => TeamsState();
}

class TeamsState extends State<Teams> {
  final storage = LocalStorage("localization");
  static List<dynamic> rs = [];
  String localization;
  double viewportfraction = 0.8;
  double pageOffset;
  PageController _defaultPageController;

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
    _defaultPageController =
        new PageController(initialPage: 5, viewportFraction: viewportfraction)
          ..addListener(() {
            setState(() {
              pageOffset = _defaultPageController.page;
            });
          });
    setState(() {
      this.localization = storage.getItem("localization");
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: rs.length,
        scrollDirection: Axis.horizontal,
        reverse: true,
        controller: _defaultPageController,
        physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
        onPageChanged: (index) {
          print(index);
        },
        itemBuilder: ((context, idx) {
          double scale = max(viewportfraction,
              (1 - (pageOffset - idx).abs() + viewportfraction));
          return TeamsDetail(rs[idx], scale);
        }));
  }
}
