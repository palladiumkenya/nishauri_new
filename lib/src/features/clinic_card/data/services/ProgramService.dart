import 'dart:convert';
import 'package:nishauri/src/features/clinic_card/data/models/program.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ProgramService extends HTTPService {
  Future<List<Program>> getPrograms() async {
    final data = await loadJsonData('assets/data/clinic_card.json');
    final List<dynamic> jsonList = jsonDecode(data)['programs'];
    final programs = jsonList.map((json) => Program.fromJson(json)).toList();
    return programs;
  }
}
