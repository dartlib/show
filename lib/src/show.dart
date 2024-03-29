import 'package:flutter/material.dart';
import 'package:show/src/showcase_item.dart';

import 'layouts/index.dart';
import 'showcase.dart';

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
    showCase.items.add(
      ShowCaseItem(
        title: title,
        description: description,
        layout: layout ?? showCase.layout,
        decorator: decorator ?? showCase.decorator,
        showCaseFactory: showCaseFactory,
      ),
    );
  }
}
