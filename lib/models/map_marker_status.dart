import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_marker_status.freezed.dart';

@freezed
class MapMarkerStatus with _$MapMarkerStatus {
  const factory MapMarkerStatus({
    @Default([]) List<LatLng> markers,
    @Default(false) bool readyToShowMarkers,
    @Default(null) BitmapDescriptor? markerIcon,
  }) = _MarkerStatus;
}
