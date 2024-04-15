// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PasswordResetImpl _$$PasswordResetImplFromJson(Map<String, dynamic> json) =>
    _$PasswordResetImpl(
      id: json['id'] as String?,
      current_password: json['current_password'] as String?,
      new_password: json['new_password'] as String?,
      confirm_password: json['confirm_password'] as String?,
      user_name: json['user_name'] as String?,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$$PasswordResetImplToJson(_$PasswordResetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'current_password': instance.current_password,
      'new_password': instance.new_password,
      'confirm_password': instance.confirm_password,
      'user_name': instance.user_name,
      'otp': instance.otp,
    };
