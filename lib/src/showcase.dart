import 'layouts/index.dart';
import 'show.dart';
import 'showcase_item.dart';

typedef ShowCaseFunction = void Function(Show show);

class ShowCase {
  Set<ShowCaseItem> items = {};
  String title;
  LayoutFactory layout;
  DecoratorFactory decorator;
  ShowCase({
    this.title,
    this.layout,
  }) {
    layout ??= Layout.columnLayout;
  }

  static Set<ShowCase> import(Iterable<ShowCaseFunction> showCases) {
    return showCases.map<ShowCase>((showCase) {
      final show = Show();

      showCase(show);

      return show.showCase;
    }).toSet();
  }
}
