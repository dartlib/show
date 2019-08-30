// ignore_for_file: avoid_classes_with_only_static_members
import 'package:flutter/material.dart';

import 'layout_column.dart';
import 'layout_grid.dart';

typedef LayoutFactory = Widget Function(List<Widget> items);

class Layout {
  static LayoutFactory gridLayout = layoutGrid;
  static LayoutFactory columnLayout = layoutColumn;
}
