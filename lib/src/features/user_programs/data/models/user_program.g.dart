// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProgramImpl _$$UserProgramImplFromJson(Map<String, dynamic> json) =>
    _$UserProgramImpl(
      id: json['id'] as String?,
      program_name: json['program_name'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserProgramImplToJson(_$UserProgramImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'program_name': instance.program_name,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
