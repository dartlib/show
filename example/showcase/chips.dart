import 'package:flutter/material.dart';
import 'package:show/show.dart';

void showCase(Show chips) {
  chips
    ..setTitle('Chips')
    ..setLayout((children, [BuildContext context]) => Row(children: children))
    ..add('Chip', {
      () => Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: const Text('AB'),
            ),
            label: const Text('Aaron Burr'),
          ),
    })
    ..add('InputChip', {
      () => InputChip(
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: const Text('AB'),
          ),
          label: const Text('Aaron Burr'),
          onPressed: () {
            print('I am the one thing in life.');
          })
    })
    ..add('ChoiceChip', {
      () => Wrap(
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
          )
    });
}
