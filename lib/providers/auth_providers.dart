import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memories/models/login_status.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginStatusProvider extends Notifier<LoginStatus> {
  @override
  LoginStatus build() {
    ref.listen(firebaseAuthChangesProvider, (prev, next) {
      final user = next.valueOrNull;
      if (user != null) {
        state = LoginStatus(
          userId: user.uid,
          email: user.email,
          displayName: user.displayName,
          photoUrl: user.photoURL,
        );
        return;
      }
      state = LoginStatus.empty();
    });
    return LoginStatus.empty();
  }

  Future<void> login() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    try {
      await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } on FirebaseAuthException catch (e) {
      debugPrint('Login failed with error code: ${e.code}');
    } catch (e) {
      debugPrint('Login failed with error code: $e');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

final firebaseAuthChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final loginStatusProvider =
    NotifierProvider<LoginStatusProvider, LoginStatus>(LoginStatusProvider.new);
