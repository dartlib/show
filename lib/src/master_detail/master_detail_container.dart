import 'package:flutter/material.dart';

import '../showcase.dart';
import '../showcase_item.dart';
import 'item_details.dart';
import 'item_listing.dart';

class MasterDetailContainer extends StatefulWidget {
  final Set<ShowCase> items;
  final Widget title;
  MasterDetailContainer({
    @required this.title,
    @required this.items,
  });
  @override
  _ItemMasterDetailContainerState createState() =>
      _ItemMasterDetailContainerState();
}

class _ItemMasterDetailContainerState extends State<MasterDetailContainer> {
  static const int kTabletBreakpoint = 600;

  ShowCaseItem _selectedItem;

  Widget _buildMobileLayout() {
    return const Text('TODO');
    /*
    return ItemListing(
      items: widget.items,
      itemSelectedCallback: (item) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ItemDetails(
                isInTabletLayout: false,
                item: item,
              );
            },
          ),
        );
      },
    );
    */
  }

  Widget _buildTabletLayout() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Material(
              elevation: 4.0,
              child: Column(
                children: _buildItems(context),
              )),
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

  List<Widget> _buildItems(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return widget.items.map((item) {
      return Column(children: [
        ListTile(
            title: Text(
          item.title ?? 'No title',
          style: textTheme.display2,
        )),
        ItemListing(
          items: item.items,
          itemSelectedCallback: (item) {
            setState(() {
              _selectedItem = item;
            });
          },
          selectedItem: _selectedItem,
        ),
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileLayout();
    } else {
      content = _buildTabletLayout();
    }

    return Scaffold(
      appBar: AppBar(
        title: widget.title,
      ),
      body: content,
    );
  }
}
