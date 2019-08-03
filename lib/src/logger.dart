import 'dart:async';

import 'package:flutter/material.dart';

import 'action.dart';

class Logger extends StatefulWidget {
  @override
  _LoggerState createState() => _LoggerState();
}

class _LoggerState extends State<Logger> {
  StreamSubscription actionStreamSubscription;
  @override
  void initState() {
    actionStreamSubscription = actionStream.listen(onData);
    super.initState();
  }

  List<LogEntry> actions = [];

  void onData(dynamic data) {
    setState(() {
      actions.add(data as LogEntry);
    });
  }

  @override
  void dispose() {
    actionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final entries = actions
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
}
