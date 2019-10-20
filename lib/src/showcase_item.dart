import 'package:flutter/material.dart';
import 'package:show/src/show.dart';

import 'layouts/index.dart';

typedef WidgetFactory = Widget Function();
typedef ShowCaseFactory = Set<Widget> Function(BuildContext);

class ShowCaseItem {
  final String title;
  final String description;
  final ShowCaseFactory showCaseFactory;
  final LayoutFactory layout;
  final DecoratorFactory decorator;
  const ShowCaseItem({
    @required this.title,
    @required this.layout,
    @required this.decorator,
    @required this.showCaseFactory,
    this.description,
  });
}
