import 'package:flutter/material.dart';

final layoutColumn = (List<Widget> children) => Scrollbar(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(children),
          ),
        ],
      ),
    );
