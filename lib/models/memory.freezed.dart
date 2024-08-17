// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Memory {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  GeoPoint get location => throw _privateConstructorUsedError;
  DateTime get startAt => throw _privateConstructorUsedError;
  DateTime get endAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get contents => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MemoryCopyWith<Memory> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoryCopyWith<$Res> {
  factory $MemoryCopyWith(Memory value, $Res Function(Memory) then) =
      _$MemoryCopyWithImpl<$Res, Memory>;
  @useResult
  $Res call(
      {String id,
      String userId,
      GeoPoint location,
      DateTime startAt,
      DateTime endAt,
      DateTime updatedAt,
      String title,
      String contents});
}

/// @nodoc
class _$MemoryCopyWithImpl<$Res, $Val extends Memory>
    implements $MemoryCopyWith<$Res> {
  _$MemoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? location = null,
    Object? startAt = null,
    Object? endAt = null,
    Object? updatedAt = null,
    Object? title = null,
    Object? contents = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemoryImplCopyWith<$Res> implements $MemoryCopyWith<$Res> {
  factory _$$MemoryImplCopyWith(
          _$MemoryImpl value, $Res Function(_$MemoryImpl) then) =
      __$$MemoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      GeoPoint location,
      DateTime startAt,
      DateTime endAt,
      DateTime updatedAt,
      String title,
      String contents});
}

/// @nodoc
class __$$MemoryImplCopyWithImpl<$Res>
    extends _$MemoryCopyWithImpl<$Res, _$MemoryImpl>
    implements _$$MemoryImplCopyWith<$Res> {
  __$$MemoryImplCopyWithImpl(
      _$MemoryImpl _value, $Res Function(_$MemoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? location = null,
    Object? startAt = null,
    Object? endAt = null,
    Object? updatedAt = null,
    Object? title = null,
    Object? contents = null,
  }) {
    return _then(_$MemoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MemoryImpl implements _Memory {
  const _$MemoryImpl(
      {required this.id,
      required this.userId,
      required this.location,
      required this.startAt,
      required this.endAt,
      required this.updatedAt,
      required this.title,
      required this.contents});

  @override
  final String id;
  @override
  final String userId;
  @override
  final GeoPoint location;
  @override
  final DateTime startAt;
  @override
  final DateTime endAt;
  @override
  final DateTime updatedAt;
  @override
  final String title;
  @override
  final String contents;

  @override
  String toString() {
    return 'Memory(id: $id, userId: $userId, location: $location, startAt: $startAt, endAt: $endAt, updatedAt: $updatedAt, title: $title, contents: $contents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.contents, contents) ||
                other.contents == contents));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, userId, location, startAt,
      endAt, updatedAt, title, contents);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoryImplCopyWith<_$MemoryImpl> get copyWith =>
      __$$MemoryImplCopyWithImpl<_$MemoryImpl>(this, _$identity);
}

abstract class _Memory implements Memory {
  const factory _Memory(
      {required final String id,
      required final String userId,
      required final GeoPoint location,
      required final DateTime startAt,
      required final DateTime endAt,
      required final DateTime updatedAt,
      required final String title,
      required final String contents}) = _$MemoryImpl;

  @override
  String get id;
  @override
  String get userId;
  @override
  GeoPoint get location;
  @override
  DateTime get startAt;
  @override
  DateTime get endAt;
  @override
  DateTime get updatedAt;
  @override
  String get title;
  @override
  String get contents;
  @override
  @JsonKey(ignore: true)
  _$$MemoryImplCopyWith<_$MemoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
