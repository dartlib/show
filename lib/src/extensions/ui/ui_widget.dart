import 'package:flutter/material.dart';
import 'package:show/src/api.dart';
import 'package:show/src/core/showcase.dart';
import 'package:show/src/extensions/ui/widgets/master_detail/master_detail_container.dart';

class UIWidget extends StatefulWidget {
  final Set<ShowCase> showCases;
  final ThemeData theme;
  final Api api;

  UIWidget({
    @required this.showCases,
    @required this.api,
    this.theme,
  })  : assert(showCases != null),
        assert(api != null);

  @override
  _UIWidgetState createState() => _UIWidgetState();
}

class _UIWidgetState extends State<UIWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Builder(
        builder: (_) => MasterDetailContainer(
          api: widget.api,
          theme: widget.theme,
          items: widget.showCases,
        ),
      ),
    );
  }
}
