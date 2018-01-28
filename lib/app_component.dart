import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';

import 'src/chap_02/array/array_component.dart';
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
    ROUTER_DIRECTIVES
  ],
  providers: const [materialProviders],
)
@RouteConfig(const [
  const Route(
    path: '/chap02/array',
    name: 'Chap02Array',
    component: ArrayComponent
  ),
  const Route(
    path: '/',
    name: 'Home',
    component: HomeComponent
  )
])
class AppComponent {
  bool end = false;
  bool overlay = false;
}
