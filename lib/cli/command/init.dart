import 'dart:io';

import 'package:analyzer/analyzer.dart' hide Directive, Block;
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart';
import 'package:show/cli/templates/showcase.dart';

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
    final currentDir = getCwd();
    final targetPath = join(currentDir, 'showcase');

    createShowCaseDir(targetPath);

    final showCases = await _findShowCases(targetPath);

    showCases.sort();

    createImportsFile(showCases);

    createShowcaseFileIfNotExists();
  }

  void createShowCaseDir(String targetPath) {
    final targetDir = Directory(targetPath);

    if (!targetDir.existsSync()) {
      log.message('Creating $targetDir');

      targetDir.createSync();
    }
  }

  ///
  /// import './myShowcase.dart' as _sc1;
  /// import './otherShowcase.dart' as _sc2;
  ///
  /// final showCases = [
  ///   _sc1.showCase,
  ///   _sc2.showCase,
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

    final file = File(path)..writeAsString(source);

    if (file.existsSync()) {
      log.message('Updated showcase.g.dart.');
    } else {
      log.message('Created showcase.g.dart.');
    }
  }

  void createShowcaseFileIfNotExists() {
    final path = join(getCwd(), 'showcase/', 'showcase.dart');

    final file = File(path);

    if (file.existsSync()) {
      log.message('showcase.dart already exists skipping.');
    } else {
      file.writeAsString(showCaseTemplate());
      log.message('Created showcase.dart.');
    }
  }

  Library buildLibrary(List<String> showCases, String pathOffset) {
    return Library((builder) {
      final directives = <Directive>[];
      final list = [];
      for (var i = 0; i < showCases.length; i++) {
        directives.add(
          Directive.import(
            relative(
              join(pathOffset, showCases[i]),
              from: join(getCwd(), 'showcase'),
            ),
            as: '_sc$i',
          ),
        );
        list.add('_sc$i.showCase');
      }

      final assignment = Block.of([
        const Code('final showCases = ShowCase.import({'),
        Code(list.join(', ')),
        const Code('});'),
      ]);

      builder.directives.add(Directive.import('package:show/show.dart'));
      builder.directives.addAll(directives);
      builder.body.add(assignment);
    });
  }

  Future<List<String>> _findShowCases(String targetPath) async {
    final dartFiles = Glob('$targetPath/**.dart').listSync();

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
    var found = false;

    CompilationUnit astNode;

    try {
      astNode = parseCompilationUnit(source, parseFunctionBodies: false);
    } catch (_) {}

    if (astNode != null) {
      for (var node in astNode.childEntities) {
        if (node.runtimeType.toString() == 'FunctionDeclarationImpl') {
          if (node.toString().contains('showCase(')) {
            found = true;
            break;
          }
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
