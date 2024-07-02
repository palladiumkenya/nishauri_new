// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_conditions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TermsConditionsImpl _$$TermsConditionsImplFromJson(
        Map<String, dynamic> json) =>
    _$TermsConditionsImpl(
      title: json['title'] as String?,
      introduction: json['introduction'] as String?,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TermsConditionsImplToJson(
        _$TermsConditionsImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'introduction': instance.introduction,
      'sections': instance.sections,
    };
