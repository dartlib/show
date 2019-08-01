import '../command.dart';
import '../log.dart';
import '../pubspec.dart';

/// Handles the `version` command.
class VersionCommand extends PubCommand {
  String get name => 'version';
  String get description => 'Print ${pubspec.name} version.';
  String get invocation => '${pubspec.name} version';

  void run() {
    log.message('Pub ${pubspec.version}');
  }
}
