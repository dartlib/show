import 'package:flutter/widgets.dart';
import 'package:show/show.dart';
import 'package:show/src/core/showcase_item.dart';

class ShowCaseItemWidget extends StatefulWidget {
  final Api api;

  final Widget child;
  final ShowCaseItem showCaseItem;

  ShowCaseItemWidget({
    @required this.api,
    @required this.showCaseItem,
    @required this.child,
    Key key,
  })  : assert(api != null),
        assert(showCaseItem != null),
        assert(child != null),
        super(
          key: key,
        );
  @override
  _ShowCaseItemWidgetState createState() => _ShowCaseItemWidgetState();
}

class _ShowCaseItemWidgetState extends State<ShowCaseItemWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
