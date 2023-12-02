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
      venue: json['venue'] as String,
      reminderNotificationDates:
          (json['reminderNotificationDates'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const [],
      group: ARTGroup.fromJson(json['group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ARTEventImplToJson(_$ARTEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'distributionTime': instance.distributionTime,
      'venue': instance.venue,
      'reminderNotificationDates': instance.reminderNotificationDates,
      'group': instance.group,
    };
