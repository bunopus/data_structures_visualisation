import 'package:angular_router/angular_router.dart';

import 'route_paths.dart' as paths;

import 'home/home_component.template.dart' as hctl;
import 'chap_02/array/array_component.template.dart' as actl;
import 'chap_02/order_array/order_array_component.template.dart' as oactl;

class Routes {
  RoutePath get home => paths.home;
  RoutePath get chap02_array => paths.chap02_array;
  RoutePath get chap02_order_array => paths.chap02_order_array;

  final List<RouteDefinition> all = [
// FIXME this causing endless loop. It's redirect from '' to home which is '' too
//    RouteDefinition.redirect(path: '', redirectTo: paths.home.toUrl()),
    RouteDefinition(
      path: paths.home.path,
      component: hctl.HomeComponentNgFactory,
    ),
    RouteDefinition(
      path: paths.chap02_array.path,
      component: actl.ArrayComponentNgFactory
    ),
    RouteDefinition(
      path: paths.chap02_order_array.path,
      component: oactl.OrderArrayComponentNgFactory
    )
  ];
}
