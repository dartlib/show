import 'dart:async';

import 'package:show/show.dart';
import 'package:show/src/core/panel.dart';

import 'channel.dart';
import 'event.dart';
import 'extension.dart';

class Api {
  final channel = Channel();
  final _extensions = <Type, Extension>{};
  final _panels = <Panel>[];
  StreamSubscription _allEventsSubscription;

  Api._internal();
  static final Api instance = Api._internal();

  Future<void> initialize() async {
    _allEventsSubscription = channel.on<Event>().listen(_onEveryEvent);

    for (var extension in _extensions.values) {
      await extension.onInit();
    }
  }

  void _onEveryEvent(Event event) {
    for (var extension in _extensions.values) {
      extension.onEvent(event);
      print('Executing ${event.runtimeType}');
    }
  }

  void dispose() {
    _allEventsSubscription.cancel();
  }

  void addPanel(Panel panel) {
    _panels.add(panel);
  }

  List<Panel> getPanels() {
    return _panels;
  }

  void registerExtension(Extension extension) {
    print(extension.runtimeType);
    if (_extensions.containsKey(extension.runtimeType)) {
      throw Exception(
          'Extension ${extension.runtimeType} is already registered.');
    }

    extension.channel = channel;

    _extensions[extension.runtimeType] = extension;
  }

  T getExtension<T extends Extension>() {
    return _extensions[_typeOf<T>()] as T;
  }

  Type _typeOf<T>() => T;
}
