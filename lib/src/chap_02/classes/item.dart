import 'dart:math';

import 'package:color/color.dart';

class Item {
  int number;
  String color;

  Item(this.number) {
    Random random = new Random();
    HexColor _color = new Color.rgb(
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255))
        .toHexColor();
    this.color = '#$_color';
  }
}