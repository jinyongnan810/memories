import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memories/models/map_marker_status.dart';
import 'package:memories/providers/map_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_marker.g.dart';

@riverpod
class MapMarker extends _$MapMarker {
  @override
  MapMarkerStatus build() {
    ref.listen(markerIconProvider, (prev, next) {
      if (prev != next && next.asData?.value != null) {
        state = state.copyWith(
          readyToShowMarkers: true,
          markerIcon: next.asData!.value,
        );
      }
    });
    return const MapMarkerStatus();
  }

  void addMarker(LatLng latLng) {
    state = state.copyWith(markers: [...state.markers, latLng]);
  }
}
