import 'package:flutter/material.dart';
import 'package:show/show.dart';

void showCase(Show chips) {
  chips
    ..setTitle('Chips')
    ..setLayout((children) => Row(children: children))
    ..add(
      'Chip',
      (_) => {
        // now it doesn't make sense to have this be a function..
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: const Text('AB'),
          ),
          label: const Text('Aaron Burr'),
        ),
      },
    )
    ..add(
      'InputChip',
      (_) => {
        InputChip(
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: const Text('AB'),
          ),
          label: const Text('Aaron Burr'),
          onPressed: () {
            print('I am the one thing in life.');
          },
        ),
      },
    )
    ..add(
      'ChoiceChip',
      (_) => {
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return ChoiceChip(
                label: Text('Item $index'),
                selected: false,
                onSelected: action('Selected'),
              );
            },
          ).toList(),
        ),
      },
    );
}
