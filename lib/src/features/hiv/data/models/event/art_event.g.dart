// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ARTEventImpl _$$ARTEventImplFromJson(Map<String, dynamic> json) =>
    _$ARTEventImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      distributionTime: json['distributionTime'] as String,
      distributionLocation: Address.fromJson(
          json['distributionLocation'] as Map<String, dynamic>),
      reminderNotificationDates:
          (json['reminderNotificationDates'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const [],
      group: json['group'] as String,
    );

Map<String, dynamic> _$$ARTEventImplToJson(_$ARTEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'distributionTime': instance.distributionTime,
      'distributionLocation': instance.distributionLocation,
      'reminderNotificationDates': instance.reminderNotificationDates,
      'group': instance.group,
    };
