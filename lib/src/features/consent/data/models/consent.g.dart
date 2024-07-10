// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsentImpl _$$ConsentImplFromJson(Map<String, dynamic> json) =>
    _$ConsentImpl(
      user_id: json['user_id'] as String?,
      chat_consent: json['chat_consent'] as String,
      chat_consent_date: json['chat_consent_date'] as String?,
    );

Map<String, dynamic> _$$ConsentImplToJson(_$ConsentImpl instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'chat_consent': instance.chat_consent,
      'chat_consent_date': instance.chat_consent_date,
    };
