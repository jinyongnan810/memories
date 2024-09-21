import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memories/models/login_status.dart';
import 'package:memories/providers/user_providers.dart';

class LoginStatusProvider extends Notifier<LoginStatus> {
  @override
  LoginStatus build() {
    ref.listen(firebaseAuthChangesProvider, (prev, next) async {
      final user = next.valueOrNull;
      if (user != null) {
        final idToken = await user.getIdToken();
        if (idToken == null) {
          state = LoginStatus.empty();
          return;
        }
        state = LoginStatus(
          userId: user.uid,
          email: user.email,
          displayName: user.displayName,
          photoUrl: user.photoURL,
          idToken: idToken,
        );
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email,
          'displayName': user.displayName,
          'photoUrl': user.photoURL,
        });
        ref.invalidate(fetchUserProvider(id: user.uid));
        return;
      }
      state = LoginStatus.empty();
    });
    return LoginStatus.empty();
  }

  Future<void> login() async {
    try {
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
        return;
      }
      final googleSignIn = GoogleSignIn();
      final user = await googleSignIn.signIn();
      if (user == null) {
        return;
      }
      final auth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      debugPrint('Login failed with error code: ${e.code}');
      // ignore: avoid_catches_without_on_clauses
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
