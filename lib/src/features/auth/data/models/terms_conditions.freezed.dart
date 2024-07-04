// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'terms_conditions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TermsConditions _$TermsConditionsFromJson(Map<String, dynamic> json) {
  return _TermsConditions.fromJson(json);
}

/// @nodoc
mixin _$TermsConditions {
  String? get title => throw _privateConstructorUsedError;
  String? get introduction => throw _privateConstructorUsedError;
  List<Section>? get sections => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TermsConditionsCopyWith<TermsConditions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermsConditionsCopyWith<$Res> {
  factory $TermsConditionsCopyWith(
          TermsConditions value, $Res Function(TermsConditions) then) =
      _$TermsConditionsCopyWithImpl<$Res, TermsConditions>;
  @useResult
  $Res call({String? title, String? introduction, List<Section>? sections});
}

/// @nodoc
class _$TermsConditionsCopyWithImpl<$Res, $Val extends TermsConditions>
    implements $TermsConditionsCopyWith<$Res> {
  _$TermsConditionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? introduction = freezed,
    Object? sections = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: freezed == introduction
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
      sections: freezed == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Section>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TermsConditionsImplCopyWith<$Res>
    implements $TermsConditionsCopyWith<$Res> {
  factory _$$TermsConditionsImplCopyWith(_$TermsConditionsImpl value,
          $Res Function(_$TermsConditionsImpl) then) =
      __$$TermsConditionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String? introduction, List<Section>? sections});
}

/// @nodoc
class __$$TermsConditionsImplCopyWithImpl<$Res>
    extends _$TermsConditionsCopyWithImpl<$Res, _$TermsConditionsImpl>
    implements _$$TermsConditionsImplCopyWith<$Res> {
  __$$TermsConditionsImplCopyWithImpl(
      _$TermsConditionsImpl _value, $Res Function(_$TermsConditionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? introduction = freezed,
    Object? sections = freezed,
  }) {
    return _then(_$TermsConditionsImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: freezed == introduction
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
      sections: freezed == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Section>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TermsConditionsImpl
    with DiagnosticableTreeMixin
    implements _TermsConditions {
  const _$TermsConditionsImpl(
      {this.title, this.introduction, final List<Section>? sections})
      : _sections = sections;

  factory _$TermsConditionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermsConditionsImplFromJson(json);

  @override
  final String? title;
  @override
  final String? introduction;
  final List<Section>? _sections;
  @override
  List<Section>? get sections {
    final value = _sections;
    if (value == null) return null;
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TermsConditions(title: $title, introduction: $introduction, sections: $sections)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TermsConditions'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('introduction', introduction))
      ..add(DiagnosticsProperty('sections', sections));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermsConditionsImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.introduction, introduction) ||
                other.introduction == introduction) &&
            const DeepCollectionEquality().equals(other._sections, _sections));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, introduction,
      const DeepCollectionEquality().hash(_sections));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TermsConditionsImplCopyWith<_$TermsConditionsImpl> get copyWith =>
      __$$TermsConditionsImplCopyWithImpl<_$TermsConditionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermsConditionsImplToJson(
      this,
    );
  }
}

abstract class _TermsConditions implements TermsConditions {
  const factory _TermsConditions(
      {final String? title,
      final String? introduction,
      final List<Section>? sections}) = _$TermsConditionsImpl;

  factory _TermsConditions.fromJson(Map<String, dynamic> json) =
      _$TermsConditionsImpl.fromJson;

  @override
  String? get title;
  @override
  String? get introduction;
  @override
  List<Section>? get sections;
  @override
  @JsonKey(ignore: true)
  _$$TermsConditionsImplCopyWith<_$TermsConditionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
