import 'package:show/src/api.dart';

import '../actions.dart';

RegExp _exp = RegExp(r'\((.*)\)');

T action<T>(String title) {
  final channel = Api.instance.channel;
  final str = T.toString();
  final args = [];
  final Iterable<Match> matches = _exp.allMatches(str);

  if (matches != null) {
    final match = matches.first.group(1);

    if (match != '') {
      args.addAll(match.split(', '));
    }
  }

  if (args.isEmpty) {
    return () {
      channel.fire(
        LogEntryEvent(
          LogEntry(
            title: title,
            signature: T.toString(),
            params: [],
          ),
        ),
      );

      return null;
    } as T;
  }
  if (args.length == 1) {
    return (value) {
      channel.fire(
        LogEntryEvent(
          LogEntry(
            title: title,
            signature: T.toString(),
            params: [value],
          ),
        ),
      );

      return null;
    } as T;
  }

  return null;
}
