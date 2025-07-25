import 'package:aufgabe210725/class/appbar.dart';
import 'package:aufgabe210725/class/appdata.dart';
import 'package:aufgabe210725/class/news.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Barwidget(barColor: Appdata.barColor),
        body: Center(
          child: Container(
            height: double.infinity,
            color: Appdata.bodyBackground,
            child: News(),
          ),
        ),
      ),
    );
  }
}
