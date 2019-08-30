import 'package:flutter/material.dart';

final layoutGrid = (List<Widget> children) => Card(
      child: GridView.count(
        shrinkWrap: true,
        childAspectRatio: 3,
        padding: const EdgeInsets.all(10),
        crossAxisCount: 3,
        children: children,
      ),
    );
