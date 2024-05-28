// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi_nutrition_maping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BMIStatusNutritionImpl _$$BMIStatusNutritionImplFromJson(
        Map<String, dynamic> json) =>
    _$BMIStatusNutritionImpl(
      id: json['id'] as String?,
      status: json['status'] as String,
      description: json['description'] as String,
      createdAt: json['createdAt'] as String,
      isActive: json['isActive'] as bool,
      updatedAt: json['updatedAt'] as String,
      deletedAt: json['deletedAt'] as String?,
    );

Map<String, dynamic> _$$BMIStatusNutritionImplToJson(
        _$BMIStatusNutritionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'isActive': instance.isActive,
      'updatedAt': instance.updatedAt,
      'deletedAt': instance.deletedAt,
    };
