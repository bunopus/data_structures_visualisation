import './base_array.dart';
import 'package:DartWorkshopLafore/src/shared/item.dart';

class OrderedArray extends BaseArray {
  OrderedArray(int size): super(size);

  void fillArray(int fillSize) {
    items = new List<Item>(this.size);
    for (int i = 0; i < fillSize; i ++) {
      items[i] = new Item();
      numberOfElements ++;
    }
    _insertionSort();
  }

  void insertToArray(int value) {
    int j;
    for (j = 0; j < numberOfElements; j++) {
      if (items[j].number > value)
        break;
    }
    for (int k = numberOfElements; k > j; k--) {
      items[k] = items[k-1];  
    }
    items[j] = new Item(value);
    numberOfElements ++;
  }

  void _insertionSort() {
    int _in, out;
    for(out = 1; out < numberOfElements; out ++) {
      Item temp = items[out];
      _in = out;
      while(_in > 0 && (items[_in - 1].number.compareTo(temp.number) > 0)) {
        items[_in] = items[_in - 1];
        _in --;
      }
      items[_in] = temp;
    }
  }
}
