import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';

import 'src/chap_02/array/array_component.dart';
import 'src/chap_02/order_array/order_array_component.dart';

import 'src/material-footer/material_footer_component.dart';
import 'src/home/home_component.dart';

@Component(
  selector: 'my-app',
  styleUrls: const [
    'package:angular_components/app_layout/layout.scss.css',
    'app_component.css'
  ],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    ROUTER_DIRECTIVES,
    FooterComponent
  ],
  providers: const [materialProviders],
)
@RouteConfig(const [
  const Route(
    path: '/',
    name: 'Home',
    component: HomeComponent
  ),
  const Route(
    path: '/chap02/array',
    name: 'Chap02Array',
    component: ArrayComponent
  ),
  const Route(
    path: '/chap02/order_array',
    name: 'Chap02OrderArray',
    component: OrderArrayComponent
  ),
])
class AppComponent {
  bool end = false;
  bool overlay = false;
}
