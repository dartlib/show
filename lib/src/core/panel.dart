import 'package:flutter/material.dart';
import 'package:show/show.dart';

abstract class Panel extends StatelessWidget {
  String get name;
  Channel get channel;
}
