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
  ]
)
class ArrayComponent implements OnInit {
  ArrayItem arrayItem;
  String message;
  int indexList;
  int _codePart;
  String userInput;
  int _totalArraySize;
  final String initialMessage = 'Press any button';

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
    switch(_codePart) {
     case 1:
       message = 'Enter size of array to create';
       _codePart = 2;
       return;
     case 2:
       _totalArraySize = int.parse(userInput);
       if(_totalArraySize > 0) {
         message = 'Will create empty arrayw with $_totalArraySize cells';
         _codePart = 3;
       } else {
         _codePart = 1;
       }
       return;
     case 3:
       for(int i = 0; i < _totalArraySize; i++) {
         arrayItem = new ArrayItem(_totalArraySize);
         message = 'New array created; total items ${arrayItem.numberOfElements}';
       }
       _codePart = 6;
       return;
     case 6:
       message = initialMessage;
       _codePart = 1;
       return;
   }
  }

  // TODO not complete
  void fillArray(){
    int fillSize = int.parse(userInput);
    if(fillSize <= arrayItem.size) {
      arrayItem.fillArray(fillSize);
    } else {
      message = "You can't fill array more then array size ${arrayItem.size}";
    }
  }

  // TODO not complete
  void insertArray(){
    arrayItem.insertToArray(int.parse(userInput));
  }

  // TODO not complete
  void findItem(){
    int itemToFind = int.parse(userInput);

    switch(_codePart) {
      case 1:
        message = 'Enter key of item to find';
        _codePart = 2;
        return;
      case 2:
        message = 'Looking for item with key $itemToFind';
        _codePart = 3;
        return;
      case 3:
        if(arrayItem.items[indexList].number == itemToFind) {
          message = 'Have found item with key $itemToFind';
          _codePart = 1;
          indexList = 0;
          return;
        } else {
          indexList ++;
          message = 'Checking next cell; index $indexList';
        }
        break;
    }
  }

  // TODO not complete  
  void deleteItem(){
    int itemToFind = int.parse(userInput);
    switch(_codePart) {
      case 1:
        message = 'Enter key of item to delete';
        _codePart = 2;
        return;
      case 2:
        message = 'Loking for item with key $itemToFind';
        _codePart = 3;
        return;
      case 3:
        if(arrayItem.items[indexList].number == itemToFind) {
          message = 'Have found and delete item with key $itemToFind';
          arrayItem.items[indexList] = null;
          _codePart = 4;
          return;
        } else {
          indexList ++;
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
          message = 'Shifting complete. Total items = ${arrayItem.numberOfElements}';
          indexList = arrayItem.numberOfElements - 1;
          _codePart = 5;
          return;
        }
        print('Need to do Shifting');
        break;
      case 5: 
        _codePart = 1;
        message = initialMessage;
        indexList = 0;  
    }    
  }
}
