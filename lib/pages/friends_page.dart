import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memories/components/dialogs/add_friend_dialog.dart';
import 'package:memories/components/dialogs/delete_memory_dialog.dart';
import 'package:memories/components/user_icon.dart';
import 'package:memories/providers/friends_providers.dart';
import 'package:memories/providers/user_providers.dart';

class FriendsPage extends ConsumerWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsAndRequests = ref.watch(friendsListProvider);
    final friends = friendsAndRequests.friends;
    final requests = friendsAndRequests.requests;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('友達'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _ActionButton(
                text: '追加',
                onPressed: () async {
                  final email = await showAddFriendDialog(context);
                  if (email != null) {
                    try {
                      await ref
                          .read(friendsListProvider.notifier)
                          .requestFriend(email);
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('友達のリクエストを送りました'),
                        ),
                      );
                      // ignore: avoid_catches_without_on_clauses
                    } catch (e) {
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('友達のリクエストに失敗しました'),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              const _BadgeTab(text: '友達', unreadCount: 0),
              _BadgeTab(text: 'リクエスト', unreadCount: requests.length),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];

                return ListTile(
                  leading: UserIcon(userId: friend),
                  title: _UserName(userId: friend),
                  subtitle: _UserEmail(userId: friend),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ActionButton(
                        text: '削除する',
                        onPressed: () async {
                          final confirm = await showDeleteDialog(context);
                          if (confirm != true) {
                            return;
                          }
                          try {
                            await ref
                                .read(friendsListProvider.notifier)
                                .deleteFriend(friend);
                            if (!context.mounted) {
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('友達を削除しました'),
                              ),
                            );
                            // ignore: avoid_catches_without_on_clauses
                          } catch (e) {
                            if (!context.mounted) {
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('友達の削除に失敗しました'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return HookBuilder(
                  builder: (context) {
                    final disabled = useState(false);
                    final request = requests[index];
                    return ListTile(
                      leading: UserIcon(userId: request),
                      title: _UserName(userId: request),
                      subtitle: _UserEmail(userId: request),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ActionButton(
                            disabled: disabled,
                            text: '受け入れる',
                            onPressed: () async {
                              try {
                                await ref
                                    .read(friendsListProvider.notifier)
                                    .acceptFriend(request);
                                if (!context.mounted) {
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('友達を追加しました'),
                                  ),
                                );
                                // ignore: avoid_catches_without_on_clauses
                              } catch (e) {
                                if (!context.mounted) {
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('友達の追加に失敗しました'),
                                  ),
                                );
                              }
                            },
                          ),
                          _ActionButton(
                            disabled: disabled,
                            text: '削除する',
                            onPressed: () async {
                              try {
                                final confirm = await showDeleteDialog(context);
                                if (confirm != true) {
                                  return;
                                }
                                await ref
                                    .read(friendsListProvider.notifier)
                                    .deleteFriendRequest(request);
                                if (!context.mounted) {
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('友達のリクエストを削除しました'),
                                  ),
                                );
                                // ignore: avoid_catches_without_on_clauses
                              } catch (e) {
                                if (!context.mounted) {
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('友達のリクエストの削除に失敗しました'),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _UserName extends ConsumerWidget {
  const _UserName({required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(fetchUserProvider(id: userId));
    final data = user.valueOrNull;
    return Text(data?.displayName ?? '');
  }
}

class _UserEmail extends ConsumerWidget {
  const _UserEmail({required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(fetchUserProvider(id: userId));
    final data = user.valueOrNull;
    return Text(data?.email ?? '');
  }
}

class _BadgeTab extends StatelessWidget {
  const _BadgeTab({
    required this.text,
    required this.unreadCount,
  });
  final String text;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: Text(text)),
        if (unreadCount > 0) ...[
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$unreadCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }
}

class _ActionButton extends HookConsumerWidget {
  const _ActionButton({
    required this.onPressed,
    required this.text,
    this.disabled,
  });
  final Future<void> Function() onPressed;
  final String text;
  final ValueNotifier<bool>? disabled;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    if (loading.value) {
      return const SizedBox(
        width: 80,
        height: 40,
        child: Center(
          child: CircularProgressIndicator(strokeWidth: 1),
        ),
      );
    }
    return TextButton(
      onPressed: (disabled == null || disabled!.value == false)
          ? () async {
              if (loading.value) {
                return;
              }
              loading.value = true;
              disabled?.value = true;
              await onPressed();
              loading.value = false;
              disabled?.value = false;
            }
          : null,
      child: Text(
        text,
      ),
    );
  }
}
