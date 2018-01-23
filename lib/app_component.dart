import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';

import 'src/chap_02/array/array_component.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
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
  )
])
class AppComponent {}
