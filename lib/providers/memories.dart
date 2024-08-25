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
    try {
      final memoriesSnapshot =
          await FirebaseFirestore.instance.collection('memories').get();
      final memories = memoriesSnapshot.docs.map((e) {
        final data = e.data();

        final memory = Memory(
          id: e.id,
          userId: data['userId'] as String,
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

  Future<String?> addMemory({
    required String title,
    required String contents,
    required GeoPoint location,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    final userId = ref.watch(loginStatusProvider.select((v) => v.userId));
    if (userId == null) {
      return null;
    }
    try {
      final result =
          await FirebaseFirestore.instance.collection('memories').add({
        'location': location,
        'startAt': Timestamp.fromDate(startAt),
        'endAt': Timestamp.fromDate(endAt),
        'updatedAt': Timestamp.now(),
        'title': title,
        'contents': contents,
        'userId': userId,
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
      return result.id;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      ref.read(loggerProvider).e('⭐️ add error: $e');
    }
    return null;
  }

  Future<void> updateMemory({
    required String id,
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
      await FirebaseFirestore.instance.collection('memories').doc(id).update({
        'location': location,
        'startAt': Timestamp.fromDate(startAt),
        'endAt': Timestamp.fromDate(endAt),
        'updatedAt': Timestamp.now(),
        'title': title,
        'contents': contents,
      });
      final updatedMemory = Memory(
        id: id,
        userId: userId,
        location: location,
        startAt: startAt,
        endAt: endAt,
        updatedAt: DateTime.now(),
        title: title,
        contents: contents,
      );

      state = AsyncData([
        ...state.valueOrNull?.map((e) {
              if (e.id == id) {
                return updatedMemory;
              }
              return e;
            }).toList() ??
            [],
      ]);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      ref.read(loggerProvider).e('⭐️ update error: $e');
    }
  }

  Future<void> deleteMemory(String id) async {
    final userId = ref.watch(loginStatusProvider.select((v) => v.userId));
    if (userId == null) {
      return;
    }
    try {
      await FirebaseFirestore.instance.collection('memories').doc(id).delete();
      state = AsyncData([
        ...state.valueOrNull?.where((e) => e.id != id).toList() ?? [],
      ]);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      ref.read(loggerProvider).e('⭐️ delete error: $e');
    }
  }
}

@riverpod
Future<Memory?> fetchMemory(FetchMemoryRef ref, {required String id}) async {
  final doc =
      await FirebaseFirestore.instance.collection('memories').doc(id).get();
  if (!doc.exists) {
    return null;
  }
  final data = doc.data();
  if (data == null) {
    return null;
  }
  return Memory(
    id: doc.id,
    userId: data['userId'] as String,
    location: data['location'] as GeoPoint,
    startAt: (data['startAt'] as Timestamp).toDate(),
    endAt: (data['endAt'] as Timestamp).toDate(),
    updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    title: data['title'] as String,
    contents: data['contents'] as String,
  );
}
