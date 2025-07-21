import 'package:aufgabe210725/class/text_widget.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(text: "news", color: Colors.white, fontSize: 14),
        Icon(Icons.newspaper, color: Colors.white),
      ],
    );
  }
}
