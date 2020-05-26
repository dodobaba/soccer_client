import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:dio/dio.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// import 'models/gameSchedule_detail.dart';
import 'models/schedule.dart';

final storage = LocalStorage("localization");

class GameSchedule extends StatefulWidget {
  final String title;
  GameSchedule({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => GameScheduleState();
}

class GameScheduleState extends State<GameSchedule> {
  static List<Schedule> _schedule = [];
  static List<Competition> _competitons = [];
  static List<Team> _teams = [];
  Map<DateDay, String> _marks = {};
  String localization;
  double viewportfraction = 0.27;
  double pageOffset;

  void fetchData() async {
    try {
      var res = await Dio().get("http://localhost:18208/api/getschedule");
      setState(() {
        _schedule = List.from(res.data['Schedule'])
            .map((e) => Schedule.parse(e))
            .toList();
        _competitons = List.from(res.data['Competiton'])
            .map((e) => Competition.parse(e))
            .toList();
        _teams = List.from(res.data['Team']).map((e) => Team.parse(e)).toList();
      });
    } catch (e) {
      print('Catch error :' + e.toString());
    }
  }

  makeCalendarsMarks(List<Schedule> calendars) {
    Map<DateDay, String> _marks = {};
    for (Schedule item in calendars) {
      // print(item.date);
      DateTime cd = DateTime.fromMillisecondsSinceEpoch(item.date);
      DateDay dd = DateDay.dateTime(cd);
      // print(dd.toString());
      _marks[dd] = item.id.toString();
    }
    return _marks;
  }

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   this.localization = storage.getItem("localization");
    // });
    fetchData();
    // _defaultPageController =
    //     new PageController(initialPage: 2, viewportFraction: viewportfraction)
    //       ..addListener(() {
    //         setState(() {
    //           pageOffset = _defaultPageController.page;
    //         });
    //       });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: MonthWidget(
                  padding: EdgeInsets.all(10.0),
                  onDaySelected: (day, data) {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext ctx) {
                          return Container(
                              padding: EdgeInsets.all(15.0),
                              height: 300.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0))),
                              child: ListView(
                                padding: EdgeInsets.all(10.0),
                                children: _schedule
                                    .where((item) =>
                                        DateDay.dateTime(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                item.date)) ==
                                        day)
                                    .map((e) => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("联赛：" +
                                                (_competitons.isNotEmpty
                                                    ? _competitons
                                                        .firstWhere((item) =>
                                                            item.key == e.id[1])
                                                        .name
                                                    : "不详")),
                                            Text("主队：" +
                                                (_teams.isNotEmpty
                                                    ? _teams
                                                        .firstWhere((item) =>
                                                            item.key == e.id[2])
                                                        .name
                                                    : "不详")),
                                            Text("客队：" +
                                                (_teams.isNotEmpty
                                                    ? _teams
                                                        .firstWhere((item) =>
                                                            item.key == e.id[3])
                                                        .name
                                                    : "不详")),
                                            Divider(height: 10.0)
                                          ],
                                        ))
                                    .toList(),
                              ));
                        });
                  },
                  controller: MonthController.init(MonthOption<String>(
                    marks: makeCalendarsMarks(_schedule),
                    currentMonth:
                        DateMonth.now().copyWith(month: 5, year: 2020),
                  ))),
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.all(10.0),
              children: _schedule
                  .map((e) => Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      actions: [
                        IconSlideAction(
                          caption: 'History',
                          color: Colors.blue,
                          icon: Icons.history,
                          onTap: () => null,
                        )
                      ],
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Now',
                          color: Colors.blue,
                          icon: Icons.today,
                          onTap: () => null,
                        )
                      ],
                      child: ListTile(
                        title: Text("联赛：" +
                            (_competitons.isNotEmpty
                                ? _competitons
                                    .firstWhere((item) => item.key == e.id[1])
                                    .name
                                : "不详")),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("日期：" +
                                DateTime.fromMillisecondsSinceEpoch(e.date)
                                    .toString()),
                            Text("比赛：" + e.id[0].toString()),
                            Text("主队：" +
                                (_teams.isNotEmpty
                                    ? _teams
                                        .firstWhere(
                                            (item) => item.key == e.id[2])
                                        .name
                                    : "不详")),
                            Text("客队：" +
                                (_teams.isNotEmpty
                                    ? _teams
                                        .firstWhere(
                                            (item) => item.key == e.id[3])
                                        .name
                                    : "不详")),
                            Divider(height: 10.0)
                          ],
                        ),
                      )))
                  .toList(),
            ))
          ],
        )

        // body: PageView.builder(
        //     itemCount: rs.length,
        //     scrollDirection: Axis.vertical,
        //     reverse: false,
        //     controller: _defaultPageController,
        //     physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
        //     onPageChanged: (index) {
        //       print(index);
        //     },
        //     itemBuilder: ((context, idx) {
        //       double scale = max(viewportfraction,
        //           (1 - (pageOffset - idx).abs() + viewportfraction));
        //       return GameScheduleDetail(rs[idx], scale);
        //     }))
        );
  }
}
