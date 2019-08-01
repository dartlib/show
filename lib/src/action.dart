import 'dart:async';

final _actionStreamController = StreamController();

final actionStream = _actionStreamController.stream;

class LogEntry {
  String title;
  String signature;
  List params;
  LogEntry({
    this.title,
    this.signature,
    this.params = const [],
  });
}

RegExp _exp = RegExp(r'\((.*)\)');

T action<T>(String title) {
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
      _actionStreamController.sink.add(
        LogEntry(
          title: title,
          signature: T.toString(),
          params: [],
        ),
      );

      return null;
    } as T;
  }
  if (args.length == 1) {
    return (value) {
      _actionStreamController.sink.add(
        LogEntry(
          title: title,
          signature: T.toString(),
          params: [value],
        ),
      );

      return null;
    } as T;
  }

  return null;
}
