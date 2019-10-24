import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'index.dart';

LayoutFactory layoutGrid({
  int crossAxisCount = 3,
  EdgeInsets padding = const EdgeInsets.all(10),
}) {
  return (List<Widget> children) {
    return Scrollbar(
      child: StaggeredGridView.countBuilder(
        itemCount: children.length,
        crossAxisCount: crossAxisCount,
        padding: padding,
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
        itemBuilder: (BuildContext context, int index) => children[index],
      ),
    );
  };
}
