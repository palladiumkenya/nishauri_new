import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:nishauri/src/utils/routes.dart';

class ShortcutRepository {
  Future<List<String>> getShortcuts()async{
    final s = await LocalStorage.get("shortcuts");
    return s.split(",");
  }

  Future<void> save(List<String> shortcuts) async {
    final s = shortcuts.join(",");
    await LocalStorage.save("shortcuts", s);
  }

}