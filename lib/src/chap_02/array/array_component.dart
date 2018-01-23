import 'dart:math';

import 'package:angular/angular.dart';

import '../classes/item.dart';

@Component(
  selector: 'chap02-array',
  styleUrls: const ['array_component.css'],
  templateUrl: 'array_component.html',
  directives: const [
    CORE_DIRECTIVES,
  ]
)
class ArrayComponent implements OnInit {
  List<Item> items;
  Random random = new Random();
  ArrayComponent() {
    items = new List<Item>();
    for(int i = 0; i < 10; i ++) {
      items.add(new Item(random.nextInt(1000)));
    }
  }

  @override
  void ngOnInit() {}
}
