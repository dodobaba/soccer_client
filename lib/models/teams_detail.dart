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
      child: Column(children: [Text(this.data['nameChs'])]),
    );
  }
}
