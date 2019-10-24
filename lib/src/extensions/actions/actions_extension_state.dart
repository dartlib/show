import 'package:meta/meta.dart';
import 'package:show/src/api/state.dart';

import 'log_entry.dart';

abstract class ActionsExtensionState extends State {}

class ActionMessagesState extends ActionsExtensionState {
  final List<LogEntry> messages;
  ActionMessagesState({
    @required this.messages,
  });
}
