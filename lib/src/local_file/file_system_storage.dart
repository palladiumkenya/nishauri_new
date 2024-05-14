import 'dart:developer';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';


/// // Save image
/// String savedPath = await saveImageLocally(image, 'images/profile_picture.jpg');
/// print('Saved image to: $savedPath');
///
/// // Load image
/// File? loadedImage = await loadImage('images/profile_picture.jpg');
/// print('Loaded image: ${loadedImage?.path}');
///
/// // Delete image
/// bool deleted = await deleteFile('images/profile_picture.jpg');
/// if (deleted) {
/// print('Image deleted successfully');
/// } else {
/// print('Failed to delete image');
/// }




Future<String> saveImageLocally(File imageFile, String fileName) async {
  /// Example
  /// ```
  /// String savedPath = await saveImageLocally(image, 'images/profile_picture.jpg');
  /// ```

  final directory = await getApplicationDocumentsDirectory();
  final targetPath = "${directory.path}/$fileName";

  // Ensure the directory exists
  final fileDirectory =
      Directory(targetPath.substring(0, targetPath.lastIndexOf('/')));
  if (!await fileDirectory.exists()) {
    await fileDirectory.create(recursive: true);
  }

  final compressedImage = await FlutterImageCompress.compressAndGetFile(
    imageFile.absolute.path,
    targetPath,
    quality: 88,
  );

  return compressedImage?.path ?? imageFile.path;
}

Future<File?> loadImage(String fileName) async {
  /// Example
  /// ```
  /// File? loadedImage = await loadImage('images/profile_picture.jpg');
  /// ```
  final directory = await getApplicationDocumentsDirectory();
  final filePath = "${directory.path}/$fileName";
  final file = File(filePath);

  if (await file.exists()) {
    return file;
  }
  return null;
}

Future<bool> deleteFile(String fileName) async {
  /// Example
  /// ```
  /// bool deleted = await deleteFile('images/profile_picture.jpg');
  /// if (deleted) {
  ///   print('Image deleted successfully');
  /// } else {
  ///   print('Failed to delete image');
  /// }
  /// ```
  try {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/$fileName";
    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
      return true; // File deleted successfully
    }
    return false; // File does not exist
  } catch (e) {
    log('Error deleting file: $e');
    return false; // Error occurred while deleting file
  }
}
