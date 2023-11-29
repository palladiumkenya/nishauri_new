// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String?,
      image: json['image'] as String?,
      username: json['username'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      country: json['country'] as String?,
      constituency: json['constituency'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      allergies: (json['allergies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      disabilities: (json['disabilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      chronics: (json['chronics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      weight: json['weight'] as String?,
      height: json['height'] as String?,
      maritalState: json['maritalState'] as String?,
      educationLevel: json['educationLevel'] as String?,
      primaryLanguage: json['primaryLanguage'] as String?,
      occupation: json['occupation'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'country': instance.country,
      'constituency': instance.constituency,
      'bloodGroup': instance.bloodGroup,
      'allergies': instance.allergies,
      'disabilities': instance.disabilities,
      'chronics': instance.chronics,
      'weight': instance.weight,
      'height': instance.height,
      'maritalState': instance.maritalState,
      'educationLevel': instance.educationLevel,
      'primaryLanguage': instance.primaryLanguage,
      'occupation': instance.occupation,
    };
