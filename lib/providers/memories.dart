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
        createdAt: (data['createdAt'] as Timestamp).toDate(),
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
}