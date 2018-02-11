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

  OrderArrayComponent() {
    message = initialMessage;
    _codePart = 1;
    orderedArray = new OrderedArray(20);
    orderedArray.fillArray(10);
    indexList = 0;
  }

  void newArray() {
    switch(_codePart) {
      case 1:
        message = 'Enter size of array to create';
        _codePart = 2;
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
        orderedArray = new OrderedArray(_totalArraySize);
        message = 'New array created; total items ${orderedArray.numberOfElements}';
        _codePart = 4;
        return;
      case 4:
        message = initialMessage;
        _codePart = 1;
        return;  
    }
  }
  void fillArray() {}
  void insertArray() {
    switch (_codePart) {
      case 1:
        oldCurIn = curIn;
        curIn = 0;
        message = 'Enter key of item to insert';
        _codePart = 2;
        return;
      case 2:
        try {
          insertItem = int.parse(userInput);
          tempItem = new Item(insertItem);
          message = 'Will insert item with key $insertItem';

          lowerBound = 0;
          upperBound = orderedArray.numberOfElements - 1;
          oldCurIn = curIn;
          curIn = ((upperBound - lowerBound) ~/ 2);
          _codePart = 3;
        } catch (error) {
          message = errorMessage;
          _codePart = 1;
        }
        return;
      case 3:
        if (curIn >= orderedArray.numberOfElements) {
          orderedArray.items[curIn] = tempItem;
          indexList = curIn;
          message = 'Insertion item $insertItem at index $curIn';
          _codePart = 6;
        } else {
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
          message = 'Loking for item with key $itemToFind';

          lowerBound = 0;
          upperBound = (orderedArray.numberOfElements - 1);
          oldCurIn = curIn;
          curIn = ((upperBound - lowerBound) ~/ 2);
          _codePart = 3;
        } catch (e) {
          message = errorMessage;
          _codePart = 1;
        }
        return;
      case 3: {
        if (orderedArray.items[curIn].number == itemToFind) {
          message = 'Have found item with key $itemToFind';
          _codePart = 4;
        } else if (lowerBound > upperBound) {
          message = "Can't find item with key $itemToFind";
          _codePart = 4;
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
        return;
      }
      case 4:
        oldCurIn = curIn;
        curIn = 0;
        message = initialMessage;
        _codePart = 1;
        indexList = curIn;
        return;
    }
  }
  void deleteItem() {}

}

