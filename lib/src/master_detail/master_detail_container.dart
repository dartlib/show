import 'package:flutter/material.dart';
import 'package:show/src/tree_view/tree_node.dart';

import '../../show.dart';
import '../showcase.dart';
import 'item_details.dart';
import 'item_listing.dart';

class MasterDetailContainer extends StatefulWidget {
  final Set<ShowCase> items;
  final Widget title;
  MasterDetailContainer({
    @required this.items,
    this.title,
  });
  @override
  _ItemMasterDetailContainerState createState() =>
      _ItemMasterDetailContainerState();
}

class _ItemMasterDetailContainerState extends State<MasterDetailContainer> {
  static const int kTabletBreakpoint = 600;

  int _selectedItemIndex;
  int _selectedShowCaseIndex;

  Widget _buildTabletLayout() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Material(
            elevation: 2.0,
            child: _buildItems(context),
          ),
        ),
        Flexible(
          flex: 3,
          child: ItemDetails(
            isInTabletLayout: true,
            item: _selectedItem,
          ),
        ),
      ],
    );
  }

  ShowCaseItem get _selectedItem {
    if (_selectedItemIndex != null && _selectedShowCaseIndex != null) {
      return widget.items
          .elementAt(_selectedShowCaseIndex)
          .items
          .elementAt(_selectedItemIndex);
    }

    return null;
  }

  Widget _buildItems(BuildContext context) {
    return ItemListing(
      items: widget.items,
      itemSelectedCallback: (TreeNode node) {
        setState(() {
          _selectedItemIndex = node.index;
          _selectedShowCaseIndex = node.parent.index;
        });
      },
      selectedItem: _selectedItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < kTabletBreakpoint) {
      content = const Text('Mobile not supported');
    } else {
      content = Builder(builder: (_) => _buildTabletLayout());
    }

    return Scaffold(
      appBar: AppBar(
        title: widget.title ?? _defaultTitle(),
      ),
      body: content,
    );
  }

  Widget _defaultTitle() {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/logo.png',
          package: 'show',
        ),
        const SizedBox(width: 8),
        const Text('Showcase'),
      ],
    );
  }
}
