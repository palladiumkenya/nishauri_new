// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_group_lead.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ARTGroupLead _$ARTGroupLeadFromJson(Map<String, dynamic> json) {
  return _ARTGroupLead.fromJson(json);
}

/// @nodoc
mixin _$ARTGroupLead {
  String? get id => throw _privateConstructorUsedError;
  String get group => throw _privateConstructorUsedError;
  String get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTGroupLeadCopyWith<ARTGroupLead> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTGroupLeadCopyWith<$Res> {
  factory $ARTGroupLeadCopyWith(
          ARTGroupLead value, $Res Function(ARTGroupLead) then) =
      _$ARTGroupLeadCopyWithImpl<$Res, ARTGroupLead>;
  @useResult
  $Res call({String? id, String group, String user});
}

/// @nodoc
class _$ARTGroupLeadCopyWithImpl<$Res, $Val extends ARTGroupLead>
    implements $ARTGroupLeadCopyWith<$Res> {
  _$ARTGroupLeadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? group = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ARTGroupLeadImplCopyWith<$Res>
    implements $ARTGroupLeadCopyWith<$Res> {
  factory _$$ARTGroupLeadImplCopyWith(
          _$ARTGroupLeadImpl value, $Res Function(_$ARTGroupLeadImpl) then) =
      __$$ARTGroupLeadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String group, String user});
}

/// @nodoc
class __$$ARTGroupLeadImplCopyWithImpl<$Res>
    extends _$ARTGroupLeadCopyWithImpl<$Res, _$ARTGroupLeadImpl>
    implements _$$ARTGroupLeadImplCopyWith<$Res> {
  __$$ARTGroupLeadImplCopyWithImpl(
      _$ARTGroupLeadImpl _value, $Res Function(_$ARTGroupLeadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? group = null,
    Object? user = null,
  }) {
    return _then(_$ARTGroupLeadImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTGroupLeadImpl with DiagnosticableTreeMixin implements _ARTGroupLead {
  const _$ARTGroupLeadImpl({this.id, required this.group, required this.user});

  factory _$ARTGroupLeadImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTGroupLeadImplFromJson(json);

  @override
  final String? id;
  @override
  final String group;
  @override
  final String user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTGroupLead(id: $id, group: $group, user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTGroupLead'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('group', group))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTGroupLeadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, group, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTGroupLeadImplCopyWith<_$ARTGroupLeadImpl> get copyWith =>
      __$$ARTGroupLeadImplCopyWithImpl<_$ARTGroupLeadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTGroupLeadImplToJson(
      this,
    );
  }
}

abstract class _ARTGroupLead implements ARTGroupLead {
  const factory _ARTGroupLead(
      {final String? id,
      required final String group,
      required final String user}) = _$ARTGroupLeadImpl;

  factory _ARTGroupLead.fromJson(Map<String, dynamic> json) =
      _$ARTGroupLeadImpl.fromJson;

  @override
  String? get id;
  @override
  String get group;
  @override
  String get user;
  @override
  @JsonKey(ignore: true)
  _$$ARTGroupLeadImplCopyWith<_$ARTGroupLeadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
