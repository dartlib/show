import 'package:flutter/material.dart';
import 'package:show/show.dart';

void showCase(Show buttons) {
  buttons
    ..setTitle('Buttons')
    ..setLayout(Layout.columnLayout)
    ..add(
      'FlatButton',
      (_) => {
        const Align(
          alignment: Alignment.centerLeft,
          child: RotatedBox(
            quarterTurns: 1,
            child: Text(
              '76',
              style: TextStyle(
                fontSize: 200,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        FlatButton(
          child: const Text('FlatButton'),
          onPressed: action('Pressed'),
        ),
        FlatButton(
          color: Colors.blue,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: const EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          onPressed: () {
            /*...*/
          },
          child: const Text(
            'Flat Button',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      },
    )
    ..add(
      'RaisedButton',
      (_) => {
        const RaisedButton(
          onPressed: null,
          child: Text('Disabled Button', style: TextStyle(fontSize: 20)),
        ),
        RaisedButton(
          onPressed: action('Pressed'),
          child: const Text(
            'Enabled Button',
            style: TextStyle(fontSize: 20),
          ),
        ),
        RaisedButton(
          onPressed: action('Pressed'),
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child:
                const Text('Gradient Button', style: TextStyle(fontSize: 20)),
          ),
        ),
      },
    );
}
