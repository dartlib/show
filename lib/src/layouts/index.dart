// ignore_for_file: avoid_classes_with_only_static_members
import 'package:flutter/material.dart';

import 'layout_column.dart';
import 'layout_grid.dart';

typedef LayoutFactory = Widget Function(List<Widget> children);

class Layout {
  static final gridLayout = layoutGrid;
  static final gridLayout2 = layoutGrid(crossAxisCount: 2);
  static final gridLayout3 = layoutGrid(crossAxisCount: 3);
  static final gridLayout4 = layoutGrid(crossAxisCount: 4);
  static final columnLayout = layoutColumn;
}
