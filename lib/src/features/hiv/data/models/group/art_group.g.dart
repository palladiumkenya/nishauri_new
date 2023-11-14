// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ARTGroupImpl _$$ARTGroupImplFromJson(Map<String, dynamic> json) =>
    _$ARTGroupImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      lead: json['lead'] as String,
    );

Map<String, dynamic> _$$ARTGroupImplToJson(_$ARTGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'lead': instance.lead,
    };
