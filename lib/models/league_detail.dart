import 'package:flutter/material.dart';

String checkNULL(String dep) {
  return dep != null ? dep : 'none';
}

Color transColor(String c) {
  if (c == null ||
      c.length != 7 ||
      int.tryParse(c.substring(1, 7), radix: 16) == null) c = '#FFFFFF';
  return Color(int.parse(c.substring(1, 7), radix: 16) + 0xFF000000);
}

class LeagueDetail extends StatelessWidget {
  final dynamic data;
  // final int leagueId;
  // final String color;
  // final String nameEn;
  // final String nameEnShort;
  // final String nameChs;
  // final String nameChsShort;
  // final String nameCht;
  // final String nameChtShort;
  // final int type;
  // final String subSclassEn;
  // final String subSclassCn;
  // final int sumRound;
  // final int currRound;
  // final String currSeason;
  // final int countryId;
  // final String countryEn;
  // final String countryCn;
  // final String leagueLogo;
  // final String countryLogo;
  // final int areaId;

  LeagueDetail(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(this.data['countryLogo']),
              ),
              title: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(this.data['nameChs']),
                Text("(${this.data['nameChsShort']})"),
                Text(
                    " -- (${this.data['nameCht']} -- ${this.data['nameChtShort']})")
              ]),
              subtitle: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(this.data['nameEn']),
                Text("(${this.data['nameEnShort']})")
              ])),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(this.data['leagueLogo']),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("本赛季：${this.data['currSeason']}"),
                    Text(
                        "当前第${this.data['currRound']}轮 / 总轮数：${this.data['sumRound']}"),
                  ],
                )
              ],
            ),
          ),
          // Text(checkNULL(this.data['leagueId'].toString())),
          // Text(this.data['type']),
          // Text(checkNULL(this.data['subSclassEn'])),
          // Text(checkNULL(this.data['subSclassCn'])),

          // Text(this.data['currRound']),
          // Text(this.data['countryId']),
          // Text(this.data['countryEn']),
          // Text(this.data['countryCn']),
          // Text(this.data['leagueLogo']),
          // Text(this.data['countryLogo']),
          // Text(this.data['areaId'])
        ],
      ),
    );
  }
}
