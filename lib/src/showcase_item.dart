import 'package:flutter/material.dart';
import 'package:show/src/show.dart';

import 'layouts/index.dart';

typedef WidgetFactory = Widget Function();
typedef ShowCaseFactory = Set<Widget> Function(BuildContext);

class ShowCaseItem {
  String title;
  ShowCaseFactory showCaseFactory;
  LayoutFactory layout;
  DecoratorFactory decorator;
  ShowCaseItem({
    @required this.title,
    @required this.layout,
    @required this.decorator,
    @required this.showCaseFactory,
  });
}
