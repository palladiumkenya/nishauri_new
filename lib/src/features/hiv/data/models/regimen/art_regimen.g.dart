// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_regimen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ARTRegimenImpl _$$ARTRegimenImplFromJson(Map<String, dynamic> json) =>
    _$ARTRegimenImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      isCurrent: json['isCurrent'] as bool? ?? false,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$ARTRegimenImplToJson(_$ARTRegimenImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isCurrent': instance.isCurrent,
      'createdAt': instance.createdAt,
    };
