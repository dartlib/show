import 'package:meta/meta.dart';

class TreeNode {
  final String name;
  final int index;
  TreeNode parent;
  List<TreeNode> children = [];

  TreeNode({
    @required this.name,
    @required this.index,
  });

  bool get isLeafNode {
    return children.isEmpty;
  }

  void addAll(List<TreeNode> items) {
    children.addAll(items.map((node) {
      node.parent = this;

      return node;
    }));
  }
}
