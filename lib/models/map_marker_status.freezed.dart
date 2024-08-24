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
  Set<Marker> get markers => throw _privateConstructorUsedError;
  bool get readyToShowMarkers => throw _privateConstructorUsedError;
  BitmapDescriptor? get markerIcon => throw _privateConstructorUsedError;
  BitmapDescriptor? get selectedMarkerIcon =>
      throw _privateConstructorUsedError;
  BitmapDescriptor? get othersMarkerIcon => throw _privateConstructorUsedError;
  GeoPoint? get selectedLocation => throw _privateConstructorUsedError;

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
      {Set<Marker> markers,
      bool readyToShowMarkers,
      BitmapDescriptor? markerIcon,
      BitmapDescriptor? selectedMarkerIcon,
      BitmapDescriptor? othersMarkerIcon,
      GeoPoint? selectedLocation});
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
    Object? selectedMarkerIcon = freezed,
    Object? othersMarkerIcon = freezed,
    Object? selectedLocation = freezed,
  }) {
    return _then(_value.copyWith(
      markers: null == markers
          ? _value.markers
          : markers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      readyToShowMarkers: null == readyToShowMarkers
          ? _value.readyToShowMarkers
          : readyToShowMarkers // ignore: cast_nullable_to_non_nullable
              as bool,
      markerIcon: freezed == markerIcon
          ? _value.markerIcon
          : markerIcon // ignore: cast_nullable_to_non_nullable
              as BitmapDescriptor?,
      selectedMarkerIcon: freezed == selectedMarkerIcon
          ? _value.selectedMarkerIcon
          : selectedMarkerIcon // ignore: cast_nullable_to_non_nullable
              as BitmapDescriptor?,
      othersMarkerIcon: freezed == othersMarkerIcon
          ? _value.othersMarkerIcon
          : othersMarkerIcon // ignore: cast_nullable_to_non_nullable
              as BitmapDescriptor?,
      selectedLocation: freezed == selectedLocation
          ? _value.selectedLocation
          : selectedLocation // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
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
      {Set<Marker> markers,
      bool readyToShowMarkers,
      BitmapDescriptor? markerIcon,
      BitmapDescriptor? selectedMarkerIcon,
      BitmapDescriptor? othersMarkerIcon,
      GeoPoint? selectedLocation});
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
    Object? selectedMarkerIcon = freezed,
    Object? othersMarkerIcon = freezed,
    Object? selectedLocation = freezed,
  }) {
    return _then(_$MarkerStatusImpl(
      markers: null == markers
          ? _value._markers
          : markers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      readyToShowMarkers: null == readyToShowMarkers
          ? _value.readyToShowMarkers
          : readyToShowMarkers // ignore: cast_nullable_to_non_nullable
              as bool,
      markerIcon: freezed == markerIcon
          ? _value.markerIcon
          : markerIcon // ignore: cast_nullable_to_non_nullable
              as BitmapDescriptor?,
      selectedMarkerIcon: freezed == selectedMarkerIcon
          ? _value.selectedMarkerIcon
          : selectedMarkerIcon // ignore: cast_nullable_to_non_nullable
              as BitmapDescriptor?,
      othersMarkerIcon: freezed == othersMarkerIcon
          ? _value.othersMarkerIcon
          : othersMarkerIcon // ignore: cast_nullable_to_non_nullable
              as BitmapDescriptor?,
      selectedLocation: freezed == selectedLocation
          ? _value.selectedLocation
          : selectedLocation // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
    ));
  }
}

/// @nodoc

class _$MarkerStatusImpl implements _MarkerStatus {
  const _$MarkerStatusImpl(
      {final Set<Marker> markers = const {},
      this.readyToShowMarkers = false,
      this.markerIcon = null,
      this.selectedMarkerIcon = null,
      this.othersMarkerIcon = null,
      this.selectedLocation = null})
      : _markers = markers;

  final Set<Marker> _markers;
  @override
  @JsonKey()
  Set<Marker> get markers {
    if (_markers is EqualUnmodifiableSetView) return _markers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_markers);
  }

  @override
  @JsonKey()
  final bool readyToShowMarkers;
  @override
  @JsonKey()
  final BitmapDescriptor? markerIcon;
  @override
  @JsonKey()
  final BitmapDescriptor? selectedMarkerIcon;
  @override
  @JsonKey()
  final BitmapDescriptor? othersMarkerIcon;
  @override
  @JsonKey()
  final GeoPoint? selectedLocation;

  @override
  String toString() {
    return 'MapMarkerStatus(markers: $markers, readyToShowMarkers: $readyToShowMarkers, markerIcon: $markerIcon, selectedMarkerIcon: $selectedMarkerIcon, othersMarkerIcon: $othersMarkerIcon, selectedLocation: $selectedLocation)';
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
                other.markerIcon == markerIcon) &&
            (identical(other.selectedMarkerIcon, selectedMarkerIcon) ||
                other.selectedMarkerIcon == selectedMarkerIcon) &&
            (identical(other.othersMarkerIcon, othersMarkerIcon) ||
                other.othersMarkerIcon == othersMarkerIcon) &&
            (identical(other.selectedLocation, selectedLocation) ||
                other.selectedLocation == selectedLocation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_markers),
      readyToShowMarkers,
      markerIcon,
      selectedMarkerIcon,
      othersMarkerIcon,
      selectedLocation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkerStatusImplCopyWith<_$MarkerStatusImpl> get copyWith =>
      __$$MarkerStatusImplCopyWithImpl<_$MarkerStatusImpl>(this, _$identity);
}

abstract class _MarkerStatus implements MapMarkerStatus {
  const factory _MarkerStatus(
      {final Set<Marker> markers,
      final bool readyToShowMarkers,
      final BitmapDescriptor? markerIcon,
      final BitmapDescriptor? selectedMarkerIcon,
      final BitmapDescriptor? othersMarkerIcon,
      final GeoPoint? selectedLocation}) = _$MarkerStatusImpl;

  @override
  Set<Marker> get markers;
  @override
  bool get readyToShowMarkers;
  @override
  BitmapDescriptor? get markerIcon;
  @override
  BitmapDescriptor? get selectedMarkerIcon;
  @override
  BitmapDescriptor? get othersMarkerIcon;
  @override
  GeoPoint? get selectedLocation;
  @override
  @JsonKey(ignore: true)
  _$$MarkerStatusImplCopyWith<_$MarkerStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
