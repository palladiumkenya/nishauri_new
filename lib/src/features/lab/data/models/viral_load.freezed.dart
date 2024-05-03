// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'viral_load.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ViralLoad {
  String get id => throw _privateConstructorUsedError; // Add an id field
  String get result => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get plot => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ViralLoadCopyWith<ViralLoad> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViralLoadCopyWith<$Res> {
  factory $ViralLoadCopyWith(ViralLoad value, $Res Function(ViralLoad) then) =
      _$ViralLoadCopyWithImpl<$Res, ViralLoad>;
  @useResult
  $Res call({String id, String result, String status, String date, int plot});
}

/// @nodoc
class _$ViralLoadCopyWithImpl<$Res, $Val extends ViralLoad>
    implements $ViralLoadCopyWith<$Res> {
  _$ViralLoadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? result = null,
    Object? status = null,
    Object? date = null,
    Object? plot = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      plot: null == plot
          ? _value.plot
          : plot // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ViralLoadImplCopyWith<$Res>
    implements $ViralLoadCopyWith<$Res> {
  factory _$$ViralLoadImplCopyWith(
          _$ViralLoadImpl value, $Res Function(_$ViralLoadImpl) then) =
      __$$ViralLoadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String result, String status, String date, int plot});
}

/// @nodoc
class __$$ViralLoadImplCopyWithImpl<$Res>
    extends _$ViralLoadCopyWithImpl<$Res, _$ViralLoadImpl>
    implements _$$ViralLoadImplCopyWith<$Res> {
  __$$ViralLoadImplCopyWithImpl(
      _$ViralLoadImpl _value, $Res Function(_$ViralLoadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? result = null,
    Object? status = null,
    Object? date = null,
    Object? plot = null,
  }) {
    return _then(_$ViralLoadImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      plot: null == plot
          ? _value.plot
          : plot // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ViralLoadImpl implements _ViralLoad {
  const _$ViralLoadImpl(
      {required this.id,
      required this.result,
      required this.status,
      required this.date,
      required this.plot});

  @override
  final String id;
// Add an id field
  @override
  final String result;
  @override
  final String status;
  @override
  final String date;
  @override
  final int plot;

  @override
  String toString() {
    return 'ViralLoad(id: $id, result: $result, status: $status, date: $date, plot: $plot)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViralLoadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.plot, plot) || other.plot == plot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, result, status, date, plot);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ViralLoadImplCopyWith<_$ViralLoadImpl> get copyWith =>
      __$$ViralLoadImplCopyWithImpl<_$ViralLoadImpl>(this, _$identity);
}

abstract class _ViralLoad implements ViralLoad {
  const factory _ViralLoad(
      {required final String id,
      required final String result,
      required final String status,
      required final String date,
      required final int plot}) = _$ViralLoadImpl;

  @override
  String get id;
  @override // Add an id field
  String get result;
  @override
  String get status;
  @override
  String get date;
  @override
  int get plot;
  @override
  @JsonKey(ignore: true)
  _$$ViralLoadImplCopyWith<_$ViralLoadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
