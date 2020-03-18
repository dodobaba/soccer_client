import 'package:flutter/material.dart';

class GameScheduleDetail extends StatelessWidget {
  final dynamic data;
  final double scale;

  GameScheduleDetail(this.data, this.scale);

  @override
  Widget build(BuildContext context) {
    print(scale);
    return Card(
        color: Color.fromRGBO(50, 20, 100, scale * 0.3),
        shadowColor: Color.fromRGBO(0, 0, 0, scale * 0.3),
        margin: EdgeInsets.fromLTRB((100 - scale * 50), 10, 10, 10),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Text(DateTime.fromMillisecondsSinceEpoch(data['Date']).toString()),
            Text('联赛 ${data['Id'][1]}'),
            Text(
                '${data['Id'][2]}（排名${data['Rank'][0]}） VS ${data['Id'][3]}（排名${data['Rank'][1]}）'),
            Text('比分 ${data['Score'][0]} : ${data['Score'][1]} '),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    '半场得分(${data['Half']}),红牌(${data['RedCard'][0]}:${data['RedCard'][1]}),是否是中立场(${data['N'] == 0 ? '否' : '是'})')
              ],
            ),
            Text('其他信息：${this.data['Note']}'),
          ]),
        ));
  }
}
