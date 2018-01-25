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
  int listIndex;
  int _codePart;
  String userInput;
  int _totalArraySize;

  ArrayComponent() {
    message = 'Press any button';
    _codePart = 1;
    arrayItem = new ArrayItem(20);
    arrayItem.fillArray(10);
    listIndex = 0;
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
       message = 'Press any button';
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
  void findItem(){}

  // TODO not complete  
  void deleteItem(){}
}
