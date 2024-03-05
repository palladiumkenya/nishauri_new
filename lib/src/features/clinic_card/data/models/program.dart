import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
part 'program.freezed.dart';


@freezed
class Program with _$Program {
  const factory Program({
    required String id,
    required String name,
    required Map<String, String> items,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) {
    final uuid = const Uuid().v4();
    return Program(
      id:uuid,
      name: json['name'],
      items: Map<String, String>.from(json['items']),
    );
  }
}
