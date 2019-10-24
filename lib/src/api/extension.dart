import '../api.dart';
import 'event.dart';

abstract class Extension {
  String get name;
  Channel channel;

  /// Called after all extensions are registered
  Future<void> onInit() async {}

  /// Each extension is able to react to any event within the system
  void onEvent(Event event) {}
}
