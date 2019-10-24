import 'package:show/src/api/event.dart';
import 'package:show/src/core/showcase_item.dart';

abstract class ShowCaseItemWidgetEvent extends Event {}

class ShowCaseItemLeaveEvent extends ShowCaseItemWidgetEvent {
  final ShowCaseItem showCaseItem;
  ShowCaseItemLeaveEvent({
    this.showCaseItem,
  });
}

class ShowCaseItemEnterEvent extends ShowCaseItemWidgetEvent {
  final ShowCaseItem showCaseItem;
  ShowCaseItemEnterEvent({
    this.showCaseItem,
  });
}
