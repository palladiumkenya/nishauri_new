// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_group_subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ARTGroupSubscription _$ARTGroupSubscriptionFromJson(Map<String, dynamic> json) {
  return _ARTGroupSubscription.fromJson(json);
}

/// @nodoc
mixin _$ARTGroupSubscription {
  String? get id => throw _privateConstructorUsedError;
  ARTGroup get group => throw _privateConstructorUsedError;
  ARTGroupMember get user => throw _privateConstructorUsedError;
  String? get publicName => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  bool? get isCurrent => throw _privateConstructorUsedError;
  bool? get isAdmin => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTGroupSubscriptionCopyWith<ARTGroupSubscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTGroupSubscriptionCopyWith<$Res> {
  factory $ARTGroupSubscriptionCopyWith(ARTGroupSubscription value,
          $Res Function(ARTGroupSubscription) then) =
      _$ARTGroupSubscriptionCopyWithImpl<$Res, ARTGroupSubscription>;
  @useResult
  $Res call(
      {String? id,
      ARTGroup group,
      ARTGroupMember user,
      String? publicName,
      String createdAt,
      bool? isCurrent,
      bool? isAdmin});

  $ARTGroupCopyWith<$Res> get group;
  $ARTGroupMemberCopyWith<$Res> get user;
}

/// @nodoc
class _$ARTGroupSubscriptionCopyWithImpl<$Res,
        $Val extends ARTGroupSubscription>
    implements $ARTGroupSubscriptionCopyWith<$Res> {
  _$ARTGroupSubscriptionCopyWithImpl(this._value, this._then);

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
    Object? publicName = freezed,
    Object? createdAt = null,
    Object? isCurrent = freezed,
    Object? isAdmin = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as ARTGroup,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ARTGroupMember,
      publicName: freezed == publicName
          ? _value.publicName
          : publicName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      isCurrent: freezed == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAdmin: freezed == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ARTGroupCopyWith<$Res> get group {
    return $ARTGroupCopyWith<$Res>(_value.group, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ARTGroupMemberCopyWith<$Res> get user {
    return $ARTGroupMemberCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ARTGroupSubscriptionImplCopyWith<$Res>
    implements $ARTGroupSubscriptionCopyWith<$Res> {
  factory _$$ARTGroupSubscriptionImplCopyWith(_$ARTGroupSubscriptionImpl value,
          $Res Function(_$ARTGroupSubscriptionImpl) then) =
      __$$ARTGroupSubscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      ARTGroup group,
      ARTGroupMember user,
      String? publicName,
      String createdAt,
      bool? isCurrent,
      bool? isAdmin});

  @override
  $ARTGroupCopyWith<$Res> get group;
  @override
  $ARTGroupMemberCopyWith<$Res> get user;
}

/// @nodoc
class __$$ARTGroupSubscriptionImplCopyWithImpl<$Res>
    extends _$ARTGroupSubscriptionCopyWithImpl<$Res, _$ARTGroupSubscriptionImpl>
    implements _$$ARTGroupSubscriptionImplCopyWith<$Res> {
  __$$ARTGroupSubscriptionImplCopyWithImpl(_$ARTGroupSubscriptionImpl _value,
      $Res Function(_$ARTGroupSubscriptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? group = null,
    Object? user = null,
    Object? publicName = freezed,
    Object? createdAt = null,
    Object? isCurrent = freezed,
    Object? isAdmin = freezed,
  }) {
    return _then(_$ARTGroupSubscriptionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as ARTGroup,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ARTGroupMember,
      publicName: freezed == publicName
          ? _value.publicName
          : publicName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      isCurrent: freezed == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAdmin: freezed == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTGroupSubscriptionImpl
    with DiagnosticableTreeMixin
    implements _ARTGroupSubscription {
  const _$ARTGroupSubscriptionImpl(
      {this.id,
      required this.group,
      required this.user,
      this.publicName,
      required this.createdAt,
      this.isCurrent = false,
      this.isAdmin = false});

  factory _$ARTGroupSubscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTGroupSubscriptionImplFromJson(json);

  @override
  final String? id;
  @override
  final ARTGroup group;
  @override
  final ARTGroupMember user;
  @override
  final String? publicName;
  @override
  final String createdAt;
  @override
  @JsonKey()
  final bool? isCurrent;
  @override
  @JsonKey()
  final bool? isAdmin;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTGroupSubscription(id: $id, group: $group, user: $user, publicName: $publicName, createdAt: $createdAt, isCurrent: $isCurrent, isAdmin: $isAdmin)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTGroupSubscription'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('group', group))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('publicName', publicName))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('isCurrent', isCurrent))
      ..add(DiagnosticsProperty('isAdmin', isAdmin));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTGroupSubscriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.publicName, publicName) ||
                other.publicName == publicName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, group, user, publicName, createdAt, isCurrent, isAdmin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTGroupSubscriptionImplCopyWith<_$ARTGroupSubscriptionImpl>
      get copyWith =>
          __$$ARTGroupSubscriptionImplCopyWithImpl<_$ARTGroupSubscriptionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTGroupSubscriptionImplToJson(
      this,
    );
  }
}

abstract class _ARTGroupSubscription implements ARTGroupSubscription {
  const factory _ARTGroupSubscription(
      {final String? id,
      required final ARTGroup group,
      required final ARTGroupMember user,
      final String? publicName,
      required final String createdAt,
      final bool? isCurrent,
      final bool? isAdmin}) = _$ARTGroupSubscriptionImpl;

  factory _ARTGroupSubscription.fromJson(Map<String, dynamic> json) =
      _$ARTGroupSubscriptionImpl.fromJson;

  @override
  String? get id;
  @override
  ARTGroup get group;
  @override
  ARTGroupMember get user;
  @override
  String? get publicName;
  @override
  String get createdAt;
  @override
  bool? get isCurrent;
  @override
  bool? get isAdmin;
  @override
  @JsonKey(ignore: true)
  _$$ARTGroupSubscriptionImplCopyWith<_$ARTGroupSubscriptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
