import 'package:flutter/material.dart';
import 'package:show/show.dart';

void showCase(Show buttons) {
  buttons
    ..setTitle('Buttons')
    ..setLayout(Layout.columnLayout)
    ..add(
      'FlatButton',
      (_) => {
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              child: const Text('FLAT BUTTON', semanticsLabel: 'FLAT BUTTON 1'),
              onPressed: action('FLAT BUTTON 1'),
            ),
            const FlatButton(
              child: Text(
                'DISABLED',
                semanticsLabel: 'DISABLED BUTTON 3',
              ),
              onPressed: null,
            ),
          ],
        ),
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton.icon(
              icon: const Icon(Icons.add_circle_outline, size: 18.0),
              label: const Text('FLAT BUTTON', semanticsLabel: 'FLAT BUTTON 2'),
              onPressed: action('FLAT BUTTON 2'),
            ),
            FlatButton.icon(
              icon: const Icon(Icons.add_circle_outline, size: 18.0),
              label:
                  const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 4'),
              onPressed: null,
            ),
          ],
        ),
      },
      description: 'These are the Flat Buttons',
    )
    ..add(
      'OutlineButton',
      (_) => {
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            OutlineButton(
              child: const Text('OUTLINE BUTTON',
                  semanticsLabel: 'OUTLINE BUTTON 1'),
              onPressed: () {
                // Perform some action
              },
            ),
            const OutlineButton(
              child: Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 5'),
              onPressed: null,
            ),
          ],
        ),
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            OutlineButton.icon(
              icon: const Icon(Icons.add, size: 18.0),
              label: const Text('OUTLINE BUTTON',
                  semanticsLabel: 'OUTLINE BUTTON 2'),
              onPressed: () {
                // Perform some action
              },
            ),
            OutlineButton.icon(
              icon: const Icon(Icons.add, size: 18.0),
              label:
                  const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 6'),
              onPressed: null,
            ),
          ],
        ),
      },
    );
}
