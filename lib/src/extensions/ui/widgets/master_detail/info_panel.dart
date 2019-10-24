import 'package:flutter/material.dart';
import 'package:show/src/core/panel.dart';

class InfoPanel extends StatefulWidget {
  final List<Panel> panels;
  InfoPanel({
    @required this.panels,
  });
  @override
  _InfoPanelState createState() => _InfoPanelState();
}

class _InfoPanelState extends State<InfoPanel>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: 2,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.panels.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TabBar(
            isScrollable: true,
            indicatorWeight: 1,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: const EdgeInsets.only(left: 8, right: 10),
            tabs: widget.panels
                .map((panel) =>
                    Tab(child: Row(children: <Widget>[Text(panel.name)])))
                .toList(),
          ),
          Expanded(
            child: TabBarView(
              children:
                  widget.panels.map((panel) => Card(child: panel)).toList(),
            ),
          )
        ],
      ),
    );
  }
}
