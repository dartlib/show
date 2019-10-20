// ignore_for_file: avoid_classes_with_only_static_members
import 'package:flutter/material.dart';

import 'layout_column.dart';
import 'layout_grid.dart';

typedef LayoutFactory = Widget Function(List<Widget> items);

class Layout {
  static LayoutFactory gridLayout = layoutGrid();
  static LayoutFactory gridLayout2 = layoutGrid(crossAxisCount: 2);
  static LayoutFactory gridLayout3 = layoutGrid(crossAxisCount: 3);
  static LayoutFactory gridLayout4 = layoutGrid(crossAxisCount: 4);
  static LayoutFactory gridLayout5 = layoutGrid(crossAxisCount: 4);
  static LayoutFactory gridLayout6 = layoutGrid(crossAxisCount: 6);
  static LayoutFactory columnLayout = layoutColumn;
}
