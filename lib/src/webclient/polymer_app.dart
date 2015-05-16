// The HTML import containing our <polymer-element>
@HtmlImport('polymer_app.html')
library matrix.webclient.app;

import 'dart:js';
import 'dart:html';
import 'package:core_elements/core_scaffold.dart';
import 'package:polymer/polymer.dart';
import 'package:route_hierarchical/client.dart';

export 'package:core_elements/core_ajax_dart.dart';
export 'package:core_elements/core_a11y_keys.dart';
export 'package:core_elements/core_animated_pages.dart';
export 'package:core_elements/core_animated_pages/transitions/slide_from_right.dart';
export 'package:core_elements/core_icon.dart';
export 'package:core_elements/core_icon_button.dart';
export 'package:core_elements/core_menu.dart';
export 'package:core_elements/core_scaffold.dart';
export 'package:core_elements/core_toolbar.dart';
export 'package:core_elements/roboto.dart';
export 'package:paper_elements/paper_item.dart';
export 'package:matrix/src/webclient/app_login.dart';

@CustomTag('polymer-app')
class PolymerApp extends PolymerElement {

  /// The path of the current [Page].
  @observable var route;

  /// The current selected [Page].
  @observable Page selectedPage;

  /// The [Router] that controls the app.
  final Router router = new Router(useFragment: true);

  /// The list of pages in our app.
  final List<Page> pages = const [
    const Page('Single', 'one', isDefault: true),
    const Page('page', 'two'),
    const Page('app', 'three'),
    const Page('using', 'four'),
    const Page('Polymer', 'five'),
  ];

  PolymerApp.created() : super.created();

  String get selectedPath => 'login';
  void set selectedPath(String value) => print('trying to change selectedPath to $value');

  domReady() {
    // Set up the routes for all the pages.
    router.root.addRoute(name: 'Matrix', path: 'matrix', defaultRoute: false, enter: enterRoute);
    for (var page in pages) {
      router.root.addRoute(
          name: page.name, path: page.path,
          defaultRoute: page.isDefault,
          enter: enterRoute);
    }
    router.listen();
  }

  /// Updates [selectedPage] and the current route whenever the route changes.
  void routeChanged() {
    if (route is! String) return;
    if (route.isEmpty) {
      selectedPage = pages.firstWhere((page) => page.isDefault);
    } else {
      selectedPage = pages.firstWhere((page) => page.path == route);
    }
    router.go(selectedPage.name, {});
  }

  /// Updates [route] whenever we enter a new route.
  void enterRoute(RouteEvent e) {
    route = e.path;
  }

  /// Cycles pages on click.
  void cyclePages(Event e, detail, sender) {
    var event = new JsObject.fromBrowserObject(e);
    // Clicks on links should not cycle pages.
    if (event['target'].localName != 'a') {
      event['shiftKey'] ? sender.selectPrevious(true) : sender.selectNext(true);
    }
  }

  CoreScaffold get scaffold => $['app-scaffold'];

  void menuItemClicked(_) {
    scaffold.closeDrawer();
  }

}


class Page {
  final String name;
  final String path;
  final bool isDefault;
  const Page(this.name, this.path, {this.isDefault: false});

  String toString() => 'Page{name: $name, path: $path, isDefault: $isDefault}';
}

