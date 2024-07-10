// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Consent _$ConsentFromJson(Map<String, dynamic> json) {
  return _Consent.fromJson(json);
}

/// @nodoc
mixin _$Consent {
  String? get user_id => throw _privateConstructorUsedError;
  String get chat_consent => throw _privateConstructorUsedError;
  String? get chat_consent_date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConsentCopyWith<Consent> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsentCopyWith<$Res> {
  factory $ConsentCopyWith(Consent value, $Res Function(Consent) then) =
      _$ConsentCopyWithImpl<$Res, Consent>;
  @useResult
  $Res call({String? user_id, String chat_consent, String? chat_consent_date});
}

/// @nodoc
class _$ConsentCopyWithImpl<$Res, $Val extends Consent>
    implements $ConsentCopyWith<$Res> {
  _$ConsentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_id = freezed,
    Object? chat_consent = null,
    Object? chat_consent_date = freezed,
  }) {
    return _then(_value.copyWith(
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      chat_consent: null == chat_consent
          ? _value.chat_consent
          : chat_consent // ignore: cast_nullable_to_non_nullable
              as String,
      chat_consent_date: freezed == chat_consent_date
          ? _value.chat_consent_date
          : chat_consent_date // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConsentImplCopyWith<$Res> implements $ConsentCopyWith<$Res> {
  factory _$$ConsentImplCopyWith(
          _$ConsentImpl value, $Res Function(_$ConsentImpl) then) =
      __$$ConsentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? user_id, String chat_consent, String? chat_consent_date});
}

/// @nodoc
class __$$ConsentImplCopyWithImpl<$Res>
    extends _$ConsentCopyWithImpl<$Res, _$ConsentImpl>
    implements _$$ConsentImplCopyWith<$Res> {
  __$$ConsentImplCopyWithImpl(
      _$ConsentImpl _value, $Res Function(_$ConsentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_id = freezed,
    Object? chat_consent = null,
    Object? chat_consent_date = freezed,
  }) {
    return _then(_$ConsentImpl(
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      chat_consent: null == chat_consent
          ? _value.chat_consent
          : chat_consent // ignore: cast_nullable_to_non_nullable
              as String,
      chat_consent_date: freezed == chat_consent_date
          ? _value.chat_consent_date
          : chat_consent_date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsentImpl implements _Consent {
  const _$ConsentImpl(
      {this.user_id, required this.chat_consent, this.chat_consent_date});

  factory _$ConsentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsentImplFromJson(json);

  @override
  final String? user_id;
  @override
  final String chat_consent;
  @override
  final String? chat_consent_date;

  @override
  String toString() {
    return 'Consent(user_id: $user_id, chat_consent: $chat_consent, chat_consent_date: $chat_consent_date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsentImpl &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.chat_consent, chat_consent) ||
                other.chat_consent == chat_consent) &&
            (identical(other.chat_consent_date, chat_consent_date) ||
                other.chat_consent_date == chat_consent_date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, user_id, chat_consent, chat_consent_date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsentImplCopyWith<_$ConsentImpl> get copyWith =>
      __$$ConsentImplCopyWithImpl<_$ConsentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsentImplToJson(
      this,
    );
  }
}

abstract class _Consent implements Consent {
  const factory _Consent(
      {final String? user_id,
      required final String chat_consent,
      final String? chat_consent_date}) = _$ConsentImpl;

  factory _Consent.fromJson(Map<String, dynamic> json) = _$ConsentImpl.fromJson;

  @override
  String? get user_id;
  @override
  String get chat_consent;
  @override
  String? get chat_consent_date;
  @override
  @JsonKey(ignore: true)
  _$$ConsentImplCopyWith<_$ConsentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
