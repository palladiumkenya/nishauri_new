import 'dart:io';
import 'package:http/http.dart' as http;

class UserService {
  Future<void> uploadImage(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://your-server.com/upload'),
    );
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
    ));
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
    } else {
      print('Failed to upload image.');
    }
  }
}
