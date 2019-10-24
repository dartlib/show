import 'package:flutter/material.dart';
import 'package:show/show.dart';

void showCase(Show controls) {
  controls
    ..setTitle('Controls')
    ..setLayout(Layout.gridLayout())
    ..add(
      'Card',
      (_) => List.generate(
        62,
        (int index) => InkWell(
          onTap: action('Hello $index'),
          child: Container(
            width: 50,
            height: 80,
            child: Card(
              color: Colors.blue.withAlpha(index * 4),
              child: Center(
                child: Text(
                  index.toString(),
                ),
              ),
            ),
          ),
        ),
      ).toSet(),
    )
    ..setLayout(Layout.gridLayout())
    ..decorate((child) {
      return Container(
        width: 100,
        height: 100,
        child: Card(
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
          ),
        ),
      );
    })
    ..add(
      'CircularProgressIndicator',
      (_) => {
        const CircularProgressIndicator(),
        const CircularProgressIndicator(
          backgroundColor: Colors.pink,
          strokeWidth: 1,
        ),
        const CircularProgressIndicator(
          backgroundColor: Colors.pink,
          strokeWidth: 5,
        ),
        const CircularProgressIndicator(
          value: 0.4,
        ),
        const CircularProgressIndicator(
          backgroundColor: Colors.grey,
          value: 0.9,
        ),
      },
    );
}
