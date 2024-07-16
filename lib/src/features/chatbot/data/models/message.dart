
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nishauri/src/features/chatbot/data/models/personal_info.dart';
part 'message.freezed.dart';
part 'message.g.dart';

@Freezed()
class Message with _$Message {
  const factory Message({
    required String question,
    required bool isSentByUser,
    PersonalInfo? personal_info,
    String? consent,
  }) = _Message;
  factory Message.fromJson(Map<String, dynamic> json)=> _$MessageFromJson(json);
}
