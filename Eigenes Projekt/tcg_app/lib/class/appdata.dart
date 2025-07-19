import 'package:flutter/material.dart';

class Appdata {
  int fontSizeBody = 14;
  static final int colorIndexBarColorRed = 80;
  static final int colorIndexBarColorYellow = 80;
  static final int colorIndexBarColorBlue = 80;

  static final int colorindexBodyColorRed =
      colorIndexBarColorRed - colorIndexDifference;
  static final int colorIndexBodyColorYellow =
      colorIndexBarColorYellow - colorIndexDifference;
  static final int colorIndexBodyColorBlue =
      colorIndexBarColorBlue - colorIndexDifference;

  static final int colorIndexIndicatorColorRed =
      colorIndexBarColorRed + colorIndexDifference;
  static final int colorIndexIndicatorColorYellow =
      colorIndexBarColorYellow + colorIndexDifference;
  static final int colorIndexIndicatorColorBlue =
      colorIndexBarColorBlue + colorIndexDifference;

  static final int colorIndexDifference = 50;

  static final Color textColor = Colors.white;
  static final Color barColor = Color.fromRGBO(
    colorIndexBarColorRed,
    colorIndexBarColorYellow,
    colorIndexBarColorBlue,
    1,
  );
  static final Color buttomBarElemente = Color.fromRGBO(255, 255, 255, 1);
  static final Color buttomBarLabel = Color.fromRGBO(255, 255, 255, 1);
  static final Color bodyBackground = Color.fromRGBO(
    colorindexBodyColorRed,
    colorIndexBodyColorYellow,
    colorIndexBodyColorBlue,
    1,
  );
  static final Color selectedItemColor = Color.fromRGBO(0, 183, 255, 1);
  static final Color indicatorColor = Color.fromRGBO(
    colorIndexIndicatorColorRed,
    colorIndexIndicatorColorYellow,
    colorIndexIndicatorColorBlue,
    1,
  );
  static final double sizeIcons = 5;
  static final double appbarSize = 0;
  static final double header = 30;
  static final double textSize = 20;
  static final double sizeLabels = 14;
  static final FontWeight bold = FontWeight.bold;
  static final double differenceBetweenImageText = 80;
  static final String fontFamily = "arial";
}
