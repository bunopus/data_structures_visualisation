import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_input/material_input.dart';

import '../classes/ordered_array.dart';
import 'package:DartWorkshopLafore/src/shared/item.dart';

@Component(
    selector: 'chap02-order-array',
    styleUrls: const ['order_array_component.css'],
    templateUrl: 'order_array_component.html',
    directives: const [
      MaterialButtonComponent,
      materialInputDirectives,
      CORE_DIRECTIVES,
    ])
class OrderArrayComponent {
  OrderedArray orderedArray;
  String message;
  int indexList;
  int _codePart;
  String userInput;
  int _totalArraySize;
  final String initialMessage = 'Press any button';
  final String errorMessage = 'This is a not a nubmer';
  int itemToFind;
  int fillSize;
  int insertItem;

  int lowerBound;
  int upperBound;
  int curIn;
  int oldCurIn;
  int oldLB;
  int oldUB;

  Item tempItem;
  bool noShiftsYet;
  int insertPoint;
  Random random;
  int delKey;
  bool isLinear;
  int nItems;

  OrderArrayComponent() {
    message = initialMessage;
    _codePart = 1;
    orderedArray = new OrderedArray(20);
    orderedArray.fillArray(10);
    indexList = 0;
    random = new Random();
  }

  void newArray() {
    switch(_codePart) {
      case 1:
        message = 'Enter size of array to create';
        _codePart = 2;
        oldCurIn = curIn;
        curIn = 0;
        return;
      case 2:
        try {
          _totalArraySize = int.parse(userInput);
          if (_totalArraySize > 0 && _totalArraySize < 60) {
            message = 'Will create empty array with $_totalArraySize cells';
            _codePart = 3;
          } else {
            message = 'Your array size is incorrect';
            _codePart = 1;              
          }
        } catch (e) {
          message = errorMessage;
          _codePart = 1;
        }
       return;
      case 3:
        message = "Select Liner or Binary Search";
        _codePart = 5;
        return;
      case 4:
        if (isLinear) {
          message = "Uses liner search";
        } else {
          message = "Uses binary search";
        }
        return;
      case 5:
        orderedArray = new OrderedArray(_totalArraySize);
        message = 'New array created; total items ${orderedArray.numberOfElements}';
        oldCurIn = curIn;
        curIn = 0;
        _codePart = 6;
        return;  
      case 6:
        message = initialMessage;
        _codePart = 1;
        return;
    }
  }

  void fillArray() {
    switch (_codePart) {
      case 1:
        message = 'Enter number of items to fill in';
        _codePart = 2;
        return;
      case 2:
        try {
          fillSize = int.parse(userInput);
          if (fillSize < 0 || fillSize > orderedArray.size) {
            message = "ERROR: Can't fill more than ${orderedArray.size} items";
            _codePart = 1;
          } else {
            message = 'Will fill in $fillSize items';
            _codePart = 4;
          }
        } catch (e) {
          message = "It's a Non a number";
          _codePart = 1;
        }
        return;
      case 4:
        orderedArray.fillArray(fillSize);        
        message = 'Fill Completed; total item = ${orderedArray.numberOfElements}';
        oldCurIn = curIn;
        curIn = 1;
        _codePart = 5;
        return;
      case 5:
        message = initialMessage;
        _codePart = 1;
        return;
    }
  }

