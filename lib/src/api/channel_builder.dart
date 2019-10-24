import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:show/src/api/state.dart' as api;

import 'channel.dart';

typedef ChannelCallback = Function(Channel channel);

class ChannelBuilder<T extends api.State> extends StatefulWidget {
  const ChannelBuilder({
    @required this.channel,
    @required this.builder,
    this.onListen,
    Key key,
  })  : assert(builder != null),
        assert(channel != null),
        super(key: key);

  final Channel channel;
  final ChannelCallback onListen;
  final AsyncWidgetBuilder<T> builder;

  AsyncSnapshot<T> initial() {
    return AsyncSnapshot<T>.withData(ConnectionState.none, null);
  }

  AsyncSnapshot<T> afterConnected(AsyncSnapshot<T> current) {
    if (onListen != null) {
      onListen(channel);
    }
    return current.inState(ConnectionState.waiting);
  }

  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
    return AsyncSnapshot<T>.withData(ConnectionState.active, data);
  }

  AsyncSnapshot<T> afterError(AsyncSnapshot<T> current, Object error) {
    return AsyncSnapshot<T>.withError(ConnectionState.active, error);
  }

  AsyncSnapshot<T> afterDone(AsyncSnapshot<T> current) =>
      current.inState(ConnectionState.done);

  AsyncSnapshot<T> afterDisconnected(AsyncSnapshot<T> current) =>
      current.inState(ConnectionState.none);

  Widget build(BuildContext context, AsyncSnapshot<T> currentSummary) =>
      builder(context, currentSummary);

  @override
  State<ChannelBuilder<T>> createState() => _ChannelBuilderState<T>();
}

class _ChannelBuilderState<T extends api.State>
    extends State<ChannelBuilder<T>> {
  StreamSubscription<T> _subscription;
  AsyncSnapshot<T> _state;
  Stream<T> _stream;

  @override
  void initState() {
    super.initState();
    _state = widget.initial();
    _subscribe();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, _state);

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  Future<void> _subscribe() async {
    if (widget.channel != null) {
      _stream = widget.channel.getState<T>();

      _subscription = _stream.listen((T data) {
        setState(() {
          _state = widget.afterData(_state, data);
        });
      }, onError: (Object error) {
        setState(() {
          _state = widget.afterError(_state, error);
        });
      }, onDone: () {
        setState(() {
          _state = widget.afterDone(_state);
        });
      });

      _state = widget.afterConnected(_state);
    }
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }
}
