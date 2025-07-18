import 'package:flutter/material.dart';
import 'package:tcg_app/class/appbar.dart';
import 'package:tcg_app/class/appdata.dart';
import 'package:tcg_app/class/bottombar.dart';

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
            // Verwende Center, um den Inhalt der Column zu zentrieren
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Zentriert die Kinder vertikal
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Zentriert die Kinder horizontal
              children: [
                Text(
                  "Willkommen bei",
                  style: TextStyle(
                    fontSize: Appdata.header,
                    fontWeight: Appdata.bold,
                    color: Appdata.textColor, //
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Appdata.bildPadding,
                  ),
                  child: Image.asset(
                    'assets/images/appicon.png',
                    fit: BoxFit.contain,
                    width: Appdata.bildwith,
                  ),
                ),
                Text(
                  "Ihrer TCG App des Vertrauens",
                  style: TextStyle(
                    fontSize: Appdata.textSize, //

                    color: Appdata.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Bottombar(),
      ),
    );
  }
}
