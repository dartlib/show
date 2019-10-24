import 'package:show/src/api/state.dart';

import '../properties.dart';

abstract class PropertiesExtensionState extends State {}

class PropertiesLoadedState extends PropertiesExtensionState {
  final List<Property> properties;
  PropertiesLoadedState({
    this.properties,
  });
}
