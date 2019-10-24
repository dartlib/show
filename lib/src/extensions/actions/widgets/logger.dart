import 'package:flutter/material.dart';
import 'package:show/show.dart';
import 'package:show/src/api/channel_builder.dart';

import '../actions_extension_state.dart';

class Logger extends StatefulWidget {
  final Channel channel;
  Logger({
    @required this.channel,
  }) : assert(channel != null);
  @override
  _LoggerState createState() => _LoggerState();
}

class _LoggerState extends State<Logger> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ChannelBuilder<ActionMessagesState>(
        channel: widget.channel,
        onListen: (channel) => channel.fire(LoadActionMessagesEvent()),
        builder: (context, AsyncSnapshot<ActionMessagesState> snapshot) {
          if (snapshot.hasData) {
            final entries = snapshot.data.messages
                .map((data) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Row(
                          children: <Widget>[
                            Text(
                              data.title,
                              style: textTheme.body2,
                            ),
                            const SizedBox(width: 10),
                            ...data.params.map(
                              (param) => Text(
                                '$param',
                                style: textTheme.body2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '(${data.signature})',
                          style: textTheme.body1,
                        ),
                      )
                    ],
                  );
                })
                .toList()
                .reversed
                .toList();

            return Scrollbar(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(20.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(entries),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
