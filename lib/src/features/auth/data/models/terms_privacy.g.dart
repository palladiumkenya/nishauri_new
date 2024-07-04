// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_privacy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TermsPrivacyImpl _$$TermsPrivacyImplFromJson(Map<String, dynamic> json) =>
    _$TermsPrivacyImpl(
      title: json['title'] as String?,
      introduction: json['introduction'] as String?,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TermsPrivacyImplToJson(_$TermsPrivacyImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'introduction': instance.introduction,
      'sections': instance.sections,
    };
