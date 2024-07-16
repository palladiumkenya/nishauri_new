// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      question: json['question'] as String,
      isSentByUser: json['isSentByUser'] as bool,
      personal_info: json['personal_info'] == null
          ? null
          : PersonalInfo.fromJson(
              json['personal_info'] as Map<String, dynamic>),
      consent: json['consent'] as String?,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'question': instance.question,
      'isSentByUser': instance.isSentByUser,
      'personal_info': instance.personal_info,
      'consent': instance.consent,
    };
