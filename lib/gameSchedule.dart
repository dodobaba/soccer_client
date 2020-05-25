import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:dio/dio.dart';
import 'package:mini_calendar/mini_calendar.dart';

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
  static List<Schedule> rs = [];
  Map<DateDay, String> _marks = {};
  String localization;
  double viewportfraction = 0.27;
  double pageOffset;

  void fetchData() async {
    try {
      var res = await Dio().get("http://localhost:18208/api/getschedule");

      setState(() {
        rs = List.from(res.data['Schedule'])
            .map((e) => Schedule.parse(e))
            .toList();
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
              // padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              // height: 440,
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
                              child: Text(data != null ? data : '无比赛'));
                        });
                  },
                  controller: MonthController.init(MonthOption<String>(
                    marks: makeCalendarsMarks(rs),
                    currentMonth:
                        DateMonth.now().copyWith(month: 5, year: 2020),
                  ))),
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.all(10.0),
              children: rs
                  .map((e) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("日期：" + e.date.toString()),
                          Text("比赛：" + e.id[0].toString()),
                          Text("比赛，联赛，主队，客队：" + e.id.toString()),
                          Divider(height: 10.0)
                        ],
                      ))
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
