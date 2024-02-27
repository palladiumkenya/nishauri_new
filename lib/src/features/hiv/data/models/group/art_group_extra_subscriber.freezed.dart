// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_group_extra_subscriber.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ARTGroupExtraSubscriber _$ARTGroupExtraSubscriberFromJson(
    Map<String, dynamic> json) {
  return _ARTGroupExtraSubscriber.fromJson(json);
}

/// @nodoc
mixin _$ARTGroupExtraSubscriber {
  String get name => throw _privateConstructorUsedError;
  String get cccNumber => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTGroupExtraSubscriberCopyWith<ARTGroupExtraSubscriber> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTGroupExtraSubscriberCopyWith<$Res> {
  factory $ARTGroupExtraSubscriberCopyWith(ARTGroupExtraSubscriber value,
          $Res Function(ARTGroupExtraSubscriber) then) =
      _$ARTGroupExtraSubscriberCopyWithImpl<$Res, ARTGroupExtraSubscriber>;
  @useResult
  $Res call({String name, String cccNumber, String phoneNumber});
}

/// @nodoc
class _$ARTGroupExtraSubscriberCopyWithImpl<$Res,
        $Val extends ARTGroupExtraSubscriber>
    implements $ARTGroupExtraSubscriberCopyWith<$Res> {
  _$ARTGroupExtraSubscriberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? cccNumber = null,
    Object? phoneNumber = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      cccNumber: null == cccNumber
          ? _value.cccNumber
          : cccNumber // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ARTGroupExtraSubscriberImplCopyWith<$Res>
    implements $ARTGroupExtraSubscriberCopyWith<$Res> {
  factory _$$ARTGroupExtraSubscriberImplCopyWith(
          _$ARTGroupExtraSubscriberImpl value,
          $Res Function(_$ARTGroupExtraSubscriberImpl) then) =
      __$$ARTGroupExtraSubscriberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String cccNumber, String phoneNumber});
}

/// @nodoc
class __$$ARTGroupExtraSubscriberImplCopyWithImpl<$Res>
    extends _$ARTGroupExtraSubscriberCopyWithImpl<$Res,
        _$ARTGroupExtraSubscriberImpl>
    implements _$$ARTGroupExtraSubscriberImplCopyWith<$Res> {
  __$$ARTGroupExtraSubscriberImplCopyWithImpl(
      _$ARTGroupExtraSubscriberImpl _value,
      $Res Function(_$ARTGroupExtraSubscriberImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? cccNumber = null,
    Object? phoneNumber = null,
  }) {
    return _then(_$ARTGroupExtraSubscriberImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      cccNumber: null == cccNumber
          ? _value.cccNumber
          : cccNumber // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTGroupExtraSubscriberImpl
    with DiagnosticableTreeMixin
    implements _ARTGroupExtraSubscriber {
  const _$ARTGroupExtraSubscriberImpl(
      {required this.name, required this.cccNumber, required this.phoneNumber});

  factory _$ARTGroupExtraSubscriberImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTGroupExtraSubscriberImplFromJson(json);

  @override
  final String name;
  @override
  final String cccNumber;
  @override
  final String phoneNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTGroupExtraSubscriber(name: $name, cccNumber: $cccNumber, phoneNumber: $phoneNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTGroupExtraSubscriber'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('cccNumber', cccNumber))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTGroupExtraSubscriberImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cccNumber, cccNumber) ||
                other.cccNumber == cccNumber) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, cccNumber, phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTGroupExtraSubscriberImplCopyWith<_$ARTGroupExtraSubscriberImpl>
      get copyWith => __$$ARTGroupExtraSubscriberImplCopyWithImpl<
          _$ARTGroupExtraSubscriberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTGroupExtraSubscriberImplToJson(
      this,
    );
  }
}

abstract class _ARTGroupExtraSubscriber implements ARTGroupExtraSubscriber {
  const factory _ARTGroupExtraSubscriber(
      {required final String name,
      required final String cccNumber,
      required final String phoneNumber}) = _$ARTGroupExtraSubscriberImpl;

  factory _ARTGroupExtraSubscriber.fromJson(Map<String, dynamic> json) =
      _$ARTGroupExtraSubscriberImpl.fromJson;

  @override
  String get name;
  @override
  String get cccNumber;
  @override
  String get phoneNumber;
  @override
  @JsonKey(ignore: true)
  _$$ARTGroupExtraSubscriberImplCopyWith<_$ARTGroupExtraSubscriberImpl>
      get copyWith => throw _privateConstructorUsedError;
}
