import 'package:flutter/widgets.dart';
import 'package:show/show.dart';
import 'package:show/src/core/panel.dart';

class PropertiesPanel extends Panel {
  @override
  final String name = 'PropertiesPanel';
  @override
  final Channel channel;
  PropertiesPanel({
    @required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Properties Panel');
  }
}
