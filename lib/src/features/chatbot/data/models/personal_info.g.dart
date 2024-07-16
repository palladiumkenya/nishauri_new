// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalInfoImpl _$$PersonalInfoImplFromJson(Map<String, dynamic> json) =>
    _$PersonalInfoImpl(
      gender: json['gender'] as String?,
      age: (json['age'] as num?)?.toInt(),
      regimen: json['regimen'] as String?,
      appointment_datetime: json['appointment_datetime'] as String?,
      viral_load: json['viral_load'] as String?,
      viral_load_datetime: json['viral_load_datetime'] as String?,
    );

Map<String, dynamic> _$$PersonalInfoImplToJson(_$PersonalInfoImpl instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'age': instance.age,
      'regimen': instance.regimen,
      'appointment_datetime': instance.appointment_datetime,
      'viral_load': instance.viral_load,
      'viral_load_datetime': instance.viral_load_datetime,
    };
