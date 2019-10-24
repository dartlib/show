import 'package:show/src/api/event.dart';
import 'package:show/src/api/extension.dart';
import 'package:show/src/extensions/properties/properties_extension_state.dart';
import 'package:show/src/extensions/showcases/showcases_extension_event.dart';
import 'package:show/src/extensions/ui/ui_extension_events.dart';

import '../../api.dart';
import 'panels/properties_panel.dart';
import 'properties_extension_events.dart';
import 'property_container.dart';

class PropertiesExtension extends Extension {
  final _propertyContainerMap = <String, PropertyContainer>{};

  @override
  final name = 'Properties';

  @override
  Future<void> onInit() async {
    channel.fire(
      AddPanelEvent(
        panel: PropertiesPanel(channel: channel),
      ),
    );
  }

  @override
  void onEvent(Event event) {
    if (event is PropertyUpdateEvent) {
      setProp(
        event.showCaseItemId,
        event.name,
        event.value,
      );
    } else if (event is PropertyUpdateEvent) {
      setProp(
        event.showCaseItemId,
        event.name,
        event.value,
      );
    } else if (event is LoadPropertiesEvent) {
      _setPropertiesLoadedState(event.showCaseItemId);
    } else if (event is SelectShowCaseItemEvent) {
      _setPropertiesLoadedState(event.item.id);
    }
  }

  void _setPropertiesLoadedState(String itemId) {
    if (_propertyContainerMap.containsKey(itemId)) {
      final propertyContainer = _propertyContainerMap[itemId];

      channel.setState<PropertiesLoadedState>(
        PropertiesLoadedState(
          properties: propertyContainer.values.toList(),
        ),
      );
    } else {
      channel.setState<PropertiesLoadedState>(
        PropertiesLoadedState(
          properties: [],
        ),
      );
    }
  }

  T getProp<T>(String showCaseItemId, String titleKey, T defaultValue) {
    final propertyContainer = _getPropertyContainer(showCaseItemId);

    if (!propertyContainer.has(titleKey)) {
      propertyContainer.set<T>(titleKey, defaultValue);
    }

    final def = propertyContainer.get(titleKey);

    return def.value as T;
  }

  void setProp<T>(String showCaseItemId, String titleKey, T value) {
    final propertyContainer = _getPropertyContainer(showCaseItemId);

    if (propertyContainer.has(titleKey)) {
      propertyContainer.set<T>(titleKey, value);
    } else {
      throw Exception('Cannot update unknown property $titleKey');
    }
  }

  PropertyContainer _getPropertyContainer(String showCaseItemId) {
    if (!_propertyContainerMap.containsKey(showCaseItemId)) {
      _propertyContainerMap[showCaseItemId] = PropertyContainer();
    }

    return _propertyContainerMap[showCaseItemId];
  }
}
