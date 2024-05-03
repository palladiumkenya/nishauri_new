// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgramImpl _$$ProgramImplFromJson(Map<String, dynamic> json) =>
    _$ProgramImpl(
      id: json['id'] as String?,
      program_code: json['program_code'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      is_active: json['is_active'] as bool? ?? false,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$ProgramImplToJson(_$ProgramImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'program_code': instance.program_code,
      'name': instance.name,
      'description': instance.description,
      'is_active': instance.is_active,
      'createdAt': instance.createdAt,
    };
