import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_marker_status.freezed.dart';

@freezed
class MapMarkerStatus with _$MapMarkerStatus {
  const factory MapMarkerStatus({
    @Default({}) Set<Marker> markers,
    @Default(false) bool readyToShowMarkers,
    @Default(null) BitmapDescriptor? markerIcon,
    @Default(null) GeoPoint? selectedLocation,
  }) = _MarkerStatus;
}
