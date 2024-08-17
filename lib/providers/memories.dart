// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memories/models/memory.dart';
import 'package:memories/providers/providers.dart';
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
    try {
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
          startAt: (data['startAt'] as Timestamp).toDate(),
          endAt: (data['endAt'] as Timestamp).toDate(),
          updatedAt: (data['updatedAt'] as Timestamp).toDate(),
          title: data['title'] as String,
          contents: data['contents'] as String,
        );
        return memory;
      }).toList();
      return memories;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      ref.read(loggerProvider).e('⭐️ memories get error: $e');
      return [];
    }
  }

  Future<void> add({
    required String title,
    required String contents,
    required GeoPoint location,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    final userId = ref.watch(loginStatusProvider.select((v) => v.userId));
    if (userId == null) {
      return;
    }
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('memories')
          .add({
        'location': location,
        'startAt': Timestamp.fromDate(startAt),
        'endAt': Timestamp.fromDate(endAt),
        'updatedAt': Timestamp.now(),
        'title': title,
        'contents': contents,
        'images': [],
      });

      state = AsyncData([
        ...state.valueOrNull ?? [],
        Memory(
          id: result.id,
          userId: userId,
          location: location,
          startAt: startAt,
          endAt: endAt,
          updatedAt: DateTime.now(),
          title: title,
          contents: contents,
        ),
      ]);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      ref.read(loggerProvider).e('⭐️ add error: $e');
    }
  }
}
