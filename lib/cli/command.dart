// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'log.dart';

/// The base class for commands for the pub executable.
///
/// A command may either be a "leaf" command or it may be a parent for a set
/// of subcommands. Only leaf commands are ever actually invoked. If a command
/// has subcommands, then one of those must always be chosen.
abstract class ShowCommand extends Command {
  /// Override this and return `false` to disallow trailing options from being
  /// parsed after a non-option argument is parsed.
  bool get allowTrailingOptions => true;

  // Lazily initialize the parser because the superclass constructor requires
  // it but we want to initialize it based on [allowTrailingOptions].
  @override
  ArgParser get argParser =>
      _argParser ??= ArgParser(allowTrailingOptions: allowTrailingOptions);

  ArgParser _argParser;

  @override
  void printUsage() {
    log.message(usage);
  }

  /// Parses a user-supplied integer [intString] named [name].
  ///
  /// If the parsing fails, prints a usage message and exits.
  int parseInt(String intString, String name) {
    try {
      return int.parse(intString);
    } on FormatException catch (_) {
      usageException('Could not parse $name "$intString".');
      return null;
    }
  }
}
