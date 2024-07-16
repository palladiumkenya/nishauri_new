// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String get question => throw _privateConstructorUsedError;
  bool get isSentByUser => throw _privateConstructorUsedError;
  PersonalInfo? get personal_info => throw _privateConstructorUsedError;
  String? get consent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {String question,
      bool isSentByUser,
      PersonalInfo? personal_info,
      String? consent});

  $PersonalInfoCopyWith<$Res>? get personal_info;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? isSentByUser = null,
    Object? personal_info = freezed,
    Object? consent = freezed,
  }) {
    return _then(_value.copyWith(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      isSentByUser: null == isSentByUser
          ? _value.isSentByUser
          : isSentByUser // ignore: cast_nullable_to_non_nullable
              as bool,
      personal_info: freezed == personal_info
          ? _value.personal_info
          : personal_info // ignore: cast_nullable_to_non_nullable
              as PersonalInfo?,
      consent: freezed == consent
          ? _value.consent
          : consent // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PersonalInfoCopyWith<$Res>? get personal_info {
    if (_value.personal_info == null) {
      return null;
    }

    return $PersonalInfoCopyWith<$Res>(_value.personal_info!, (value) {
      return _then(_value.copyWith(personal_info: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String question,
      bool isSentByUser,
      PersonalInfo? personal_info,
      String? consent});

  @override
  $PersonalInfoCopyWith<$Res>? get personal_info;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? isSentByUser = null,
    Object? personal_info = freezed,
    Object? consent = freezed,
  }) {
    return _then(_$MessageImpl(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      isSentByUser: null == isSentByUser
          ? _value.isSentByUser
          : isSentByUser // ignore: cast_nullable_to_non_nullable
              as bool,
      personal_info: freezed == personal_info
          ? _value.personal_info
          : personal_info // ignore: cast_nullable_to_non_nullable
              as PersonalInfo?,
      consent: freezed == consent
          ? _value.consent
          : consent // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {required this.question,
      required this.isSentByUser,
      this.personal_info,
      this.consent});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final String question;
  @override
  final bool isSentByUser;
  @override
  final PersonalInfo? personal_info;
  @override
  final String? consent;

  @override
  String toString() {
    return 'Message(question: $question, isSentByUser: $isSentByUser, personal_info: $personal_info, consent: $consent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.isSentByUser, isSentByUser) ||
                other.isSentByUser == isSentByUser) &&
            (identical(other.personal_info, personal_info) ||
                other.personal_info == personal_info) &&
            (identical(other.consent, consent) || other.consent == consent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, question, isSentByUser, personal_info, consent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {required final String question,
      required final bool isSentByUser,
      final PersonalInfo? personal_info,
      final String? consent}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  String get question;
  @override
  bool get isSentByUser;
  @override
  PersonalInfo? get personal_info;
  @override
  String? get consent;
  @override
  @JsonKey(ignore: true)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
