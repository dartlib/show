import 'package:flutter/widgets.dart';
import 'package:show/src/extensions/ui/widgets/showcase_item_widget.dart';

import 'properties_extension.dart';

class Prop<T> {
  final String title;
  final T defaultValue;
  Prop(
    this.title,
    this.defaultValue,
  );

  T of(BuildContext context) {
    final showCaseItemWidget = context
        .ancestorWidgetOfExactType(ShowCaseItemWidget) as ShowCaseItemWidget;

    final value =
        showCaseItemWidget.api.getExtension<PropertiesExtension>().getProp<T>(
              showCaseItemWidget.showCaseItem.id,
              title,
              defaultValue,
            );

    return value;
  }
}
