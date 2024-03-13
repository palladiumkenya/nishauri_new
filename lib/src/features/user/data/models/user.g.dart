// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String?,
      image: json['image'] as String?,
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      name: json['name'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      county: json['county'] as String?,
      constituency: json['constituency'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      allergies: json['allergies'] as String?,
      disabilities: json['disabilities'] as String?,
      chronics: json['chronics'] as String?,
      weight: json['weight'] as String?,
      height: json['height'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      educationLevel: json['educationLevel'] as String?,
      primaryLanguage: json['primaryLanguage'] as String?,
      occupation: json['occupation'] as String?,
      profileUpdated: json['profileUpdated'] as bool? ?? false,
      accountVerified: json['accountVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'county': instance.county,
      'constituency': instance.constituency,
      'bloodGroup': instance.bloodGroup,
      'allergies': instance.allergies,
      'disabilities': instance.disabilities,
      'chronics': instance.chronics,
      'weight': instance.weight,
      'height': instance.height,
      'maritalStatus': instance.maritalStatus,
      'educationLevel': instance.educationLevel,
      'primaryLanguage': instance.primaryLanguage,
      'occupation': instance.occupation,
      'profileUpdated': instance.profileUpdated,
      'accountVerified': instance.accountVerified,
    };
