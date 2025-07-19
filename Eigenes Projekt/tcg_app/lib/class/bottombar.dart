import 'package:flutter/material.dart';
import 'package:tcg_app/class/appdata.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

IconThemeData iconThemedata = IconThemeData(
  color: Appdata.selectedItemColor,
  size: 30,
);

TextStyle textSelected = TextStyle(
  color: Appdata.selectedItemColor,
  fontFamily: "Arial",
);

class _BottombarState extends State<Bottombar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextStyle _getLabelTextStyle(Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return textSelected;
    }
    return TextStyle(color: Appdata.buttomBarElemente);
  }

  IconThemeData _getIconThemeData(Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return iconThemedata;
    }
    return IconThemeData(color: Appdata.buttomBarElemente);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        navigationBarTheme: NavigationBarThemeData(
          // Hier die Funktionen verwenden
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            _getLabelTextStyle,
          ),
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
            _getIconThemeData,
          ),
        ),
      ),
      child: NavigationBar(
        destinations: const [
          // const hinzugefügt, da die Destinations statisch sind
          NavigationDestination(icon: Icon(Icons.home), label: "home"),
          NavigationDestination(icon: Icon(Icons.search), label: "search"),
          NavigationDestination(icon: Icon(Icons.person), label: "profile"),
          NavigationDestination(
            icon: Icon(Icons.local_fire_department),
            label: "Meta",
          ),
        ],
        indicatorColor: Appdata.indicatorColor,
        backgroundColor: Appdata.barColor,
        surfaceTintColor: Colors.transparent,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    );
  }
}
