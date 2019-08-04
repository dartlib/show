import 'package:flutter/material.dart';
import 'package:show/src/tree_view/tree_item.dart';

import 'tree_node.dart';

typedef TreeItemCallback = Function(TreeNode node);

class TreeView extends InheritedWidget {
  final List<Widget> children;
  final bool startExpanded;

  TreeView({
    Key key,
    @required this.children,
    this.startExpanded = false,
  }) : super(
          key: key,
          child: _TreeViewData(
            children: children,
          ),
        );

  @override
  bool updateShouldNotify(TreeView oldWidget) {
    if (oldWidget.children == children &&
        oldWidget.startExpanded == startExpanded) {
      return false;
    }
    return true;
  }
}

class _TreeViewData extends StatelessWidget {
  final List<Widget> children;

  const _TreeViewData({
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

class TreeViewChild extends StatefulWidget {
  final bool startExpanded;
  final TreeItem parent;
  final List<Widget> children;
  final TreeItemCallback onTap;

  TreeViewChild({
    @required this.parent,
    @required this.children,
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
  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.startExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          child: widget.parent,
          onTap: widget.parent.node.isLeafNode
              ? () => widget.onTap(widget.parent.node)
              : toggleExpanded,
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 400),
          child: isExpanded
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.children,
                )
              : Offstage(),
        ),
      ],
    );
  }

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
