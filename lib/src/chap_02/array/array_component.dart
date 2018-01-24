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
  ArrayComponent() {
    message = 'Press any button';
    items = new List<Item>();
    listIndex = 0;
    for(int i = 0; i < 10; i ++) {
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
}
