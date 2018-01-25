import './item.dart';

class ArrayItem {
  List<Item> items;
  int size;
  int numberOfElements;
  ArrayItem(this.size) {
    items = new List<Item>(this.size);
    this.numberOfElements = 0;
  }

  void fillArray(int fillSize) {
    items = new List<Item>(this.size);
    for(int i = 0; i < fillSize; i ++) {
      items[i] = new Item();
    }
    numberOfElements = fillSize;
  }

  void insertToArray(int number) {
    items[numberOfElements++] = new Item(number);
  }
}
