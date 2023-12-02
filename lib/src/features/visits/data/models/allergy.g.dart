// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllergyImpl _$$AllergyImplFromJson(Map<String, dynamic> json) =>
    _$AllergyImpl(
      uuid: json['uuid'] as String,
      allergen: json['allergen'] as String,
      reaction: json['reaction'] as String,
      onsetDate: json['onsetDate'] as String?,
      dateRecorded: json['dateRecorded'] as String,
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$$AllergyImplToJson(_$AllergyImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'allergen': instance.allergen,
      'reaction': instance.reaction,
      'onsetDate': instance.onsetDate,
      'dateRecorded': instance.dateRecorded,
      'severity': instance.severity,
    };
