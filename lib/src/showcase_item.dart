import 'package:flutter/material.dart';
import 'package:show/src/show.dart';

import 'layouts/index.dart';

typedef WidgetFactory = Widget Function();

class ShowCaseItem {
  String title;
  Set<WidgetFactory> items;
  LayoutFactory layout;
  DecoratorFactory decorator;
  ShowCaseItem({
    this.title,
    this.layout,
    this.decorator,
    this.items,
  });
}
