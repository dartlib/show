String showCaseTemplate() {
  return '''
import 'package:show/show.dart';

import 'showcase.g.dart';

void main() => runShow(
      showCases: showCases(),
    );
''';
}
