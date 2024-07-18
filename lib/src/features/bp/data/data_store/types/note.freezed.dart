// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Note {
  /// Timestamp when the note was taken.
  DateTime get time => throw _privateConstructorUsedError;

  /// Content of the note.
  String? get note => throw _privateConstructorUsedError;

  /// ARGB color in number format.
  ///
  /// Can also be obtained through the `dart:ui` Colors `value` attribute.
  /// Sample value: `0xFF42A5F5`
  int? get color => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NoteCopyWith<Note> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteCopyWith<$Res> {
  factory $NoteCopyWith(Note value, $Res Function(Note) then) =
      _$NoteCopyWithImpl<$Res, Note>;
  @useResult
  $Res call({DateTime time, String? note, int? color});
}

/// @nodoc
class _$NoteCopyWithImpl<$Res, $Val extends Note>
    implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? note = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotesImplCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory _$$NotesImplCopyWith(
          _$NotesImpl value, $Res Function(_$NotesImpl) then) =
      __$$NotesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime time, String? note, int? color});
}

/// @nodoc
class __$$NotesImplCopyWithImpl<$Res>
    extends _$NoteCopyWithImpl<$Res, _$NotesImpl>
    implements _$$NotesImplCopyWith<$Res> {
  __$$NotesImplCopyWithImpl(
      _$NotesImpl _value, $Res Function(_$NotesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? note = freezed,
    Object? color = freezed,
  }) {
    return _then(_$NotesImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$NotesImpl implements _Notes {
  const _$NotesImpl({required this.time, this.note, this.color});

  /// Timestamp when the note was taken.
  @override
  final DateTime time;

  /// Content of the note.
  @override
  final String? note;

  /// ARGB color in number format.
  ///
  /// Can also be obtained through the `dart:ui` Colors `value` attribute.
  /// Sample value: `0xFF42A5F5`
  @override
  final int? color;

  @override
  String toString() {
    return 'Note(time: $time, note: $note, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotesImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, time, note, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotesImplCopyWith<_$NotesImpl> get copyWith =>
      __$$NotesImplCopyWithImpl<_$NotesImpl>(this, _$identity);
}

abstract class _Notes implements Note {
  const factory _Notes(
      {required final DateTime time,
      final String? note,
      final int? color}) = _$NotesImpl;

  @override

  /// Timestamp when the note was taken.
  DateTime get time;
  @override

  /// Content of the note.
  String? get note;
  @override

  /// ARGB color in number format.
  ///
  /// Can also be obtained through the `dart:ui` Colors `value` attribute.
  /// Sample value: `0xFF42A5F5`
  int? get color;
  @override
  @JsonKey(ignore: true)
  _$$NotesImplCopyWith<_$NotesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
