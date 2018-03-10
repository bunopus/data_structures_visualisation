import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_input/material_input.dart';

import '../classes/array_item.dart';

@Component(
    selector: 'chap02-array',
    styleUrls: const ['array_component.css'],
    templateUrl: 'array_component.html',
    directives: const [
      MaterialButtonComponent,
      materialInputDirectives,
      CORE_DIRECTIVES,
    ])
class ArrayComponent implements OnInit {
  ArrayItem arrayItem;
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

  ArrayComponent() {
    message = initialMessage;
    _codePart = 1;
    arrayItem = new ArrayItem(20);
    arrayItem.fillArray(10);
    indexList = 0;
  }

  @override
  void ngOnInit() {}

  void newArray() {
    switch (_codePart) {
      case 1:
        message = 'Enter size of array to create';
        _codePart = 2;
        return;
      case 2:
        try {
          _totalArraySize = int.parse(userInput);
          if (_totalArraySize > 0) {
            message = 'Will create empty array with $_totalArraySize cells';
            _codePart = 3;
          } else {
            _codePart = 1;
          }
        } catch (e) {
          message = errorMessage;
          _codePart = 1;
        }
        return;
      case 3:
        arrayItem = new ArrayItem(_totalArraySize);
        message = 'New array created; total items ${arrayItem.numberOfElements}';
        _codePart = 4;
        return;
      case 4:
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
          if (fillSize <= arrayItem.size) {
            message = 'Will fill in $fillSize items';
            _codePart = 3;
          } else {
            message =
                "You can't fill array more then array size ${arrayItem.size}";
            _codePart = 1;
          }
        } catch (error) {
          message = errorMessage;
          _codePart = 1;
        }
        return;
      case 3:
        arrayItem.fillArray(fillSize);
        message = 'Fill complete; Total items = $fillSize';
        _codePart = 4;
        return;
      case 4:
        message = initialMessage;
        _codePart = 1;
        return;
    }
  }

  void insertArray() {
    switch (_codePart) {
      case 1:
        message = 'Enter key of item to insert';
        _codePart = 2;
        return;
      case 2:
        try {
          insertItem = int.parse(userInput);
          arrayItem.insertToArray(insertItem);
          int lastIndex = arrayItem.numberOfElements - 1;
          message = 'Insert item with key $insertItem at index $lastIndex';
          indexList = lastIndex;
          _codePart = 3;
        } catch (e) {
          message = errorMessage;
          _codePart = 1;
        }
        return;
      case 3:
        message = 'Insertion complete. Total items ${arrayItem.numberOfElements}';
        _codePart = 4;
        break;  
      case 4:
        indexList = 0;
        _codePart = 1;
        message = initialMessage;
        break;
    }
  }

  void findItem() {
    switch (_codePart) {
      case 1:
        message = 'Enter key of item to find';
        _codePart = 2;
        return;
      case 2:
        try {
          itemToFind = int.parse(userInput);
          message = 'Looking for item with key $itemToFind';
          _codePart = 3;
        } catch (e) {
          message = errorMessage;
          _codePart = 1;
        }
        return;
      case 3:
        if (arrayItem.items[indexList].number == itemToFind) {
          message = 'Have found item with key $itemToFind';
          _codePart = 4;
          return;
        } else {
          indexList++;
          if(indexList <= arrayItem.numberOfElements - 1) {
            message = 'Checking next cell; index $indexList';
          } else {
            message = "Haven't found element";
            _codePart = 5;
          }
          return;
        }
        break;
      case 4:
        message = initialMessage;
        _codePart = 1;
        indexList = 0;
        break;
      case 5:
        message = initialMessage;
        indexList = 0;
        _codePart = 1;
        break;
    }
  }

  void deleteItem() {
    switch (_codePart) {
      case 1:
        message = 'Enter key of item to delete';
        _codePart = 2;
        return;
      case 2:
        try {
          itemToFind = int.parse(userInput);
          message = 'Loking for item with key $itemToFind';
          _codePart = 3;
        } catch (e) {
          message = errorMessage;
          _codePart = 1;
        }
        return;
      case 3:
        if (arrayItem.items[indexList].number == itemToFind) {
          message = 'Have found and delete item with key $itemToFind';
          arrayItem.items[indexList] = null;
          _codePart = 4;
          return;
        } else {
          indexList++;
          message = 'Checking index = $indexList for item';
        }
        return;
      case 4:
        if (indexList < arrayItem.numberOfElements - 1) {
          indexList += 1;
          arrayItem.items[(indexList - 1)] = arrayItem.items[indexList];
          arrayItem.items[indexList] = null;
          message = 'Shifted item from ${indexList+1} to $indexList';
        } else {
          arrayItem.numberOfElements -= 1;
          message =
              'Shifting complete. Total items = ${arrayItem.numberOfElements}';
          indexList = arrayItem.numberOfElements - 1;
          _codePart = 5;
          return;
        }
        break;
      case 5:
        _codePart = 1;
        message = initialMessage;
        indexList = 0;
    }
  }
}
