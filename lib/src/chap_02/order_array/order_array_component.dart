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
        message = 'Enter key of item to insert';
        _codePart = 2;
        return;
      case 2:
        try {
          insertItem = int.parse(userInput);
          orderedArray.insertToArray(insertItem);
          _codePart = 3;
        } catch (error) {
          message = errorMessage;
          _codePart = 1;
        }
        return;
      case 3:
        message = 'Insertion complete Total items ${orderedArray.numberOfElements}';
        _codePart = 4;
        return;
      case 4:
        indexList = 0;
        _codePart = 1;
        message = initialMessage;
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

