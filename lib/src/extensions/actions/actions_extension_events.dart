import 'package:show/src/api/event.dart';

import 'log_entry.dart';

abstract class ActionsExtensionEvent extends Event {}

class LogEntryEvent extends ActionsExtensionEvent {
  LogEntry entry;
  LogEntryEvent(this.entry);
}

class LoadActionMessagesEvent extends ActionsExtensionEvent {}
