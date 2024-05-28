// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'art_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ARTEvent _$ARTEventFromJson(Map<String, dynamic> json) {
  return _ARTEvent.fromJson(json);
}

/// @nodoc
mixin _$ARTEvent {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get distributionTime => throw _privateConstructorUsedError;
  String get venue => throw _privateConstructorUsedError;
  List<String> get reminderNotificationDates =>
      throw _privateConstructorUsedError;
  ARTGroup get group => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ARTEventCopyWith<ARTEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ARTEventCopyWith<$Res> {
  factory $ARTEventCopyWith(ARTEvent value, $Res Function(ARTEvent) then) =
      _$ARTEventCopyWithImpl<$Res, ARTEvent>;
  @useResult
  $Res call(
      {String? id,
      String title,
      String distributionTime,
      String venue,
      List<String> reminderNotificationDates,
      ARTGroup group});

  $ARTGroupCopyWith<$Res> get group;
}

/// @nodoc
class _$ARTEventCopyWithImpl<$Res, $Val extends ARTEvent>
    implements $ARTEventCopyWith<$Res> {
  _$ARTEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? distributionTime = null,
    Object? venue = null,
    Object? reminderNotificationDates = null,
    Object? group = null,
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
      distributionTime: null == distributionTime
          ? _value.distributionTime
          : distributionTime // ignore: cast_nullable_to_non_nullable
              as String,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String,
      reminderNotificationDates: null == reminderNotificationDates
          ? _value.reminderNotificationDates
          : reminderNotificationDates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as ARTGroup,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ARTGroupCopyWith<$Res> get group {
    return $ARTGroupCopyWith<$Res>(_value.group, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ARTEventImplCopyWith<$Res>
    implements $ARTEventCopyWith<$Res> {
  factory _$$ARTEventImplCopyWith(
          _$ARTEventImpl value, $Res Function(_$ARTEventImpl) then) =
      __$$ARTEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      String distributionTime,
      String venue,
      List<String> reminderNotificationDates,
      ARTGroup group});

  @override
  $ARTGroupCopyWith<$Res> get group;
}

/// @nodoc
class __$$ARTEventImplCopyWithImpl<$Res>
    extends _$ARTEventCopyWithImpl<$Res, _$ARTEventImpl>
    implements _$$ARTEventImplCopyWith<$Res> {
  __$$ARTEventImplCopyWithImpl(
      _$ARTEventImpl _value, $Res Function(_$ARTEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? distributionTime = null,
    Object? venue = null,
    Object? reminderNotificationDates = null,
    Object? group = null,
  }) {
    return _then(_$ARTEventImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      distributionTime: null == distributionTime
          ? _value.distributionTime
          : distributionTime // ignore: cast_nullable_to_non_nullable
              as String,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String,
      reminderNotificationDates: null == reminderNotificationDates
          ? _value._reminderNotificationDates
          : reminderNotificationDates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as ARTGroup,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ARTEventImpl with DiagnosticableTreeMixin implements _ARTEvent {
  const _$ARTEventImpl(
      {this.id,
      required this.title,
      required this.distributionTime,
      required this.venue,
      final List<String> reminderNotificationDates = const [],
      required this.group})
      : _reminderNotificationDates = reminderNotificationDates;

  factory _$ARTEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ARTEventImplFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  final String distributionTime;
  @override
  final String venue;
  final List<String> _reminderNotificationDates;
  @override
  @JsonKey()
  List<String> get reminderNotificationDates {
    if (_reminderNotificationDates is EqualUnmodifiableListView)
      return _reminderNotificationDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reminderNotificationDates);
  }

  @override
  final ARTGroup group;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ARTEvent(id: $id, title: $title, distributionTime: $distributionTime, venue: $venue, reminderNotificationDates: $reminderNotificationDates, group: $group)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ARTEvent'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('distributionTime', distributionTime))
      ..add(DiagnosticsProperty('venue', venue))
      ..add(DiagnosticsProperty(
          'reminderNotificationDates', reminderNotificationDates))
      ..add(DiagnosticsProperty('group', group));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ARTEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.distributionTime, distributionTime) ||
                other.distributionTime == distributionTime) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            const DeepCollectionEquality().equals(
                other._reminderNotificationDates, _reminderNotificationDates) &&
            (identical(other.group, group) || other.group == group));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      distributionTime,
      venue,
      const DeepCollectionEquality().hash(_reminderNotificationDates),
      group);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ARTEventImplCopyWith<_$ARTEventImpl> get copyWith =>
      __$$ARTEventImplCopyWithImpl<_$ARTEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ARTEventImplToJson(
      this,
    );
  }
}

abstract class _ARTEvent implements ARTEvent {
  const factory _ARTEvent(
      {final String? id,
      required final String title,
      required final String distributionTime,
      required final String venue,
      final List<String> reminderNotificationDates,
      required final ARTGroup group}) = _$ARTEventImpl;

  factory _ARTEvent.fromJson(Map<String, dynamic> json) =
      _$ARTEventImpl.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String get distributionTime;
  @override
  String get venue;
  @override
  List<String> get reminderNotificationDates;
  @override
  ARTGroup get group;
  @override
  @JsonKey(ignore: true)
  _$$ARTEventImplCopyWith<_$ARTEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
