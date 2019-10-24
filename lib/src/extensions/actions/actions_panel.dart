import 'package:flutter/widgets.dart';
import 'package:show/show.dart';
import 'package:show/src/core/panel.dart';

class ActionsPanel extends Panel {
  @override
  final String name = 'Actions';

  @override
  final Channel channel;

  ActionsPanel({
    @required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    return Logger(channel: channel);
  }
}
