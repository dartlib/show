import 'package:show/src/api/event.dart';
import 'package:show/src/api/extension.dart';
import 'package:show/src/extensions/actions/actions_extension_state.dart';
import 'package:show/src/extensions/ui/ui_extension_events.dart';

import '../../api.dart';
import 'actions_extension_events.dart';
import 'models/log_entry.dart';
import 'panels/actions_panel.dart';

class ActionsExtension extends Extension {
  @override
  Future<void> onInit() async {
    channel.fire(
      AddPanelEvent(
        panel: ActionsPanel(channel: channel),
      ),
    );
  }

  @override
  final String name = 'ActionsExtension';

  final List<LogEntry> actions = [];

  @override
  void onEvent(Event event) {
    if (event is LogEntryEvent) {
      actions.add(event.entry);

      channel.fire(ActionMessagesState(messages: actions));
    } else if (event is LoadActionMessagesEvent) {
      channel.fire(ActionMessagesState(messages: actions));
    }
  }
}
