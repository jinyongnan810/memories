// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency

import 'package:memories/helper/dio_helper.dart';
import 'package:memories/models/friends.dart';
import 'package:memories/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friends_providers.g.dart';

@riverpod
class FriendsList extends _$FriendsList {
  @override
  Friends build() {
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
    }
  }
}
