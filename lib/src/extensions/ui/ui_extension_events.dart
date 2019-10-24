import 'package:show/src/api/event.dart';
import 'package:show/src/core/panel.dart';

abstract class UIExtensionEvent extends Event {}

/// UI Extension  events
class AddPanelEvent extends UIExtensionEvent {
  final Panel panel;
  AddPanelEvent({
    this.panel,
  });
}

class AddMenuEvent extends UIExtensionEvent {
  final Panel panel;
  AddMenuEvent({
    this.panel,
  });
}

class LoadPanelsEvent extends UIExtensionEvent {}

class LoadMenusEvent extends UIExtensionEvent {}
