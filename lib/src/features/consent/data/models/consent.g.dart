// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsentImpl _$$ConsentImplFromJson(Map<String, dynamic> json) =>
    _$ConsentImpl(
      user_id: json['user_id'] as String?,
      chatbot_consent: json['chatbot_consent'] as String,
      chatbot_consent_date: json['chatbot_consent_date'] as String?,
    );

Map<String, dynamic> _$$ConsentImplToJson(_$ConsentImpl instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'chatbot_consent': instance.chatbot_consent,
      'chatbot_consent_date': instance.chatbot_consent_date,
    };
