import 'package:show/src/api/event.dart';
import 'package:show/src/api/extension.dart';
import 'package:show/src/core/panel.dart';
import 'package:show/src/extensions/ui/ui_extension_events.dart';

import '../../api.dart';
import 'ui_extension_state.dart';

class UIExtension extends Extension {
  @override
  final String name = 'UIExtension';

  final _panels = <Panel>[];
  final _menus = <Panel>[];

  @override
  void onEvent(Event event) {
    if (event is AddMenuEvent) {
      _menus.add(event.panel);

      channel.setState<MenusState>(
        MenusState(panels: _menus),
      );
    } else if (event is LoadMenusEvent) {
      channel.setState<MenusState>(
        MenusState(panels: _menus),
      );
    } else if (event is AddPanelEvent) {
      _panels.add(event.panel);

      channel.setState<PanelsState>(
        PanelsState(panels: _panels),
      );
    } else if (event is LoadPanelsEvent) {
      channel.setState<PanelsState>(
        PanelsState(panels: _panels),
      );
    }
  }
}
