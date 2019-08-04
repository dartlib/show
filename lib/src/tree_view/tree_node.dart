import 'package:meta/meta.dart';
import 'package:show/show.dart';

class TreeNode {
  final String name;
  final TreeNode parent;
  final int index;
  List<TreeNode> children = [];

  TreeNode({
    @required this.name,
    @required this.index,
    this.parent,
  });

  bool get isLeafNode {
    return children.isEmpty;
  }

  void addAll(Set<ShowCaseItem> items) {
    var index = 0;
    children.addAll(items.map((item) {
      return TreeNode(
        name: item.title,
        index: index++,
        parent: this,
      );
    }).toList());
  }
}
