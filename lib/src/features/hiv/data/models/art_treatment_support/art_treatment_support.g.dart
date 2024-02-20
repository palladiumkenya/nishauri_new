// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_treatment_support.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ARTTreatmentSupportImpl _$$ARTTreatmentSupportImplFromJson(
        Map<String, dynamic> json) =>
    _$ARTTreatmentSupportImpl(
      id: json['id'] as String?,
      careReceiver:
          CareReceiver.fromJson(json['careReceiver'] as Map<String, dynamic>),
      careGiver: CareGiver.fromJson(json['careGiver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ARTTreatmentSupportImplToJson(
        _$ARTTreatmentSupportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careReceiver': instance.careReceiver,
      'careGiver': instance.careGiver,
    };
