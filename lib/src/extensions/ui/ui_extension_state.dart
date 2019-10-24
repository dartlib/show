import 'package:show/src/api/state.dart';
import 'package:show/src/core/panel.dart';

abstract class UIExtensionState extends State {}

class PanelsState extends UIExtensionState {
  final List<Panel> panels;
  PanelsState({
    this.panels,
  });
}

class MenusState extends UIExtensionState {
  final List<Panel> panels;
  MenusState({
    this.panels,
  });
}
