import 'package:flutter/material.dart';
import 'package:tcg_app/class/appbar.dart';
import 'package:tcg_app/class/appdata.dart';
import 'package:tcg_app/class/bottombar.dart';
import 'package:tcg_app/class/home.dart';
import 'package:tcg_app/class/profile.dart';
import 'package:tcg_app/class/search.dart';
import 'package:tcg_app/class/meta.dart';

void main() {
  runApp(MainApp());
}

// ignore: must_be_immutable
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetListe = [Home(), Search(), Profile(), Meta()];
    List<NavigationDestination> iconList = [
      NavigationDestination(icon: Icon(Icons.home), label: "home"),
      NavigationDestination(icon: Icon(Icons.search), label: "search"),
      NavigationDestination(icon: Icon(Icons.person), label: "profile"),
      NavigationDestination(
        icon: Icon(Icons.local_fire_department),
        label: "Meta",
      ),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Barwidget(barColor: Appdata.barColor),
        body: Container(
          height: double.infinity,
          color: Appdata.bodyBackground,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [widgetListe[_selectedIndex]],
            ),
          ),
        ),
        bottomNavigationBar: Bottombar(
          currentIndex: _selectedIndex,
          valueChanged: _onItemTapped,
          navigationItems: iconList,
          selectedIconColor: Appdata.selectedItemColor,
          selectedLabelColor: Appdata.selectedItemColor,
          unselectedIconSize: Appdata.sizeIcons,
          selectedIconSize: Appdata.sizeSelectedIcons,
          unselectedLabelSize: Appdata.sizeLabels,
          selectedLabelSize: Appdata.sizeLabels,
          backgroundColor: Appdata.barColor,
          indicatorColor: Appdata.indicatorColor,
        ),
      ),
    );
  }
}
