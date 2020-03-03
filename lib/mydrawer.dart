import 'package:flutter/material.dart';
import 'models/drawerMenu.dart';
import 'main.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menu = DrawerMenu.fetchAll();
    return Container(
      color: Colors.white,
      width: 150.0,
      child: ListView(
        children: [Container(color: Colors.blue, height: 100)]..addAll(menu
            .map((e) => GestureDetector(
                  child: ButtonSection(e.label, e.iconPath),
                  onTap: () => _onDrawerTap(context, e.id),
                ))
            .toList()),
      ),
    );
  }

  _onDrawerTap(BuildContext context, int id) {
    Navigator.pushNamed(context, LeaguePage, arguments: {"id": id});
  }
}

class ButtonSection extends StatelessWidget {
  final String _label;
  final String _iconpath;

  ButtonSection(this._label, this._iconpath);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(
            _iconpath,
            height: 25.0,
            width: 25.0,
          ),
          Text(_label)
        ]));
  }
}
