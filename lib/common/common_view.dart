import 'package:flutter/material.dart';

class CommonView {
  static newText(String text, double size, Color color,
      {int maxLines = 99, TextAlign align = TextAlign.left}) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: align,
      style: TextStyle(fontSize: size, color: color),

    );
  }

}
