# Show(Case)

ShowCase your flutter app.

## Getting Started

'pub global activate show'

## Setup project 

The setup will create a `showcase/` directory in your project root.

An entry `showcase/showcase.dart` will be created once.
This file can be modified and will not be recreated as long as it exists.

Whenever you've created new files containing showcases you will need to  
run `show init` again which will recreate `showcase/showcase.g.dart`.

```bash
show init
```

## Example Showcase

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
