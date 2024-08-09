import 'dart:ui';
import 'package:flutter/material.dart';

//Event 
class Event {
  String title;
  Color color;

  Event(this.title, this.color);

  @override
  String toString() {
    return 'Event(title: $title, color: $color)';
  }
}

