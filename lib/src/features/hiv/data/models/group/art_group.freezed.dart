// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ARTGroup _$ARTGroupFromJson(Map<String, dynamic> json) {
  return _ARTGroup.fromJson(json);
}

/// @nodoc
mixin _$ARTGroup {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<ARTGroupExtraSubscriber> get extraSubscribers =>
      throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTGroupCopyWith<ARTGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTGroupCopyWith<$Res> {
  factory $ARTGroupCopyWith(ARTGroup value, $Res Function(ARTGroup) then) =
      _$ARTGroupCopyWithImpl<$Res, ARTGroup>;
  @useResult
  $Res call(
      {String? id,
      String title,
      String? description,
      List<ARTGroupExtraSubscriber> extraSubscribers,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class _$ARTGroupCopyWithImpl<$Res, $Val extends ARTGroup>
    implements $ARTGroupCopyWith<$Res> {
  _$ARTGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? extraSubscribers = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      extraSubscribers: null == extraSubscribers
          ? _value.extraSubscribers
          : extraSubscribers // ignore: cast_nullable_to_non_nullable
              as List<ARTGroupExtraSubscriber>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ARTGroupImplCopyWith<$Res>
    implements $ARTGroupCopyWith<$Res> {
  factory _$$ARTGroupImplCopyWith(
          _$ARTGroupImpl value, $Res Function(_$ARTGroupImpl) then) =
      __$$ARTGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      String? description,
      List<ARTGroupExtraSubscriber> extraSubscribers,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class __$$ARTGroupImplCopyWithImpl<$Res>
    extends _$ARTGroupCopyWithImpl<$Res, _$ARTGroupImpl>
    implements _$$ARTGroupImplCopyWith<$Res> {
  __$$ARTGroupImplCopyWithImpl(
      _$ARTGroupImpl _value, $Res Function(_$ARTGroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? extraSubscribers = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ARTGroupImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      extraSubscribers: null == extraSubscribers
          ? _value._extraSubscribers
          : extraSubscribers // ignore: cast_nullable_to_non_nullable
              as List<ARTGroupExtraSubscriber>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTGroupImpl with DiagnosticableTreeMixin implements _ARTGroup {
  const _$ARTGroupImpl(
      {this.id,
      required this.title,
      this.description,
      final List<ARTGroupExtraSubscriber> extraSubscribers = const [],
      required this.createdAt,
      required this.updatedAt})
      : _extraSubscribers = extraSubscribers;

  factory _$ARTGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTGroupImplFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  final String? description;
  final List<ARTGroupExtraSubscriber> _extraSubscribers;
  @override
  @JsonKey()
  List<ARTGroupExtraSubscriber> get extraSubscribers {
    if (_extraSubscribers is EqualUnmodifiableListView)
      return _extraSubscribers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_extraSubscribers);
  }

  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTGroup(id: $id, title: $title, description: $description, extraSubscribers: $extraSubscribers, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTGroup'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('extraSubscribers', extraSubscribers))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._extraSubscribers, _extraSubscribers) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(_extraSubscribers),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTGroupImplCopyWith<_$ARTGroupImpl> get copyWith =>
      __$$ARTGroupImplCopyWithImpl<_$ARTGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTGroupImplToJson(
      this,
    );
  }
}

abstract class _ARTGroup implements ARTGroup {
  const factory _ARTGroup(
      {final String? id,
      required final String title,
      final String? description,
      final List<ARTGroupExtraSubscriber> extraSubscribers,
      required final String createdAt,
      required final String updatedAt}) = _$ARTGroupImpl;

  factory _ARTGroup.fromJson(Map<String, dynamic> json) =
      _$ARTGroupImpl.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  List<ARTGroupExtraSubscriber> get extraSubscribers;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ARTGroupImplCopyWith<_$ARTGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
