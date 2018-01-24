import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_input/material_input.dart';

import '../classes/item.dart';

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
  List<Item> items;
  Random random = new Random();
  String message;
  int listIndex;
  int _codePart;
  String userNumber;
  int _totalArraySize;

  ArrayComponent() {
    message = 'Press any button';
    _codePart = 1;
    items = new List<Item>();
    listIndex = 0;
    for(int i = 0; i < 20; i ++) {
      items.add(new Item(random.nextInt(1000)));
    }
  }

  @override
  void ngOnInit() {}

  void testIndex() {
    if(listIndex == items.length - 1)
      listIndex = 0;
    else 
      listIndex ++;
  }

  void newArray() {
    switch(_codePart) {
      case 1:
        message = 'Enter size of array to create';
        _totalArraySize = int.parse(userNumber);
        _codePart = 2;
        return;
      case 2: 
        if(userNumber.length > 0) {
          message = 'Will create empty arrayw with $userNumber cells';
          _codePart = 3;
        } else {
          _codePart = 1;
        }
        return;
      case 3:
        for(int i = 0; i < _totalArraySize; i++) {
          items = new List<Item>(_totalArraySize);
          message = 'New array created; total items 0';
        }
        _codePart = 6;
        return;        
      case 6: 
        message = 'Press any button';
        _codePart = 1;
        return;
    }
  }
}
