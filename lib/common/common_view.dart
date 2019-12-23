import 'package:flutter/material.dart';

class CommonView {
  static newText(String text, double size, Color color,{int maxLines=99}) {
    return Text(text,maxLines: maxLines, overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: size, color: color),);
  }
}
