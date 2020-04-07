
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:dio/dio.dart';

class IndexPoint extends StatefulWidget {
  final String title;
  IndexPoint({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => IndexPointState();
}

class IndexPointState extends State<IndexPoint> {
  final storage = LocalStorage("localization");
  static dynamic rs;
  String localization;

  void fetchData() async {
    try {
      Response res =
          await Dio().get("http://localhost:18208/api/getindexpoint");
      //Map<String, dynamic> ttt = json.decode(res.data.toString());
      // var ttt = new List<dynamic>.from(res.data);
      print(res.data);
      setState(() {
        rs = res.data;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:Column(
          children: <Widget>[
            Text(widget.title),
            DataTable(
              columns: [
                DataColumn(label: Text('公司')),
                DataColumn(label: Text('赔率')),
                DataColumn(label: Text('时间')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('${rs['current']['Asian']['AsianIndexPoint'][0]['Name']}')),
                  DataCell(Text('${rs['current']['Asian']['AsianIndexPoint'][0]['Logs'][0]['Data'].toString()}')),
                  DataCell(Text(DateTime.fromMillisecondsSinceEpoch(int.parse(rs['current']['Asian']['AsianIndexPoint'][0]['Logs'][0]['Date'])).toString()))
                ])
              ],
            ),
          ],
          )
        );
  }
}

// class MyTable extends DataTableSource {
//   List _rs = [];
//   int _selectCount = 0;
//   bool _isRowCountApproximate = false;

//   @override
//   DataRow getRow(int index) {
//     if (index >= _rs.length || index < 0) throw FlutterError('rs data error');
//     final row = _rs[index];
//     return DataRow.byIndex(
//       cells: [
//         DataCell(Text(row.toString()))
//       ],
//       index: index,

//       );
//   }

//   @override
//   bool get isRowCountApproximate => _isRowCountApproximate;

//   @override
//   int get rowCount => _rs.length;

//   @override
//   int get selectedRowCount => _selectCount;
// }
