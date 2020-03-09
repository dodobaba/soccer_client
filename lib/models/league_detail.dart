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
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        border: Border.all(width: 2, color: transColor(this.data['color'])),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(this.data['countryLogo']),fit: BoxFit.fitHeight)
                ),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(this.data['leagueLogo']),fit: BoxFit.fitHeight)
                ),
              ),
              Column(
                children: <Widget>[
                  Text(this.data['nameEn']),
                  Text(this.data['nameEnShort']),
                  Text(this.data['nameChs']),
                  Text(this.data['nameChsShort']),
                  Text(this.data['nameCht']),
                  Text(this.data['nameChtShort']),
                ],
              )
            ],
          ),
          // Text(checkNULL(this.data['leagueId'].toString())),
          // Text(this.data['type']),
          // Text(checkNULL(this.data['subSclassEn'])),
          // Text(checkNULL(this.data['subSclassCn'])),
          Text(this.data['sumRound']),
          Text(this.data['currRound']),
          Text(this.data['currSeason']),
          Text(this.data['countryId']),
          Text(this.data['countryEn']),
          Text(this.data['countryCn']),
          // Text(this.data['leagueLogo']),
          // Text(this.data['countryLogo']),
          // Text(this.data['areaId'])
        ],
      ),
    );
  }
}
