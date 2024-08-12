// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memories/models/memory.dart';
import 'package:memories/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memories.g.dart';

@riverpod
class Memories extends _$Memories {
  @override
  Future<List<Memory>> build() async {
    final userId = ref.watch(loginStatusProvider.select((v) => v.userId));
    if (userId == null) {
      return Future.value([]);
    }
    final memoriesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('memories')
        .get();
    final memories = memoriesSnapshot.docs.map((e) {
      final data = e.data();

      final memory = Memory(
        id: e.id,
        userId: userId,
        location: data['location'] as GeoPoint,
        happenedAt: (data['happenedAt'] as Timestamp).toDate(),
        updatedAt: (data['updatedAt'] as Timestamp).toDate(),
        title: data['title'] as String,
        contents: data['contents'] as String,
        images:
            (data['images'] as List<dynamic>).map((e) => e as String).toList(),
      );
      return memory;
    }).toList();
    return memories;
  }

  Future<void> add({
    required String title,
    required String contents,
    required GeoPoint location,
    required DateTime happenedAt,
  }) async {
    final userId = ref.watch(loginStatusProvider.select((v) => v.userId));
    if (userId == null) {
      return;
    }
    final result = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('memories')
        .add({
      'location': location,
      'happenedAt': Timestamp.fromDate(happenedAt),
      'updatedAt': Timestamp.now(),
      'title': title,
      'contents': contents,
      'images': [],
    });

    print('⭐️ result: $result');
    state = AsyncData([
      ...state.valueOrNull ?? [],
      Memory(
        id: result.id,
        userId: userId,
        location: location,
        happenedAt: happenedAt,
        updatedAt: DateTime.now(),
        title: title,
        contents: contents,
        images: [],
      ),
    ]);
  }
}
