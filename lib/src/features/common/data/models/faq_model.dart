import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_model.freezed.dart';
part 'faq_model.g.dart';

@freezed
class FAQModel with _$FAQModel {

  const factory FAQModel({
    required String question,
    required String answer,
  }) = _FAQModel;

  factory FAQModel.fromJson(Map<String, Object?> json)
    => _$FAQModelFromJson(json);
}