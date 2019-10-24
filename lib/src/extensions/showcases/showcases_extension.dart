import 'package:show/src/api/event.dart';
import 'package:show/src/api/extension.dart';
import 'package:show/src/core/showcase.dart';
import 'package:show/src/core/showcase_item.dart';
import 'package:show/src/extensions/showcases/showcases_extension_event.dart';
import 'package:show/src/extensions/ui/ui_extension_events.dart';

import 'panels/show_cases_panel.dart';
import 'showcases_extension_state.dart';

class ShowCasesExtension extends Extension {
  @override
  final String name = 'ShowCasesExtension';

  @override
  Future<void> onInit() async {
    channel.fire(
      AddMenuEvent(
        panel: ShowCasesPanel(channel: channel),
      ),
    );
  }

  final _showCases = <ShowCase>{};
  ShowCaseItem _currentShowCaseItem;

  @override
  void onEvent(Event event) {
    if (event is AddShowCasesEvent) {
      _showCases.addAll(event.showCases);

      channel.setState<ShowCasesLoadedState>(
        ShowCasesLoadedState(showCases: _showCases),
      );
    } else if (event is LoadShowCasesEvent) {
      channel.setState<ShowCasesLoadedState>(
        ShowCasesLoadedState(showCases: _showCases),
      );
    } else if (event is SelectShowCaseItemEvent) {
      if (_currentShowCaseItem != null) {
        channel.fire(UnloadShowCaseItemEvent(item: _currentShowCaseItem));
      }
      _currentShowCaseItem = event.item;

      channel.setState<ShowCaseItemLoadedState>(
        ShowCaseItemLoadedState(
          item: _currentShowCaseItem,
        ),
      );
    }
  }
}
