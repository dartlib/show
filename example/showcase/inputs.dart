import 'package:flutter/material.dart';
import 'package:show/show.dart';

void showCase(Show controls) {
  controls
    ..setTitle('Inputs')
    ..setLayout(Layout.columnLayout())
    ..decorate(
      (child) => Container(
        width: 400,
        padding: const EdgeInsets.all(18),
        child: child,
      ),
    )
    ..add(
      'Input',
      (_) => {
        TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            icon: Icon(Icons.person),
            hintText: 'What do people call you?',
            labelText: 'Name *',
          ),
          onSaved: action('onWhatDoPeopleCallYouSaved'),
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            icon: Icon(Icons.email),
            hintText: 'Your email address',
            labelText: 'E-mail',
          ),
          keyboardType: TextInputType.emailAddress,
          onSaved: action('onEmailSaved'),
        )
      },
    );
}
