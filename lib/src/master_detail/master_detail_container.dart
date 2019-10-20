import 'package:flutter/material.dart';
import 'package:show/src/tree_view/tree_node.dart';

import '../../show.dart';
import '../showcase.dart';
import 'dragger.dart';
import 'item_details.dart';
import 'item_listing.dart';

class MasterDetailContainer extends StatefulWidget {
  final Set<ShowCase> items;
  final Widget title;

  /// Sets the theme which should be used for displaying your components.
  /// e.g. your theme.
  final ThemeData theme;
  MasterDetailContainer({
    @required this.items,
    this.theme,
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
  double sideBarWidth = 200;
  double minSideBarWidth = 200;
  double infoPanelHeight = 300;
  double minInfoPanelHeight = 100;

  void _onDragSideBarUpdate(Offset position, Offset delta) {
    print(position);
    setState(() {
      if (sideBarWidth >= minSideBarWidth || !delta.dx.isNegative) {
        sideBarWidth += delta.dx;
      }
    });
  }

  void _onDragInfoPanelUpdate(Offset position, Offset delta) {
    print(position);
    setState(() {
      if (infoPanelHeight >= minInfoPanelHeight || delta.dy.isNegative) {
        infoPanelHeight -= delta.dy;
      }
    });
  }

  Widget _buildTabletLayout() {
    final theme = Theme.of(context);

    final handleColor = theme.primaryColor.withAlpha(150);

    return Row(
      children: <Widget>[
        Container(
          width: sideBarWidth,
          child: Material(
            elevation: 2.0,
            child: _buildItems(context),
          ),
        ),
        Dragger(
          axis: Axis.horizontal,
          onDragUpdate: _onDragSideBarUpdate,
          child: SizedBox(
            width: 5,
            child: Container(
              color: handleColor,
            ),
          ),
        ),
        Flexible(
            flex: 3,
            child: _selectedItem == null
                ? const Center(child: Text('Choose an item on the left'))
                : Column(
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: CustomScrollView(
                          slivers: <Widget>[
                            if (_selectedItem.description != null)
                              SliverToBoxAdapter(
                                child: Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(_selectedItem.description),
                                ),
                              ),
                            SliverFillRemaining(
                              child: ItemDetails(
                                isInTabletLayout: true,
                                theme: widget.theme,
                                item: _selectedItem,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Dragger(
                        axis: Axis.vertical,
                        onDragUpdate: _onDragInfoPanelUpdate,
                        child: SizedBox(
                          height: 5,
                          child: Container(
                            color: handleColor,
                          ),
                        ),
                      ),
                      Container(
                        height: infoPanelHeight,
                        child: Card(
                          child: Logger(),
                        ),
                      )
                    ],
                  )),
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
