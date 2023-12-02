// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitImpl _$$VisitImplFromJson(Map<String, dynamic> json) => _$VisitImpl(
      uuid: json['uuid'] as String,
      allergies: (json['allergies'] as List<dynamic>?)
              ?.map((e) => Allergy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      complaints: (json['complaints'] as List<dynamic>?)
              ?.map((e) => Complaint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      conditions: (json['conditions'] as List<dynamic>?)
              ?.map((e) => Condition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      diagnosis: (json['diagnosis'] as List<dynamic>?)
              ?.map((e) => Diagnosis.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      labResults: (json['labResults'] as List<dynamic>?)
              ?.map((e) => LabResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      vitals: (json['vitals'] as List<dynamic>?)
              ?.map((e) => Vital.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      visitDate: json['visitDate'] as String,
    );

Map<String, dynamic> _$$VisitImplToJson(_$VisitImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'allergies': instance.allergies,
      'complaints': instance.complaints,
      'conditions': instance.conditions,
      'diagnosis': instance.diagnosis,
      'labResults': instance.labResults,
      'vitals': instance.vitals,
      'visitDate': instance.visitDate,
    };
