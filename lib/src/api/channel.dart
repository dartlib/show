import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:show/src/api/state.dart';

class Channel {
  final StreamController _streamController;

  /// Controller for the event bus stream.
  StreamController get streamController => _streamController;

  final _stateMap = <Type, dynamic>{};

  Channel({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);

  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  /// Fires a new event on the event bus with the specified [event].
  ///
  void fire(event) {
    streamController.add(event);
  }

  /// Initializes the state either when first set or upon first retrieval.
  ///
  Type _initState<S extends State>() {
    final type = _typeOf<S>();
    if (!_stateMap.containsKey(type)) {
      _stateMap[type] = BehaviorSubject<S>();
    }

    return type;
  }

  /// Update or create a new state on the stateful event bus with the specified [state].
  ///
  void setState<S extends State>(S state) {
    final type = _initState<S>();
    _stateMap[type].add(state);
  }

  /// Retrieves a state from the stateful event bus of [Type] [S]
  BehaviorSubject<S> getState<S extends State>() {
    final type = _initState<S>();

    return _stateMap[type] as BehaviorSubject<S>;
  }

  Type _typeOf<T>() => T;

  /// Destroy this [Channel]. This is generally only in a testing context.
  ///
  void destroy() {
    _streamController.close();
  }
}
