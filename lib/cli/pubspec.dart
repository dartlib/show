import 'dart:io';

import 'package:path/path.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

parsePubSpec() {
  return Pubspec.parse(File(
    join(
      dirname(Platform.script.path),
      '../',
      'pubspec.yaml',
    ),
  ).readAsStringSync());
}

final pubspec = parsePubSpec();
