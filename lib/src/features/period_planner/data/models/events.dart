import 'dart:ui';
import 'package:flutter/material.dart';

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

