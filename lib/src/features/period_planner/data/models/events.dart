import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
//Event 
class Event {
  final String title;
  final Color color;

  Event(this.title, this.color);

  @override
  String toString() {
    return 'Event(title: $title, color: $color)';
  }
}

