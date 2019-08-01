// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import '../version.dart';
import 'command/init.dart';
import 'command/version.dart';
import 'log.dart';

class ShowCaseCommandRunner extends CommandRunner {
  /// The top-level options parsed by the command runner.
  static ArgResults _options;

  @override
  String get usageFooter =>
      'See https://github.com/dartlib/show for detailed documentation.';

  ShowCaseCommandRunner() : super('show', 'Showcase tool for your widgets.') {
    argParser
      ..addFlag('version', negatable: false, help: 'Print src version.')
      ..addOption('verbosity', help: 'Control output verbosity.', allowed: [
        'error',
        'warning',
        'normal',
        'all'
      ], allowedHelp: {
        'error': 'Show only errors.',
        'warning': 'Show only errors and warnings.',
        'normal': 'Show errors, warnings, and user messages.',
        'all': 'Show all output including internal tracing messages.'
      })
      ..addFlag('verbose',
          abbr: 'v', negatable: false, help: 'Shortcut for "--verbosity=all".');

    addCommand(InitCommand());
    addCommand(VersionCommand());
  }

  @override
  Future run(Iterable<String> args) async {
    _options = super.parse(args);

    await runCommand(_options);
  }

  @override
  Future runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] as bool) {
      log.message('Showcase $version');
      return;
    }

    switch (topLevelResults['verbosity'] as String) {
      case 'error':
        log.level = LogLevel.error;
        break;
      case 'warning':
        log.level = LogLevel.warning;
        break;
      case 'normal':
        log.level = LogLevel.normal;
        break;
      case 'all':
        log.level = LogLevel.all;
        break;
      default:
        // No specific verbosity given, so check for the shortcut.
        if (topLevelResults['verbose'] as bool) log.level = LogLevel.all;
        break;
    }

    log.fine('Pub $version');

    await super.runCommand(topLevelResults);
  }

  @override
  void printUsage() {
    log.message(usage);
  }

  /// Returns the nested name of the command that's currently being run.
  /// Examples:
  ///
  ///     get
  ///     cache repair
  ///
  /// Returns an empty string if no command is being run. (This is only
  /// expected to happen when unit tests invoke code inside pub without going
  /// through a command.)
  static String get command {
    if (_options == null) return '';

    final list = <String>[];
    for (var command = _options.command;
        command != null;
        command = command.command) {
      list.add(command.name);
    }
    return list.join(' ');
  }
}
