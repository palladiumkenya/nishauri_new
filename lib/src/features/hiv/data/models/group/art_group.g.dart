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
      extraSubscribers: (json['extraSubscribers'] as List<dynamic>?)
              ?.map((e) =>
                  ARTGroupExtraSubscriber.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$ARTGroupImplToJson(_$ARTGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'extraSubscribers': instance.extraSubscribers,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
