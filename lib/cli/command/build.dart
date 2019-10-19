import 'dart:async';

import 'package:flutter_tools/src/asset.dart';
import 'package:flutter_tools/src/base/common.dart';
import 'package:flutter_tools/src/base/file_system.dart';
import 'package:flutter_tools/src/build_info.dart';
import 'package:flutter_tools/src/build_system/build_system.dart';
import 'package:flutter_tools/src/build_system/targets/assets.dart';
import 'package:flutter_tools/src/build_system/targets/dart.dart';
import 'package:flutter_tools/src/build_system/targets/web.dart';
import 'package:flutter_tools/src/cache.dart';
import 'package:flutter_tools/src/context_runner.dart';
import 'package:flutter_tools/src/globals.dart';
import 'package:flutter_tools/src/platform_plugins.dart';
import 'package:flutter_tools/src/plugins.dart';
import 'package:flutter_tools/src/project.dart';
import 'package:path/path.dart' as path;
import 'package:process_run/which.dart';

import '../command.dart';

class BuildCommand extends ShowCommand {
  @override
  final name = 'build';

  @override
  final description = 'Build a web version of this showcase.';

  @override
  String get invocation => 'Building show cases for current project ';

  @override
  Future run() async {
    await runInContext(() async {
      Cache.flutterRoot = getFlutterRoot();

      final flutterProject = FlutterProject.current();
      final target = 'showcase/showcase.dart';
      final buildInfo = getBuildInfo();
      final initializeWebPlatform = true;
      await buildWeb(
        flutterProject,
        target,
        buildInfo,
        initializeWebPlatform,
      );
    });
  }

  Future<void> buildWeb(
    FlutterProject flutterProject,
    String target,
    BuildInfo buildInfo,
    bool initializePlatform,
  ) async {
    final hasWebPlugins = findPlugins(flutterProject).any(
      (Plugin p) => p.platforms.containsKey(WebPlugin.kConfigKey),
    );

    await injectPlugins(
      flutterProject,
      checkProjects: true,
    );

    print('Compiling $target for the Web...');

    final result = await buildSystem.build(
      const ShowCaseWebReleaseBundle(),
      Environment(
        outputDir: fs.directory(getWebBuildDirectory()),
        projectDir: fs.currentDirectory,
        buildDir: flutterProject.directory
            .childDirectory('.dart_tool')
            .childDirectory('flutter_build'),
        defines: <String, String>{
          kBuildMode: getNameForBuildMode(buildInfo.mode),
          kTargetFile: target,
          kInitializePlatform: initializePlatform.toString(),
          kHasWebPlugins: hasWebPlugins.toString(),
        },
      ),
    );

    if (!result.success) {
      for (var measurement in result.exceptions.values) {
        printError(measurement.stackTrace.toString());
        printError(measurement.exception.toString());
      }
      throwToolExit('Failed to compile showcase for the Web.');
    }

    print('Build written to build/showcase/web');
  }

  BuildInfo getBuildInfo() {
    return BuildInfo(
      BuildMode.release,
      null,
      trackWidgetCreation: false,
      buildNumber: argParser.options.containsKey('build-number') &&
              argResults['build-number'] != null
          ? argResults['build-number'] as String
          : null,
      buildName: argParser.options.containsKey('build-name')
          ? argResults['build-name'] as String
          : null,
    );
  }

  String getFlutterRoot() {
    final parts = path.split(whichSync('flutter'));
    parts.removeRange(parts.length - 3, parts.length - 1);
    return path.joinAll(parts);
  }

  String getWebBuildDirectory() {
    return fs.path.join(getBuildDirectory(), 'showcase', 'web');
  }
}

// Based on WebReleaseBundle
class ShowCaseWebReleaseBundle extends Target {
  const ShowCaseWebReleaseBundle();

  @override
  String get name => 'show_case_web_release_bundle';

  @override
  List<Target> get dependencies => const <Target>[
        Dart2JSTarget(),
      ];

  @override
  List<Source> get inputs => const <Source>[
        Source.pattern('{BUILD_DIR}/main.dart.js'),
        Source.pattern(
            '{FLUTTER_ROOT}/packages/flutter_tools/lib/src/build_system/targets/web.dart'),
        Source.behavior(AssetOutputBehavior('assets')),
      ];

  @override
  List<Source> get outputs => const <Source>[
        Source.pattern('{OUTPUT_DIR}/main.dart.js'),
        Source.pattern('{OUTPUT_DIR}/assets/AssetManifest.json'),
        Source.pattern('{OUTPUT_DIR}/assets/FontManifest.json'),
        Source.pattern('{OUTPUT_DIR}/assets/LICENSE'),
        Source.pattern('{OUTPUT_DIR}/index.html'),
        Source.behavior(AssetOutputBehavior('assets'))
      ];

  @override
  Future<void> build(Environment environment) async {
    final outputFiles = environment.buildDir
        .listSync(
          recursive: true,
        )
        .whereType<File>();

    for (var outputFile in outputFiles) {
      if (!fs.path.basename(outputFile.path).contains('main.dart.js')) {
        continue;
      }

      outputFile.copySync(environment.outputDir
          .childFile(fs.path.basename(outputFile.path))
          .path);
    }

    final indexHtml = fs.file(
      fs.path.join(environment.outputDir.path, 'index.html'),
    );

    final contents = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ShowCase</title>
</head>
<body>
  <script src="main.dart.js" type="application/javascript"></script>
</body>
</html>
''';

    await indexHtml.writeAsString(contents);

    final assetBundle = AssetBundleFactory.instance.createBundle();

    await assetBundle.build();
    await copyAssets(assetBundle, environment, 'assets');
  }
}
