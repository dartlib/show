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
    @required this.active,
    this.children = const [],
    this.startExpanded = true,
    this.onTap,
    Key key,
  }) : super(key: key) {
    assert(parent != null);
  }

  @override
  TreeViewChildState createState() => TreeViewChildState();
}

class TreeViewChildState extends State<TreeViewChild> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget child;
    final node = widget.parent;

    if (widget.active) {
      child = Container(
        color: theme.highlightColor,
        child: node,
      );
    } else {
      child = Container(
        child: node,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        widget.parent.node.isLeafNode
            ? InkWell(
                child: child,
                onTap: () => widget.onTap(widget.parent.node),
              )
            : GestureDetector(
                child: child,
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
