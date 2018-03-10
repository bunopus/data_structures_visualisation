import 'dart:math';

import 'package:color/color.dart';

class Item {
  int number;
  String color;

  Item([int number = null]) {
    Random random = new Random();
    int i = 100 + (random.nextDouble() * 154.0).toInt();
    int j = 100 + (random.nextDouble() * 154.0).toInt();
    int k = 100 + (random.nextDouble() * 154.0).toInt();

    HexColor _color = new Color.rgb(i, j, k).toHexColor();
    if (number == null) {
      this.number = random.nextInt(1000);
    } else {
      this.number = number;
    }
    this.color = '#$_color';
  }
}