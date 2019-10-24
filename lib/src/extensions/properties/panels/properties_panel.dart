import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:show/show.dart';
import 'package:show/src/api/channel_builder.dart';
import 'package:show/src/core/panel.dart';
import 'package:show/src/extensions/properties/properties_extension_state.dart';
import 'package:show/src/extensions/showcases/showcases_extension_state.dart';

class PropertiesPanel extends Panel {
  @override
  final String name = 'PropertiesPanel';
  @override
  final Channel channel;
  PropertiesPanel({
    @required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    return ChannelBuilder<ShowCaseItemLoadedState>(
        channel: channel,
        builder: (BuildContext context,
            AsyncSnapshot<ShowCaseItemLoadedState> showCaseItemSnapshot) {
          if (showCaseItemSnapshot.hasData) {
            return ChannelBuilder<PropertiesLoadedState>(
              channel: channel,
              onListen: (channel) => channel.fire(
                LoadPropertiesEvent(
                  showCaseItemId: showCaseItemSnapshot.data.item.id,
                ),
              ),
              builder: (
                BuildContext context,
                AsyncSnapshot<PropertiesLoadedState> snapshot,
              ) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.properties.map(
                      (property) {
                        return Row(children: [
                          Text(property.name),
                          const SizedBox(width: 10),
                          Text(property.type.toString()),
                          const SizedBox(width: 10),
                          Text(property.value.toString()),
                        ]);
                      },
                    ).toList(),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
