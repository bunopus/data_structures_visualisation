import 'dart:math';

import 'package:color/color.dart';

class Item {
  int number;
  String color;

  Item([int number = null]) {
    Random random = new Random();
    HexColor _color = new Color.rgb(
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255))
        .toHexColor();
    if (number == null) {
      this.number = random.nextInt(1000);
    } else {
      this.number = number;
    }
    this.color = '#$_color';
  }
}