import 'package:flutter/material.dart';
import 'package:show/src/utils/uuid.dart';

final gridLayout = (
  List<Widget> children,
  BuildContext context,
) =>
    Card(
      child: GridView.count(
        shrinkWrap: true,
        childAspectRatio: 3,
        padding: const EdgeInsets.all(10),
        crossAxisCount: 3,
        children: children
            .map(
              (widget) => Card(
                elevation: 15,
                key: Key(uuid()),
                child: widget,
              ),
            )
            .toList(),
      ),
    );
