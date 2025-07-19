import 'package:flutter/material.dart';
import 'package:tcg_app/class/appdata.dart';

class Barwidget extends StatelessWidget implements PreferredSizeWidget {
  const Barwidget({super.key});
  @override
  Widget build(BuildContext context) {
    final Color barColor = Appdata.barColor;

    return AppBar(
      backgroundColor: barColor,
      title: Text(""),
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Appdata.appbarSize);
}
