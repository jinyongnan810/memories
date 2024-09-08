// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memories/helper/dio_helper.dart';
import 'package:memories/models/friends.dart';
import 'package:memories/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friends_providers.g.dart';

@riverpod
class FriendsList extends _$FriendsList {
  @override
  Friends build() {
    final userId = ref.watch(loginStatusProvider).userId;
    ref.listen(loginStatusProvider, (prev, next) {
      final userId = next.userId;
      final previousUserId = prev?.userId;
      if (userId == null && previousUserId != null) {
        ref
          ..invalidate(friendsStream(previousUserId))
          ..invalidate(requestsStream(previousUserId));
      }
    });
    if (userId == null) {
      return const Friends();
    }
    ref
      ..listen(
        friendsStream(userId),
        (prev, next) {
          state = state.copyWith(
            friends: next.valueOrNull ?? [],
          );
        },
      )
      ..listen(
        requestsStream(userId),
        (prev, next) {
          state = state.copyWith(
            requests: next.valueOrNull ?? [],
          );
        },
      );
    return const Friends();
  }

  Future<void> requestFriend(String email) async {
    final friends = state.friends;
    final requests = state.requests;
    if (friends.contains(email) || requests.contains(email)) {
      return;
    }
    try {
      final idToken = ref.read(loginStatusProvider).idToken;
      if (idToken == null) {
        return;
      }
      await DioHelper.post(
        path: '/friends/request',
        token: idToken,
        body: {
          'email': email,
        },
      );
      ref.read(loggerProvider).i('request friend success');
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      ref.read(loggerProvider).e(e);
      rethrow;
    }
  }

  Future<void> deleteFriendRequest(String userId) async {
    final requests = state.requests;
    if (!requests.contains(userId)) {
      return;
    }
    try {
      final idToken = ref.read(loginStatusProvider).idToken;
      if (idToken == null) {
        return;
      }
      await DioHelper.delete(
        path: '/friends/request/$userId',
        token: idToken,
      );
      ref.read(loggerProvider).i('delete friend request success');
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      ref.read(loggerProvider).e(e);
      rethrow;
    }
  }

  Future<void> acceptFriend(String userId) async {
    final friends = state.friends;
    final requests = state.requests;
    if (friends.contains(userId) || !requests.contains(userId)) {
      return;
    }
    try {
      final idToken = ref.read(loginStatusProvider).idToken;
      if (idToken == null) {
        return;
      }
      await DioHelper.post(
        path: '/friends',
        token: idToken,
        body: {
          'userId': userId,
        },
      );
      ref.read(loggerProvider).i('accept friend success');
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      ref.read(loggerProvider).e(e);
      rethrow;
    }
  }

  Future<void> deleteFriend(String userId) async {
    final friends = state.friends;
    if (!friends.contains(userId)) {
      return;
    }
    try {
      final idToken = ref.read(loginStatusProvider).idToken;
      if (idToken == null) {
        return;
      }
      await DioHelper.delete(
        path: '/friends',
        token: idToken,
        body: {
          'userId': userId,
        },
      );
      ref.read(loggerProvider).i('delete friend success');
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      ref.read(loggerProvider).e(e);
      rethrow;
    }
  }
}

final friendsStream = StreamProvider.autoDispose.family<List<String>, String>(
  (ref, userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('friends')
        .snapshots()
        .asyncMap((snapshot) {
      return snapshot.docs.map((e) => e.id).toList();
    });
  },
);

final requestsStream = StreamProvider.autoDispose.family<List<String>, String>(
  (ref, userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('requests')
        .snapshots()
        .asyncMap((snapshot) {
      return snapshot.docs.map((e) => e.id).toList();
    });
  },
);
