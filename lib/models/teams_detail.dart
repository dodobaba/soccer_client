import 'package:flutter/material.dart';

class TeamsDetail extends StatelessWidget {
  final dynamic data;

  TeamsDetail(this.data);

  @override
  Widget build(BuildContext context){
    print(this.data);
    return Card(
      child: Column(
        children:[
          Text(this.data['nameChs'])
        ]
      ),
    );
  }
}