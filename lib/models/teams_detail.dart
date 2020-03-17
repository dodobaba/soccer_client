import 'package:flutter/material.dart';

class TeamsDetail extends StatelessWidget {
  final dynamic data;

  TeamsDetail(this.data);

  @override
  Widget build(BuildContext context) {
    print(this.data);
    return Card(
      margin: EdgeInsets.fromLTRB(20, 50, 20, 5),
      child: Column(children: [Text(this.data['nameChs'])]),
    );
  }
}
