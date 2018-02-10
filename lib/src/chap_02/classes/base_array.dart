import 'package:DartWorkshopLafore/src/shared/item.dart';

class BaseArray {
  List<Item> items;
  int size;
  int numberOfElements;

  BaseArray(this.size) {
    items = new List<Item>(this.size);
    this.numberOfElements = 0;
  }
}
