import 'package:flutter/material.dart';

class TreeViewData extends StatelessWidget {
  final List<Widget> children;

  const TreeViewData({
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children.elementAt(index);
      },
    );
  }
}
