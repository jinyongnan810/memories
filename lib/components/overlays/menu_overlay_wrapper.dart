import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memories/components/sheets/marker_action_sheet.dart';
import 'package:memories/providers/map_marker.dart';

class MenuOverlayWrapper extends StatelessWidget {
  const MenuOverlayWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PortalTarget(portalFollower: const _MenuOverlay(), child: child);
  }
}

final _slideTween = Tween<Offset>(
  begin: const Offset(0, 1),
  end: Offset.zero,
);

class _MenuOverlay extends HookConsumerWidget {
  const _MenuOverlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
    );
    final selectedLocation = useState<GeoPoint?>(null);
    ref.listen(mapMarkerProvider.select((v) => v.selectedLocation),
        (previous, next) async {
      if (previous == next) {
        return;
      }
      await animationController.reverse();
      selectedLocation.value = next;
      if (next != null) {
        await animationController.forward();
      }
    });
    if (selectedLocation.value == null) {
      return const SizedBox.shrink();
    }
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SlideTransition(
            position: _slideTween.animate(animationController),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: MarkerActionSheet(location: selectedLocation.value!),
            ),
          ),
        ),
      ],
    );
  }
}
