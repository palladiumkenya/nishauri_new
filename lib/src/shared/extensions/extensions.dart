// Import the dart:core library to use the String class
import 'dart:core';

extension ExtendedString on String {
  String get titleCase {
    final words = this.split(' ');
    // Capitalize the first letter of each word and join them back
    return words.map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ');
  }
  String get abbreviation {
    final words = this.split(' ');
    // Capitalize the first letter of each word and join them back
    return words.map((word) => word[0]).join(' ').toUpperCase();
  }
}
