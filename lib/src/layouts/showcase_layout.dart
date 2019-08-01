import 'package:flutter/material.dart';

@immutable
abstract class ShowCaseLayout extends StatelessWidget {
  final List<Widget> children;
  const ShowCaseLayout({
    this.children = const [],
  });
}
