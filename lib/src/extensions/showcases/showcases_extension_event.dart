import 'package:meta/meta.dart';
import 'package:show/src/api/event.dart';
import 'package:show/src/core/showcase.dart';
import 'package:show/src/core/showcase_item.dart';

abstract class ShowCaseExtensionEvent extends Event {}

class LoadShowCasesEvent extends ShowCaseExtensionEvent {}

class AddShowCasesEvent extends ShowCaseExtensionEvent {
  Set<ShowCase> showCases;
  AddShowCasesEvent({
    @required this.showCases,
  });
}

class SelectShowCaseEvent extends ShowCaseExtensionEvent {
  final ShowCase showCase;
  SelectShowCaseEvent({
    @required this.showCase,
  });
}

class SelectShowCaseItemEvent extends ShowCaseExtensionEvent {
  final ShowCaseItem item;
  SelectShowCaseItemEvent({
    @required this.item,
  });
}
