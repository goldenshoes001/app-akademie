import 'package:flutter/material.dart';
import 'package:tcg_app/class/appbar.dart';
import 'package:tcg_app/class/appdata.dart';
import 'package:tcg_app/class/bottombar.dart';
import 'package:tcg_app/class/text_widget.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Barwidget(),
        body: Container(
          height: double.infinity,
          color: Appdata.bodyBackground,
          child: Center(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    text: "Willkommen bei",
                    fontSize: Appdata.header,
                    fontWeight: Appdata.bold,
                    color: Appdata.textColor,
                  ),
                  SizedBox(
                    height: Appdata.differenceBetweenImageText,
                  ), // Kontrollierbarer Abstand
                  Image.asset('assets/images/appicon.png'),
                  SizedBox(
                    height: Appdata.differenceBetweenImageText,
                  ), // Kontrollierbarer Abstand
                  TextWidget(
                    text: "Ihrer TCG App des Vertrauens",
                    fontSize: Appdata.textSize,
                    color: Appdata.textColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Bottombar(),
      ),
    );
  }
}
