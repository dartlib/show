import 'package:flutter/material.dart';

import 'tree_node.dart';

class TreeItem extends StatelessWidget {
  final TreeNode node;
  final bool expanded;

  TreeItem({
    @required this.node,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: <Widget>[
        if (!node.isLeafNode)
          Icon(
            expanded ? Icons.arrow_drop_down : Icons.arrow_right,
            size: 19.0,
          ),
        node.isLeafNode
            ? Padding(
                padding: const EdgeInsets.only(
                  top: 6.0,
                  bottom: 6.0,
                  left: 19.0,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.insert_drive_file,
                      size: 16.0,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      node.name,
                      style: textTheme.body1,
                    ),
                  ],
                ))
            : Padding(
                padding: const EdgeInsets.only(
                  top: 6.0,
                  bottom: 6.0,
                  // left: 12.0,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.folder_open,
                      color: theme.primaryColor,
                      size: 16.0,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      node.name,
                      style: textTheme.body2,
                    ),
                  ],
                ))
      ],
    );
  }
}
