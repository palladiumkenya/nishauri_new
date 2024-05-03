import 'package:freezed_annotation/freezed_annotation.dart';
part 'feedback_response.freezed.dart';
part 'feedback_response.g.dart';

@Freezed()
class FeedbackResponse with _$FeedbackResponse {
  const factory FeedbackResponse({
    required String msg,
  }) = _FeedbackResponse;
  factory FeedbackResponse.fromJson(Map<String, dynamic> json)=> _$FeedbackResponseFromJson(json);
}
