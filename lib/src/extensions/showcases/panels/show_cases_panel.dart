import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:show/src/api/channel.dart';
import 'package:show/src/api/channel_builder.dart';
import 'package:show/src/core/panel.dart';
import 'package:show/src/core/showcase.dart';
import 'package:show/src/core/showcase_item.dart';
import 'package:show/src/extensions/showcases/showcases_extension_event.dart';
import 'package:show/src/extensions/ui/widgets/tree_view/tree_node.dart';
import 'package:show/src/extensions/ui/widgets/tree_view/tree_view.dart';

import '../showcases_extension_state.dart';

class ShowCasesPanel extends Panel {
  @override
  final String name = 'ShowCasesPanel';

  @override
  final Channel channel;

  ShowCasesPanel({
    @required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    return ChannelBuilder<ShowCasesLoadedState>(
      channel: channel,
      onListen: (channel) => channel.fire(LoadShowCasesEvent()),
      builder: (context, AsyncSnapshot<ShowCasesLoadedState> snapshot) {
        if (snapshot.hasData) {
          return ItemListing(
            items: snapshot.data.showCases,
            showCaseSelectedCallback: (ShowCase showCase) =>
                channel.fire(SelectShowCaseEvent(showCase: showCase)),
            itemSelectedCallback: (ShowCaseItem item) => channel.fire(
              SelectShowCaseItemEvent(item: item),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ItemListing extends StatefulWidget {
  final Set<ShowCase> items;
  final Function(ShowCase showCase) showCaseSelectedCallback;
  final Function(ShowCaseItem showCaseItem) itemSelectedCallback;
  ItemListing({
    @required this.items,
    @required this.showCaseSelectedCallback,
    @required this.itemSelectedCallback,
  });

  @override
  _ItemListingState createState() => _ItemListingState();
}

class _ItemListingState extends State<ItemListing> {
  @override
  Widget build(BuildContext context) {
    return TreeView(
      startExpanded: true,
      onTap: _itemSelectedCallback,
      children: _parseShowCases(),
    );
  }

  void _itemSelectedCallback(TreeNode node) {
    if (node.parent == null) {
      final showCase = widget.items.elementAt(node.index);
      widget.showCaseSelectedCallback(showCase);
    } else {
      final showCaseItem =
          widget.items.elementAt(node.parent.index).items.elementAt(node.index);

      widget.itemSelectedCallback(showCaseItem);
    }
  }

  List<TreeNode> _parseShowCases() {
    var index = 0;

    return widget.items.map((showCase) {
      return TreeNode(
        index: index++,
        name: showCase.title,
      )..addAll(_buildChildren(showCase.items));
    }).toList();
  }

  List<TreeNode> _buildChildren(Set<ShowCaseItem> items) {
    var index = 0;
    return items.map((item) {
      return TreeNode(
        name: item.title,
        index: index++,
      );
    }).toList();
  }
}
