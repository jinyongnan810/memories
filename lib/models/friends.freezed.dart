// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friends.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Friends {
  List<String> get friends => throw _privateConstructorUsedError;
  List<String> get requests => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FriendsCopyWith<Friends> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendsCopyWith<$Res> {
  factory $FriendsCopyWith(Friends value, $Res Function(Friends) then) =
      _$FriendsCopyWithImpl<$Res, Friends>;
  @useResult
  $Res call({List<String> friends, List<String> requests});
}

/// @nodoc
class _$FriendsCopyWithImpl<$Res, $Val extends Friends>
    implements $FriendsCopyWith<$Res> {
  _$FriendsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friends = null,
    Object? requests = null,
  }) {
    return _then(_value.copyWith(
      friends: null == friends
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requests: null == requests
          ? _value.requests
          : requests // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendsImplCopyWith<$Res> implements $FriendsCopyWith<$Res> {
  factory _$$FriendsImplCopyWith(
          _$FriendsImpl value, $Res Function(_$FriendsImpl) then) =
      __$$FriendsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> friends, List<String> requests});
}

/// @nodoc
class __$$FriendsImplCopyWithImpl<$Res>
    extends _$FriendsCopyWithImpl<$Res, _$FriendsImpl>
    implements _$$FriendsImplCopyWith<$Res> {
  __$$FriendsImplCopyWithImpl(
      _$FriendsImpl _value, $Res Function(_$FriendsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friends = null,
    Object? requests = null,
  }) {
    return _then(_$FriendsImpl(
      friends: null == friends
          ? _value._friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requests: null == requests
          ? _value._requests
          : requests // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$FriendsImpl implements _Friends {
  const _$FriendsImpl(
      {final List<String> friends = const [],
      final List<String> requests = const []})
      : _friends = friends,
        _requests = requests;

  final List<String> _friends;
  @override
  @JsonKey()
  List<String> get friends {
    if (_friends is EqualUnmodifiableListView) return _friends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friends);
  }

  final List<String> _requests;
  @override
  @JsonKey()
  List<String> get requests {
    if (_requests is EqualUnmodifiableListView) return _requests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requests);
  }

  @override
  String toString() {
    return 'Friends(friends: $friends, requests: $requests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendsImpl &&
            const DeepCollectionEquality().equals(other._friends, _friends) &&
            const DeepCollectionEquality().equals(other._requests, _requests));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_friends),
      const DeepCollectionEquality().hash(_requests));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendsImplCopyWith<_$FriendsImpl> get copyWith =>
      __$$FriendsImplCopyWithImpl<_$FriendsImpl>(this, _$identity);
}

abstract class _Friends implements Friends {
  const factory _Friends(
      {final List<String> friends,
      final List<String> requests}) = _$FriendsImpl;

  @override
  List<String> get friends;
  @override
  List<String> get requests;
  @override
  @JsonKey(ignore: true)
  _$$FriendsImplCopyWith<_$FriendsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
