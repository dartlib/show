import 'package:flutter/material.dart';

import '../layouts/index.dart';
import 'showcase.dart';
import 'showcase_item.dart';

typedef DecoratorFactory = Widget Function(Widget child);

class Show {
  LayoutFactory layout;
  ShowCase showCase = ShowCase();
  DecoratorFactory decorator;

  void setTitle(String title) {
    showCase.title = title;
  }

  void setDescription(String description) {
    showCase.description = description;
  }

  void setLayout(LayoutFactory layout) {
    showCase.layout = layout;
  }

  void decorate([DecoratorFactory factory]) {
    showCase.decorator = factory;
  }

  void setup({
    String title,
    LayoutFactory layout,
  }) {
    showCase.title = title;

    if (layout != null) {
      showCase.layout = layout;
    }
  }

  void add(
    String title,
    Set<Widget> Function(BuildContext context) showCaseFactory, {
    LayoutFactory layout,
    DecoratorFactory decorator,
    String description,
  }) {
    final id = _createPath(title);

    final idExists = showCase.items.any((item) => item.id == id);

    if (idExists) {
      throw Exception('Path $id must be unique, try changing the title');
    }

    showCase.items.add(
      ShowCaseItem(
        id: id,
        title: title,
        description: description,
        layout: layout ?? showCase.layout,
        decorator: decorator ?? showCase.decorator,
        showCaseFactory: showCaseFactory,
      ),
    );
  }

  String _createPath(String title) {
    return '${showCase.title}/$title';
  }
}
