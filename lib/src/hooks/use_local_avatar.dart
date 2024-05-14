import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../local_file/file_system_storage.dart';

// This custom hook fetches data asynchronously and stores it in a state
String? useLocalAvatar(String path) {
  // Declare a state variable to hold the fetched data
  final _dataState = useState<String?>(null);

  // Use useEffect to fetch data when the url changes
  useEffect(() {

    loadImage(path).then((value) {
      log("|Loaded********************$value*********************|");
      _dataState.value = value?.path;
    });

    // This dependency list ensures the effect runs only once
    // when the url argument changes
  }, [path]);

  // Return the current state of the data
  return _dataState.value;
}

