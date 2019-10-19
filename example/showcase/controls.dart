import 'package:flutter/material.dart';
import 'package:show/show.dart';

void showCase(Show controls) {
  controls
    ..setTitle('Controls')
    ..setLayout(Layout.gridLayout)
    ..add('Card', {
      () => const Card(
            color: Colors.orange,
          ),
      () => const Card(
            color: Colors.amber,
          ),
      () => InkWell(
            onTap: action('Hello ShowCase'),
            child: const Card(
              color: Colors.green,
            ),
          ),
      () => const Card(
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
