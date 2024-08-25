import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memories/providers/user_providers.dart';

class UserIcon extends ConsumerWidget {
  const UserIcon({super.key, required this.userId, this.size = 32});
  final String userId;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(fetchUserProvider(id: userId));
    final data = user.valueOrNull;
    if (data != null && data.photoUrl != null) {
      return Tooltip(
        message: data.email,
        child: ClipOval(
          child: CachedNetworkImage(
            width: size,
            imageUrl: data.photoUrl!,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      );
    }
    return const CircleAvatar(
      child: Icon(Icons.face),
    );
  }
}
