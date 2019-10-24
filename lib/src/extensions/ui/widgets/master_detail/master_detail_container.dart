import 'package:flutter/material.dart';
import 'package:show/show.dart';
import 'package:show/src/api/channel_builder.dart';
import 'package:show/src/extensions/showcases/showcases_extension_state.dart';
import 'package:show/src/extensions/ui/ui_extension_events.dart';

import '../../ui_extension_state.dart';
import 'dragger.dart';
import 'info_panel.dart';
import 'item_details.dart';

class MasterDetailContainer extends StatefulWidget {
  final Widget title;
  final Api api;

  /// Sets the theme which should be used for displaying your components.
  /// e.g. your theme.
  final ThemeData theme;
  MasterDetailContainer({
    @required this.api,
    this.theme,
    this.title,
  }) : assert(api != null);
  @override
  _ItemMasterDetailContainerState createState() =>
      _ItemMasterDetailContainerState();
}

class _ItemMasterDetailContainerState extends State<MasterDetailContainer> {
  static const int kTabletBreakpoint = 600;

  double sideBarWidth = 200;
  double minSideBarWidth = 200;
  double infoPanelHeight = 300;
  double minInfoPanelHeight = 100;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            child: ChannelBuilder<MenusState>(
              channel: widget.api.channel,
              onListen: (channel) => channel.fire(LoadMenusEvent()),
              builder: (
                context,
                AsyncSnapshot<MenusState> snapshot,
              ) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.panels
                        .map((panel) => Expanded(child: panel))
                        .toList(),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
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
          child: ChannelBuilder<ShowCaseItemLoadedState>(
            channel: widget.api.channel,
            builder: (
              BuildContext context,
              AsyncSnapshot<ShowCaseItemLoadedState> snapshot,
            ) {
              if (snapshot.hasData) {
                final item = snapshot.data.item;
                return Column(
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: CustomScrollView(
                        slivers: <Widget>[
                          if (item.description != null)
                            SliverToBoxAdapter(
                              child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item.description),
                              ),
                            ),
                          SliverFillRemaining(
                            child: ItemDetails(
                              isInTabletLayout: true,
                              theme: widget.theme,
                              item: item,
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
                      child: ChannelBuilder<PanelsState>(
                        channel: widget.api.channel,
                        onListen: (channel) => channel.fire(LoadPanelsEvent()),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<PanelsState> snapshot,
                        ) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error loading panels'),
                            );
                          } else if (snapshot.hasData) {
                            return InfoPanel(
                              panels: snapshot.data.panels,
                            );
                          }

                          return const Center(
                            child: Text('Loading panels'),
                          );
                        },
                      ),
                    )
                  ],
                );
              }
              return const Center(child: Text('Choose an item on the left'));
            },
          ),
        ),
      ],
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
      resizeToAvoidBottomInset: false, // avoid overflow on keyboard input.
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
