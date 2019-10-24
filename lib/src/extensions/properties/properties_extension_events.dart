import 'package:meta/meta.dart';
import 'package:show/src/api/event.dart';

abstract class PropertiesExtensionEvent extends Event {}

class PropertyUpdateEvent<T> extends PropertiesExtensionEvent {
  final String showCaseItemId;
  final String name;
  final T value;
  PropertyUpdateEvent({
    @required this.showCaseItemId,
    @required this.name,
    @required this.value,
  })  : assert(showCaseItemId != null),
        assert(name != null),
        assert(value != null);
}

class LoadPropertiesEvent extends PropertiesExtensionEvent {
  final String showCaseItemId;
  LoadPropertiesEvent({
    @required this.showCaseItemId,
  });
}
