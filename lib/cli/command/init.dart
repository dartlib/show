import 'dart:io';

import 'package:analyzer/analyzer.dart' hide Directive;
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart';

import '../command.dart';
import '../log.dart';

/// Handles the `init` command.
///
/// This creates a `showcase/showcase.dart` file in the project root.
///
/// After initialization run `show update` to find all showcases
/// in your repository.
class InitCommand extends ShowCommand {
  @override
  String get name => 'init';

  @override
  String get description => 'Initialize show for your project.';

  @override
  String get invocation => 'Initializing show for current project ';

  @override
  void run() async {
    log.message('Initialize show');

    final showCases = await _findShowCases();

    createShowCaseDir();

    createImportsFile(showCases);
  }

  void createShowCaseDir() {
    final currentDir = getCwd();

    log.message('Current dir is $currentDir');

    final targetPath = join(currentDir, 'showcase');
    final targetDir = Directory(targetPath);

    if (!targetDir.existsSync()) {
      log.message('Creating $targetDir');

      targetDir.createSync();
    } else {
      log.message('$targetDir already exists');
    }
  }

  ///
  /// import './myShowcase.dart' as _sc1;
  /// import './otherShowcase.dart' as _sc2;
  ///
  /// final showCases = [
  ///   _sc1,
  ///   _sc2,
  /// ];
  ///
  /// .....
  ///
  /// final List<Show> shows = showCases.map((showCase) => showCase(Show()));
  ///
  /// ... processed by the app...
  ///
  ///
  void createImportsFile(List<String> showCases) {
    final path = join(getCwd(), 'showcase/', 'showcase.g.dart');
    final library = buildLibrary(showCases, '../');
    final source = DartFormatter().format('${library.accept(DartEmitter())}');

    File(path).writeAsString(source);
  }

  Library buildLibrary(List<String> showCases, String pathOffset) {
    return Library((builder) {
      final directives = <Directive>[];
      final list = [];
      for (var i = 0; i < showCases.length; i++) {
        directives.add(
          Directive.import(
            join(pathOffset, showCases[i]),
            as: '_sc$i',
          ),
        );
        list.add(refer('_sc$i'));
      }
      builder.directives.addAll(directives);
      builder.body.add(literalList(list).assignFinal('showCases').statement);
    });
  }

  Future<List<String>> _findShowCases() async {
    final dartFiles = Glob('**.dart').listSync();

    final showCases = <String>[];

    for (var entity in dartFiles) {
      final source = await File(entity.path).readAsString();

      if (_isShowCase(source)) {
        showCases.add(entity.path);
      }
    }

    return showCases;
  }

  bool _isShowCase(String source) {
    final astNode = parseCompilationUnit(source, parseFunctionBodies: false);

    var found = false;
    for (var node in astNode.childEntities) {
      if (node.runtimeType.toString() == 'FunctionDeclarationImpl') {
        if (node.toString().contains('showCase(')) {
          found = true;
          break;
        }
      }
    }

    return found;
  }

  /// Returns the path of the current directory.
  String getCwd() {
    var path = Directory.current.path;
    if (Platform.isWindows) {
      path = path.replaceAll('\\', '/');
    }

    return path;
  }
}
