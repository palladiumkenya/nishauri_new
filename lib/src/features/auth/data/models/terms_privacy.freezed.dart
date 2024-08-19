// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'terms_privacy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TermsPrivacy _$TermsPrivacyFromJson(Map<String, dynamic> json) {
  return _TermsPrivacy.fromJson(json);
}

/// @nodoc
mixin _$TermsPrivacy {
  String? get title => throw _privateConstructorUsedError;
  String? get introduction => throw _privateConstructorUsedError;
  List<Section>? get sections => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TermsPrivacyCopyWith<TermsPrivacy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermsPrivacyCopyWith<$Res> {
  factory $TermsPrivacyCopyWith(
          TermsPrivacy value, $Res Function(TermsPrivacy) then) =
      _$TermsPrivacyCopyWithImpl<$Res, TermsPrivacy>;
  @useResult
  $Res call({String? title, String? introduction, List<Section>? sections});
}

/// @nodoc
class _$TermsPrivacyCopyWithImpl<$Res, $Val extends TermsPrivacy>
    implements $TermsPrivacyCopyWith<$Res> {
  _$TermsPrivacyCopyWithImpl(this._value, this._then);

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
abstract class _$$TermsPrivacyImplCopyWith<$Res>
    implements $TermsPrivacyCopyWith<$Res> {
  factory _$$TermsPrivacyImplCopyWith(
          _$TermsPrivacyImpl value, $Res Function(_$TermsPrivacyImpl) then) =
      __$$TermsPrivacyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String? introduction, List<Section>? sections});
}

/// @nodoc
class __$$TermsPrivacyImplCopyWithImpl<$Res>
    extends _$TermsPrivacyCopyWithImpl<$Res, _$TermsPrivacyImpl>
    implements _$$TermsPrivacyImplCopyWith<$Res> {
  __$$TermsPrivacyImplCopyWithImpl(
      _$TermsPrivacyImpl _value, $Res Function(_$TermsPrivacyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? introduction = freezed,
    Object? sections = freezed,
  }) {
    return _then(_$TermsPrivacyImpl(
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
class _$TermsPrivacyImpl with DiagnosticableTreeMixin implements _TermsPrivacy {
  const _$TermsPrivacyImpl(
      {this.title, this.introduction, final List<Section>? sections})
      : _sections = sections;

  factory _$TermsPrivacyImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermsPrivacyImplFromJson(json);

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
    return 'TermsPrivacy(title: $title, introduction: $introduction, sections: $sections)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TermsPrivacy'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('introduction', introduction))
      ..add(DiagnosticsProperty('sections', sections));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermsPrivacyImpl &&
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
  _$$TermsPrivacyImplCopyWith<_$TermsPrivacyImpl> get copyWith =>
      __$$TermsPrivacyImplCopyWithImpl<_$TermsPrivacyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermsPrivacyImplToJson(
      this,
    );
  }
}

abstract class _TermsPrivacy implements TermsPrivacy {
  const factory _TermsPrivacy(
      {final String? title,
      final String? introduction,
      final List<Section>? sections}) = _$TermsPrivacyImpl;

  factory _TermsPrivacy.fromJson(Map<String, dynamic> json) =
      _$TermsPrivacyImpl.fromJson;

  @override
  String? get title;
  @override
  String? get introduction;
  @override
  List<Section>? get sections;
  @override
  @JsonKey(ignore: true)
  _$$TermsPrivacyImplCopyWith<_$TermsPrivacyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
