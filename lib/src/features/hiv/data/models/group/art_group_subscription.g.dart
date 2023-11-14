// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_group_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ARTGroupSubscriptionImpl _$$ARTGroupSubscriptionImplFromJson(
        Map<String, dynamic> json) =>
    _$ARTGroupSubscriptionImpl(
      id: json['id'] as String?,
      group: json['group'] as String,
      patient: json['patient'] as String,
      name: json['name'] as String?,
      isCurrent: json['isCurrent'] as bool? ?? false,
    );

Map<String, dynamic> _$$ARTGroupSubscriptionImplToJson(
        _$ARTGroupSubscriptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group': instance.group,
      'patient': instance.patient,
      'name': instance.name,
      'isCurrent': instance.isCurrent,
    };
