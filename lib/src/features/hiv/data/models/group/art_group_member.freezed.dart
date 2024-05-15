// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_group_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ARTGroupMember _$ARTGroupMemberFromJson(Map<String, dynamic> json) {
  return _ARTGroupMember.fromJson(json);
}

/// @nodoc
mixin _$ARTGroupMember {
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTGroupMemberCopyWith<ARTGroupMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTGroupMemberCopyWith<$Res> {
  factory $ARTGroupMemberCopyWith(
          ARTGroupMember value, $Res Function(ARTGroupMember) then) =
      _$ARTGroupMemberCopyWithImpl<$Res, ARTGroupMember>;
  @useResult
  $Res call({String? id});
}

/// @nodoc
class _$ARTGroupMemberCopyWithImpl<$Res, $Val extends ARTGroupMember>
    implements $ARTGroupMemberCopyWith<$Res> {
  _$ARTGroupMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ARTGroupMemberImplCopyWith<$Res>
    implements $ARTGroupMemberCopyWith<$Res> {
  factory _$$ARTGroupMemberImplCopyWith(_$ARTGroupMemberImpl value,
          $Res Function(_$ARTGroupMemberImpl) then) =
      __$$ARTGroupMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id});
}

/// @nodoc
class __$$ARTGroupMemberImplCopyWithImpl<$Res>
    extends _$ARTGroupMemberCopyWithImpl<$Res, _$ARTGroupMemberImpl>
    implements _$$ARTGroupMemberImplCopyWith<$Res> {
  __$$ARTGroupMemberImplCopyWithImpl(
      _$ARTGroupMemberImpl _value, $Res Function(_$ARTGroupMemberImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_$ARTGroupMemberImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTGroupMemberImpl
    with DiagnosticableTreeMixin
    implements _ARTGroupMember {
  const _$ARTGroupMemberImpl({this.id});

  factory _$ARTGroupMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTGroupMemberImplFromJson(json);

  @override
  final String? id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTGroupMember(id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTGroupMember'))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTGroupMemberImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTGroupMemberImplCopyWith<_$ARTGroupMemberImpl> get copyWith =>
      __$$ARTGroupMemberImplCopyWithImpl<_$ARTGroupMemberImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTGroupMemberImplToJson(
      this,
    );
  }
}

abstract class _ARTGroupMember implements ARTGroupMember {
  const factory _ARTGroupMember({final String? id}) = _$ARTGroupMemberImpl;

  factory _ARTGroupMember.fromJson(Map<String, dynamic> json) =
      _$ARTGroupMemberImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$ARTGroupMemberImplCopyWith<_$ARTGroupMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
