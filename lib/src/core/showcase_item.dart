import 'package:flutter/material.dart';
import 'package:show/show.dart';
import 'package:show/src/core/show.dart';

typedef WidgetFactory = Widget Function();
typedef ShowCaseFactory = Set<Widget> Function(BuildContext);

class ShowCaseItem {
  final String id;
  final String title;
  final String description;
  final ShowCaseFactory showCaseFactory;
  final LayoutFactory layout;
  final DecoratorFactory decorator;
  const ShowCaseItem({
    @required this.id,
    @required this.title,
    @required this.layout,
    @required this.decorator,
    @required this.showCaseFactory,
    this.description,
  }) : assert(id != null);
}
