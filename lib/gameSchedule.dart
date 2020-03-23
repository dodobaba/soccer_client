import 'dart:math';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:dio/dio.dart';

import 'models/gameSchedule_detail.dart';

class GameSchedule extends StatefulWidget {
  final String title;
  GameSchedule({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => GameScheduleState();
}

class GameScheduleState extends State<GameSchedule> {
  final storage = LocalStorage("localization");
  static List<dynamic> rs = [];
  String localization;
  double viewportfraction = 0.27;
  double pageOffset;
  PageController _defaultPageController;

  void fetchData() async {
    try {
      Response res = await Dio().get("http://localhost:18208/api/getschedule");
      var ttt = new List<dynamic>.from(res.data['Schedule']);
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
    _defaultPageController = new PageController(
        initialPage: 2, viewportFraction: viewportfraction)
      ..addListener(() {
        setState(() {
          pageOffset = _defaultPageController.page;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:PageView.builder(
        itemCount: rs.length,
        scrollDirection: Axis.vertical,
        reverse: false,
        controller: _defaultPageController,
        physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
        onPageChanged: (index) {
          print(index);
        },
        itemBuilder: ((context, idx) {
          double scale = max(viewportfraction,
              (1 - (pageOffset - idx).abs() + viewportfraction));
          return GameScheduleDetail(rs[idx], scale);
        })));
  }
}
