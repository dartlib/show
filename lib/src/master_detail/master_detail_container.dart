import 'package:flutter/material.dart';
import 'package:show/src/utils/uuid.dart';

import '../../show.dart';
import '../showcase.dart';
import 'item_details.dart';
import 'item_listing.dart';

class MasterDetailContainer extends StatefulWidget {
  final Set<ShowCaseFunction> items;
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

  int _selectedItemIndex;
  int _selectedShowCaseIndex;

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

  Widget _buildTabletLayout(Set<ShowCase> items) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Material(
              elevation: 4.0,
              child: Column(
                children: _buildItems(items, context),
              )),
        ),
        Flexible(
          flex: 3,
          child: ItemDetails(
            isInTabletLayout: true,
            item: _selectedItemIndex != null
                ? items
                    .elementAt(_selectedShowCaseIndex)
                    .items
                    .elementAt(_selectedItemIndex)
                : null,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildItems(Set<ShowCase> items, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    var i = -1;
    return items.map((item) {
      final showCaseIndex = ++i;

      return Column(
        key: Key(uuid()),
        children: [
          ListTile(
              title: Text(
            item.title ?? 'No title',
            style: textTheme.title,
          )),
          ItemListing(
            items: item.items,
            itemSelectedCallback: (int index) {
              setState(() {
                _selectedShowCaseIndex = showCaseIndex;
                _selectedItemIndex = index;
              });
            },
            selectedItem: _selectedItemIndex != null
                ? items
                    .elementAt(_selectedShowCaseIndex)
                    .items
                    .elementAt(_selectedItemIndex)
                : null,
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    final items = widget.items.map<ShowCase>((showCase) {
      final show = Show();

      showCase(show);

      return show.showCase;
    }).toSet();

    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileLayout();
    } else {
      content = Builder(builder: (_) => _buildTabletLayout(items));
    }

    return Scaffold(
      appBar: AppBar(
        title: widget.title,
      ),
      body: content,
    );
  }
}
