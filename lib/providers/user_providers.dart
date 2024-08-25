import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user.dart';

part 'user_providers.g.dart';

@riverpod
Future<User?> fetchUser(FetchUserRef ref, {required String id}) async {
  final doc =
      await FirebaseFirestore.instance.collection('users').doc(id).get();
  if (!doc.exists) {
    return null;
  }
  final data = doc.data();
  if (data == null) {
    return null;
  }
  return User(
    id: doc.id,
    email: data['email'] as String?,
    displayName: data['displayName'] as String?,
    photoUrl: data['photoUrl'] as String?,
  );
}
