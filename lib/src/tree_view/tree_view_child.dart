import 'package:flutter/material.dart';

import 'tree_item.dart';
import 'tree_view.dart';

class TreeViewChild extends StatefulWidget {
  final bool startExpanded;
  final TreeItem parent;
  final List<Widget> children;
  final TreeItemCallback onTap;
  final bool active;

  TreeViewChild({
    @required this.parent,
    @required this.children,
    @required this.active,
    this.startExpanded = true,
    this.onTap,
    Key key,
  }) : super(key: key) {
    assert(parent != null);
    assert(children != null);
  }

  @override
  TreeViewChildState createState() => TreeViewChildState();
}

class TreeViewChildState extends State<TreeViewChild> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          child: widget.parent,
          onTap: () => widget.onTap(widget.parent.node),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 400),
          child: widget.active
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.children,
                )
              : Offstage(),
        ),
      ],
    );
  }
}
