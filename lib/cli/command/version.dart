import '../../version.dart';
import '../command.dart';
import '../log.dart';

/// Handles the `version` command.
class VersionCommand extends ShowCommand {
  @override
  String get name => 'version';

  @override
  String get description => 'Print `show` version.';

  @override
  String get invocation => '`show` version';

  void run() {
    log.message('Pub $version');
  }
}
