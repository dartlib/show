import 'layouts/index.dart';
import 'show.dart';
import 'showcase_item.dart';

class ShowCase {
  Set<ShowCaseItem> items = {};
  String title;
  LayoutFactory layout;
  DecoratorFactory decorator;
  ShowCase({
    this.title,
    this.layout,
  }) {
    layout ??= Layout.gridLayout;
  }
}
