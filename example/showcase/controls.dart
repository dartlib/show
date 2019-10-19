import 'package:flutter/material.dart';
import 'package:show/show.dart';

void showCase(Show controls) {
  controls
    ..setTitle('Controls')
    ..setLayout(Layout.gridLayout)
    ..add(
      'Card',
      List.generate(
        62,
        (int index) => () => InkWell(
              onTap: action('Hello $index'),
              child: Card(
                color: Colors.blue.withAlpha(index * 4),
                child: Center(
                  child: Text(
                    index.toString(),
                  ),
                ),
              ),
            ),
      ).toSet(),
    )
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
