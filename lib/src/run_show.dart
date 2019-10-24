import 'package:flutter/material.dart';
import 'package:show/src/extensions/showcases/showcases_extension.dart';
import 'package:show/src/extensions/showcases/showcases_extension_event.dart';
import 'package:show/src/extensions/ui/ui_extension.dart';

import 'api/api.dart';
import 'core/showcase.dart';
import 'extensions/actions/actions_extension.dart';
import 'extensions/properties/properties_extension.dart';
import 'extensions/ui/ui_widget.dart';

void runShow({
  Set<ShowCase> showCases,
  ThemeData theme,
}) async {
  Api.instance
    ..registerExtension(UIExtension())
    ..registerExtension(ShowCasesExtension())
    ..registerExtension(ActionsExtension())
    ..registerExtension(PropertiesExtension());

  runApp(
    UIWidget(
      theme: theme,
      api: Api.instance,
    ),
  );

  await Api.instance.initialize();

  Api.instance.channel.fire(
    AddShowCasesEvent(showCases: showCases),
  );
}
