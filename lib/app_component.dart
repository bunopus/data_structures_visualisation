import 'package:DartWorkshopLafore/src/material-footer/material_footer_component.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';

import 'src/routes.dart';

@Component(
  selector: 'my-app',
  styleUrls: const [
    'package:angular_components/app_layout/layout.scss.css',
    'app_component.css'
  ],
  templateUrl: 'app_component.html',
  directives: const [
    FooterComponent,
    routerDirectives,
    NgFor,
    NgIf,
    DeferredContentDirective,
    MaterialButtonComponent,
    MaterialIconComponent,
    MaterialPersistentDrawerDirective,
    MaterialToggleComponent,
    MaterialListComponent,
    MaterialListItemComponent,
  ],
  providers: const [
    ClassProvider(Routes)
  ],
)

class AppComponent {
  final Routes routes;
// FIXME Cannot cast Chapter to ChapterMenu
//  bool end = false;
//  bool overlay = false;
//  final List<ChapterMenu> chapterMenuList =
//    new List.from([
//      new Chapter('Chapter 2',
//        new List<Menu>.from([
//          new Menu('Array', 'Chap02Array'),
//          new Menu('Ordered Array', 'Chap02OrderArray'),
//        ])
//      )
//    ]);

  AppComponent(this.routes) {
//    window.console.log(chapterMenuList);
//    print(chapterMenuList);
  }
}