  void insertArray() {
    switch (_codePart) {
      case 1:
        oldCurIn = curIn;
        curIn = 0;
        message = 'Enter key of item to insert';
        _codePart = 2;
        return;
      case 2:
        insertItem = int.parse(userInput, onError: (source) => null);
        if (insertItem == null) {
          message = errorMessage;
          _codePart = 1;
        } else {
          if (insertItem < 0 || insertItem > 999) {
            message = "CAN'T INSERT: need key between 0 and 999";            
            _codePart = 1;
          } else if (orderedArray.numberOfElements >= orderedArray.size) {
            message = "CAN'T INSERT: array is full";
            _codePart = 7;
          } else {
            tempItem = new Item(insertItem);
            message = 'Will insert item with key $insertItem';
            if (!isLinear) {
              lowerBound = 0;
              upperBound = orderedArray.numberOfElements - 1;
              oldCurIn = curIn;
              curIn = ((upperBound - lowerBound) ~/ 2);
            }
            _codePart = 3;
          }
        }
        return;
      case 3:
        if (curIn >= orderedArray.numberOfElements) {
          orderedArray.items[curIn] = tempItem;
          indexList = curIn;
          message = 'Insertion item $insertItem at index $curIn';
          _codePart = 6;
        } else if (!isLinear) {
          if (orderedArray.items[curIn].number == insertItem) {
            message = "Can't insert: Duplicate at $curIn";
            oldLB = (this.oldUB = -1);
            _codePart = 7;
          } else if (lowerBound > upperBound) {
            if (orderedArray.items[curIn].number < insertItem) {
              oldCurIn = curIn;
              curIn += 1;
            }
            message = 'Will insert at index $curIn, following shift';
            noShiftsYet = true;
            insertPoint = curIn;
            oldLB = (this.oldUB = -1);
            _codePart = 4;
          } else {
            oldLB = lowerBound;
            oldLB = upperBound;
            oldCurIn = curIn;
            curIn = (lowerBound + (upperBound - lowerBound) ~/2);
            indexList = curIn;          
            message = 'Cheking index $curIn, range $lowerBound to $upperBound';

            if (orderedArray.items[curIn].number < insertItem) {
              lowerBound = (curIn + 1);
            } else {
              upperBound = (curIn - 1);
            }
            _codePart = 3;
          }
        }
        return;
      case 4:
        if (noShiftsYet) {
          noShiftsYet = false;
          message = 'Will shift cells to make room';
          oldCurIn = curIn;
          curIn = orderedArray.numberOfElements;
          indexList = curIn;
          _codePart = 4;
        } else if (curIn == insertPoint) {
          orderedArray.items[curIn] = tempItem;
          message = 'Have inserted item $insertItem at index $curIn';
          _codePart = 6;
        } else {
          orderedArray.items[curIn] = orderedArray.items[(curIn - 1)];
          orderedArray.items[(curIn - 1)] = null;
          oldCurIn = curIn;
          curIn -= 1;
          indexList = curIn;          
          message = 'Shifted item from index $curIn';
          _codePart = 4;
        }
        return;
      case 6: 
        message = 'Insertion completed total items = ${orderedArray.numberOfElements}';
        _codePart = 7;
        return;
      case 7:
        oldCurIn = curIn;
        curIn = 0;
        message = initialMessage;
        indexList = curIn;        
        _codePart = 1;  
        return;
    }
  }


