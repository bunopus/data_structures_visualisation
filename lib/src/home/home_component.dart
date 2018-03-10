import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';

@Component(
  selector: 'home',
  styleUrls: const ['home_component.css'],
  templateUrl: 'home_component.html',
  directives: const[
    MaterialButtonComponent,
  ]
)
class HomeComponent {
  
}