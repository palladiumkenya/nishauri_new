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
  String get lead => throw _privateConstructorUsedError;

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
  $Res call({String? id, String title, String? description, String lead});
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
    Object? lead = null,
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
      lead: null == lead
          ? _value.lead
          : lead // ignore: cast_nullable_to_non_nullable
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
  $Res call({String? id, String title, String? description, String lead});
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
    Object? lead = null,
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
      lead: null == lead
          ? _value.lead
          : lead // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTGroupImpl with DiagnosticableTreeMixin implements _ARTGroup {
  const _$ARTGroupImpl(
      {this.id, required this.title, this.description, required this.lead});

  factory _$ARTGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTGroupImplFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String lead;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTGroup(id: $id, title: $title, description: $description, lead: $lead)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTGroup'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('lead', lead));
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
            (identical(other.lead, lead) || other.lead == lead));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, lead);

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
      required final String lead}) = _$ARTGroupImpl;

  factory _ARTGroup.fromJson(Map<String, dynamic> json) =
      _$ARTGroupImpl.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String get lead;
  @override
  @JsonKey(ignore: true)
  _$$ARTGroupImplCopyWith<_$ARTGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
