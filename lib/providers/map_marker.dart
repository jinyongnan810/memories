// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memories/models/map_marker_status.dart';
import 'package:memories/providers/map_providers.dart';
import 'package:memories/providers/memories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_marker.g.dart';

@riverpod
class MapMarker extends _$MapMarker {
  @override
  MapMarkerStatus build() {
    ref
      ..listen(markerIconProvider, (prev, next) {
        if (prev != next && next.asData?.value != null) {
          state = state.copyWith(
            readyToShowMarkers: true,
            markerIcon: next.asData!.value,
          );
        }
      })
      ..listen(memoriesProvider, (prev, next) {
        final markers = next.valueOrNull
            ?.map(
              (e) => Marker(
                markerId: MarkerId(e.id),
                position: LatLng(e.location.latitude, e.location.longitude),
                icon: state.markerIcon ?? BitmapDescriptor.defaultMarker,
                onTap: () {
                  state = state.copyWith(selectedLocation: e.location);
                },
              ),
            )
            .toSet();
        state = state.copyWith(markers: markers ?? {});
      });
    return const MapMarkerStatus();
  }

  void clearSelectedLocation() {
    state = state.copyWith(selectedLocation: null);
  }

  void setSelectedLocation(GeoPoint location) {
    state = state.copyWith(selectedLocation: location);
  }
}
