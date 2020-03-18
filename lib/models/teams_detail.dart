import 'package:flutter/material.dart';

class TeamsDetail extends StatelessWidget {
  final dynamic data;
  final double scale;

  TeamsDetail(this.data, this.scale);

  @override
  Widget build(BuildContext context) {
    print(this.data);
    return Card(
        margin: EdgeInsets.fromLTRB(20, (100 - scale * 50), 20, 5),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
            CircleAvatar(
              backgroundImage: NetworkImage(this.data['logo']),
            ),
            Text(this.data['nameChs']),
            Text(this.data['nameCht']),
            Text(this.data['nameEn']),
            Text('成立时间：${this.data['foundingDate']}'),
            Text('主场：${this.data['areaCn']}/${data['gymCn']}  ${this.data['areaEn']}/${data['gymEn']} 坐席：${data['apacity']}'),
            Text('主教练：${this.data['coachCn']} / ${data['coachEn']}'),
            Text('地址：${this.data['addrCn']}/${data['addrEn']}'),
          ]),
        ));
  }
}
