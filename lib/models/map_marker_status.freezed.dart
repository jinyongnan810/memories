// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_marker_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MapMarkerStatus {
  List<LatLng> get markers => throw _privateConstructorUsedError;
  bool get readyToShowMarkers => throw _privateConstructorUsedError;
  BitmapDescriptor? get markerIcon => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MapMarkerStatusCopyWith<MapMarkerStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapMarkerStatusCopyWith<$Res> {
  factory $MapMarkerStatusCopyWith(
          MapMarkerStatus value, $Res Function(MapMarkerStatus) then) =
      _$MapMarkerStatusCopyWithImpl<$Res, MapMarkerStatus>;
  @useResult
  $Res call(
      {List<LatLng> markers,
      bool readyToShowMarkers,
      BitmapDescriptor? markerIcon});
}

/// @nodoc
class _$MapMarkerStatusCopyWithImpl<$Res, $Val extends MapMarkerStatus>
    implements $MapMarkerStatusCopyWith<$Res> {
  _$MapMarkerStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markers = null,
    Object? readyToShowMarkers = null,
    Object? markerIcon = freezed,
  }) {
    return _then(_value.copyWith(
      markers: null == markers
          ? _value.markers
          : markers // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      readyToShowMarkers: null == readyToShowMarkers
          ? _value.readyToShowMarkers
          : readyToShowMarkers // ignore: cast_nullable_to_non_nullable
              as bool,
      markerIcon: freezed == markerIcon
          ? _value.markerIcon
          : markerIcon // ignore: cast_nullable_to_non_nullable
              as BitmapDescriptor?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarkerStatusImplCopyWith<$Res>
    implements $MapMarkerStatusCopyWith<$Res> {
  factory _$$MarkerStatusImplCopyWith(
          _$MarkerStatusImpl value, $Res Function(_$MarkerStatusImpl) then) =
      __$$MarkerStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<LatLng> markers,
      bool readyToShowMarkers,
      BitmapDescriptor? markerIcon});
}

/// @nodoc
class __$$MarkerStatusImplCopyWithImpl<$Res>
    extends _$MapMarkerStatusCopyWithImpl<$Res, _$MarkerStatusImpl>
    implements _$$MarkerStatusImplCopyWith<$Res> {
  __$$MarkerStatusImplCopyWithImpl(
      _$MarkerStatusImpl _value, $Res Function(_$MarkerStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markers = null,
    Object? readyToShowMarkers = null,
    Object? markerIcon = freezed,
  }) {
    return _then(_$MarkerStatusImpl(
      markers: null == markers
          ? _value._markers
          : markers // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      readyToShowMarkers: null == readyToShowMarkers
          ? _value.readyToShowMarkers
          : readyToShowMarkers // ignore: cast_nullable_to_non_nullable
              as bool,
      markerIcon: freezed == markerIcon
          ? _value.markerIcon
          : markerIcon // ignore: cast_nullable_to_non_nullable
              as BitmapDescriptor?,
    ));
  }
}

/// @nodoc

class _$MarkerStatusImpl implements _MarkerStatus {
  const _$MarkerStatusImpl(
      {final List<LatLng> markers = const [],
      this.readyToShowMarkers = false,
      this.markerIcon = null})
      : _markers = markers;

  final List<LatLng> _markers;
  @override
  @JsonKey()
  List<LatLng> get markers {
    if (_markers is EqualUnmodifiableListView) return _markers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_markers);
  }

  @override
  @JsonKey()
  final bool readyToShowMarkers;
  @override
  @JsonKey()
  final BitmapDescriptor? markerIcon;

  @override
  String toString() {
    return 'MapMarkerStatus(markers: $markers, readyToShowMarkers: $readyToShowMarkers, markerIcon: $markerIcon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkerStatusImpl &&
            const DeepCollectionEquality().equals(other._markers, _markers) &&
            (identical(other.readyToShowMarkers, readyToShowMarkers) ||
                other.readyToShowMarkers == readyToShowMarkers) &&
            (identical(other.markerIcon, markerIcon) ||
                other.markerIcon == markerIcon));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_markers),
      readyToShowMarkers,
      markerIcon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkerStatusImplCopyWith<_$MarkerStatusImpl> get copyWith =>
      __$$MarkerStatusImplCopyWithImpl<_$MarkerStatusImpl>(this, _$identity);
}

abstract class _MarkerStatus implements MapMarkerStatus {
  const factory _MarkerStatus(
      {final List<LatLng> markers,
      final bool readyToShowMarkers,
      final BitmapDescriptor? markerIcon}) = _$MarkerStatusImpl;

  @override
  List<LatLng> get markers;
  @override
  bool get readyToShowMarkers;
  @override
  BitmapDescriptor? get markerIcon;
  @override
  @JsonKey(ignore: true)
  _$$MarkerStatusImplCopyWith<_$MarkerStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
