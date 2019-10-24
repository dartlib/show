import 'package:meta/meta.dart';
import 'package:show/src/api/state.dart';
import 'package:show/src/core/showcase.dart';
import 'package:show/src/core/showcase_item.dart';

abstract class ShowCaseExtensionState extends State {}

class LoadShowCasesState extends ShowCaseExtensionState {}

class ShowCasesLoadedState extends ShowCaseExtensionState {
  Set<ShowCase> showCases;
  ShowCasesLoadedState({
    @required this.showCases,
  });
}

class ShowCaseItemLoadedState extends ShowCaseExtensionState {
  ShowCaseItem item;
  ShowCaseItemLoadedState({
    @required this.item,
  });
}
