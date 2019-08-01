import 'package:flutter/material.dart';

import 'grid_layout.dart';
import 'showcase_layout.dart';

typedef LayoutFactory = ShowCaseLayout Function(List<Widget> items);

class Layout {
  static LayoutFactory gridLayout =
      (children) => GridLayout(children: children);
}
