// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'courier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Courier _$CourierFromJson(Map<String, dynamic> json) {
  return _Courier.fromJson(json);
}

/// @nodoc
mixin _$Courier {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourierCopyWith<Courier> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourierCopyWith<$Res> {
  factory $CourierCopyWith(Courier value, $Res Function(Courier) then) =
      _$CourierCopyWithImpl<$Res, Courier>;
  @useResult
  $Res call({int? id, String? name, String? description});
}

/// @nodoc
class _$CourierCopyWithImpl<$Res, $Val extends Courier>
    implements $CourierCopyWith<$Res> {
  _$CourierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourierImplCopyWith<$Res> implements $CourierCopyWith<$Res> {
  factory _$$CourierImplCopyWith(
          _$CourierImpl value, $Res Function(_$CourierImpl) then) =
      __$$CourierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? description});
}

/// @nodoc
class __$$CourierImplCopyWithImpl<$Res>
    extends _$CourierCopyWithImpl<$Res, _$CourierImpl>
    implements _$$CourierImplCopyWith<$Res> {
  __$$CourierImplCopyWithImpl(
      _$CourierImpl _value, $Res Function(_$CourierImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_$CourierImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourierImpl with DiagnosticableTreeMixin implements _Courier {
  const _$CourierImpl({this.id, this.name, this.description});

  factory _$CourierImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourierImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Courier(id: $id, name: $name, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Courier'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourierImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CourierImplCopyWith<_$CourierImpl> get copyWith =>
      __$$CourierImplCopyWithImpl<_$CourierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourierImplToJson(
      this,
    );
  }
}

abstract class _Courier implements Courier {
  const factory _Courier(
      {final int? id,
      final String? name,
      final String? description}) = _$CourierImpl;

  factory _Courier.fromJson(Map<String, dynamic> json) = _$CourierImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$CourierImplCopyWith<_$CourierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
