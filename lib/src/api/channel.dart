import 'package:event_bus/event_bus.dart';

class Channel extends EventBus {
  Channel({bool sync = false}) : super(sync: sync);
}