  void findItem() {
    switch (_codePart) {
      case 1:
        oldCurIn = curIn;
        curIn = 0;
        message = 'Enter key of item to find';
        _codePart = 2;
        return;
      case 2:
        try {
          itemToFind = int.parse(userInput);
          if (itemToFind < 0 || (itemToFind > 999)) {
            message = "ERROR: user key between 0 and 999";
            _codePart = 1;
          } else {
            message = 'Loking for item with key $itemToFind';
            if (!isLinear) {
              lowerBound = 0;
              upperBound = (orderedArray.numberOfElements - 1);
              oldCurIn = curIn;
              curIn = ((upperBound - lowerBound) ~/ 2);
            }
            _codePart = 3;
          }
        } catch (e) {
          message = errorMessage;
          _codePart = 1;
        }
        return;
      case 3: {
        if (isLinear) {
          if ((curIn >= orderedArray.numberOfElements) || orderedArray.items[curIn].number > itemToFind) {
            message = "Can't locate item with key $itemToFind";
            _codePart = 6;
          } else if (orderedArray.items[curIn].number == itemToFind) {
            message = "Have found item with key $itemToFind";
            _codePart = 6;
          } else {
            oldCurIn = curIn;
            curIn += 1;
            message = "Checking nex cell; index = $curIn";
            _codePart = 3;
          }
        } else {
          if (orderedArray.items[curIn].number == itemToFind) {
          message = 'Have found item with key $itemToFind';
          oldLB = (this.oldUB = -1);
          _codePart = 6;
        } else if (lowerBound > upperBound) {
          message = "Can't find item with key $itemToFind";
          oldLB = (this.oldUB = -1);
          _codePart = 6;
        } else {
          oldLB = lowerBound;
          oldUB = upperBound;
          oldCurIn = curIn;
          curIn = (lowerBound + (upperBound - lowerBound) ~/ 2);
          indexList = curIn;
          message = 'Checking index $curIn, range $lowerBound to $upperBound';

          if (orderedArray.items[curIn].number < itemToFind) {
            lowerBound = curIn + 1;
          } else {
            upperBound = curIn - 1;
          }
          _codePart = 3;       
        }
      }
        return;
      }
      case 6:
        oldCurIn = curIn;
        curIn = 0;
        message = initialMessage;
        _codePart = 1;
        indexList = curIn;
        return;
    }
  }
  void deleteItem() {
    switch (_codePart) {
      case 1:
        oldCurIn = curIn;
        curIn = 0;
        message = 'Enter key of item to delete';
        _codePart = 2;
        break;
      case 2:
        try {
          delKey = int.parse(userInput);
          if ((delKey < 0) || (delKey > 999)) {
            message = 'ERROR: user key between 0 and 999';
            _codePart = 1;
          } else {
            if (!isLinear) {
              lowerBound = 0;
              upperBound = (orderedArray.numberOfElements - 1);
              oldCurIn = curIn;
              curIn = ((upperBound - lowerBound) ~/2);
            }
            indexList = curIn;            
            message = "Looking for item with key $delKey";
            _codePart = 3;
          }
        } catch (e) {
          message = errorMessage;
          _codePart = 1;
        } 
        break;
      case 3:
        if (isLinear) {
          if ((curIn) >= orderedArray.numberOfElements || 
              (orderedArray.items[curIn].number > delKey)) {
            message = ("No item with key $delKey found");
            _codePart = 5;
          } else if (orderedArray.items[curIn].number == delKey) {
            orderedArray.items[curIn] = null;
            message = "Have found and delete item with key $delKey";
            _codePart = 4;
          } else {
            oldCurIn = curIn;
            curIn += 1;
            indexList = curIn;
            message = "Checking index = $curIn for item";
            _codePart = 3;
          }
        } else {
          if (orderedArray.items[curIn].number == delKey) {
            orderedArray.items[curIn] = null;
            message = "Have found and delet item with key $delKey";
            oldLB = (this.oldUB = -1);
            _codePart = 4;
          } else if (lowerBound > upperBound) {
            message = 'No item with key $delKey found';
            oldLB = (this.oldUB = -1);
            _codePart = 5;
          } else {
            oldLB = lowerBound;
            oldUB = upperBound;
            oldCurIn = curIn;
            curIn = (lowerBound + (upperBound - lowerBound) ~/ 2);
            indexList = curIn;
            message = "Checking index $curIn range = $lowerBound to $upperBound";
            if (orderedArray.items[curIn].number < delKey) {
              lowerBound = (curIn + 1);
            } else {
              upperBound = (curIn - 1);
            }
            _codePart = 3;
          }
        }
        break;
      case 4:
        if (curIn < orderedArray.numberOfElements - 1) {
          oldCurIn = curIn;
          curIn += 1;
          orderedArray.items[(curIn - 1)] = orderedArray.items[curIn];
          orderedArray.items[curIn] = null;
          indexList = curIn;
          message = "Shifting item from $curIn to ${(curIn - 1)}";
          _codePart = 4;
        } else {
          orderedArray.numberOfElements -= 1;
          message = "Shiffting completed. Total Item = ${orderedArray.numberOfElements}";
          oldCurIn = curIn;
          curIn = (orderedArray.numberOfElements - 1);
          indexList = curIn;
          _codePart = 6;
        } 
        break;
      case 5:
        message = "Deletion not completed";  
        _codePart = 6;
        break;
      case 6:
        oldCurIn = curIn;
        curIn = 0;
        message = initialMessage;
        indexList = curIn;
        _codePart = 1;
        break;
    }
  }
}

