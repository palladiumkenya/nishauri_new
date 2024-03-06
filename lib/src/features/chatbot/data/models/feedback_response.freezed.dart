// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FeedbackResponse _$FeedbackResponseFromJson(Map<String, dynamic> json) {
  return _FeedbackResponse.fromJson(json);
}

/// @nodoc
mixin _$FeedbackResponse {
  String get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedbackResponseCopyWith<FeedbackResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedbackResponseCopyWith<$Res> {
  factory $FeedbackResponseCopyWith(
          FeedbackResponse value, $Res Function(FeedbackResponse) then) =
      _$FeedbackResponseCopyWithImpl<$Res, FeedbackResponse>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class _$FeedbackResponseCopyWithImpl<$Res, $Val extends FeedbackResponse>
    implements $FeedbackResponseCopyWith<$Res> {
  _$FeedbackResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedbackResponseImplCopyWith<$Res>
    implements $FeedbackResponseCopyWith<$Res> {
  factory _$$FeedbackResponseImplCopyWith(_$FeedbackResponseImpl value,
          $Res Function(_$FeedbackResponseImpl) then) =
      __$$FeedbackResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$FeedbackResponseImplCopyWithImpl<$Res>
    extends _$FeedbackResponseCopyWithImpl<$Res, _$FeedbackResponseImpl>
    implements _$$FeedbackResponseImplCopyWith<$Res> {
  __$$FeedbackResponseImplCopyWithImpl(_$FeedbackResponseImpl _value,
      $Res Function(_$FeedbackResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_$FeedbackResponseImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedbackResponseImpl implements _FeedbackResponse {
  const _$FeedbackResponseImpl({required this.text});

  factory _$FeedbackResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedbackResponseImplFromJson(json);

  @override
  final String text;

  @override
  String toString() {
    return 'FeedbackResponse(text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedbackResponseImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedbackResponseImplCopyWith<_$FeedbackResponseImpl> get copyWith =>
      __$$FeedbackResponseImplCopyWithImpl<_$FeedbackResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedbackResponseImplToJson(
      this,
    );
  }
}

abstract class _FeedbackResponse implements FeedbackResponse {
  const factory _FeedbackResponse({required final String text}) =
      _$FeedbackResponseImpl;

  factory _FeedbackResponse.fromJson(Map<String, dynamic> json) =
      _$FeedbackResponseImpl.fromJson;

  @override
  String get text;
  @override
  @JsonKey(ignore: true)
  _$$FeedbackResponseImplCopyWith<_$FeedbackResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
