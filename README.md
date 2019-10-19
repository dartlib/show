# Show(Case)

ShowCase your flutter app.

![Screenshot](https://raw.githubusercontent.com/dartlib/show/develop/assets/screenshot.png)

## Getting Started

To install `show` globally use:
`flutter pub global activate show`

You will also have to add `show` to your dependencies:
```yaml
devDependencies:
  show: <version>
```

## Setup project 

The `init` command will create a `showcase/` directory in your project root.

An entry `showcase/showcase.dart` will be created once.
This file can be modified and will not be recreated as long as it exists.

```bash
show init
```

## Creating show cases 

The showcases need to be created within the newly created `showcase/` folder.

Whenever you've created new files containing showcases you will need to run `show init` again which will recreate `showcase/showcase.g.dart`. This is in order to update the files to be imported by the application.

If you modify existing showcases they will be hot reloaded just like any other widget.


**Example show case:**

`showcase/controls.dart`
```dart
import 'package:flutter/material.dart';
import 'package:show/show.dart';

void showCase(Show controls) {
  controls
    ..setTitle('Controls')
    ..setLayout(Layout.gridLayout)
    ..add('Card', {
      () => Card(
            color: Colors.orange,
          ),
      () => InkWell(
            onTap: action('Hello ShowCase'),
            child: Card(
              color: Colors.green,
            ),
          ),
      () => Card(
            color: Colors.yellow,
          ),
    })
    ..add('CircularProgressIndicator', {
      () => const CircularProgressIndicator(),
      () => const CircularProgressIndicator(
            backgroundColor: Colors.pink,
            strokeWidth: 10,
          ),
      () => const CircularProgressIndicator(
            value: 0.4,
          ),
    });
}
```

### Development

To activate the show package globally from within the develop directory use:
```dart
flutter pub global activate --source path <repository_path>
```
