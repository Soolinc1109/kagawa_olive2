import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../model/account.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Account? myAccount;

  static Future<dynamic> signUp(
      {required String email, required String pass}) async {
    try {
      UserCredential newAccount = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass);
      print('Auth登録完了');
      return newAccount;
    } on FirebaseAuthException catch (e) {
      print('auth登録エラー $e');
      return false;
    }
  }

  static Future<UserCredential?> emailSignIn(
      {required String email, required String pass}) async {
    try {
      print(email);
      final _result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
      currentFirebaseUser = _result.user;
      print('Authサインイン完了');
      return _result;
      //正しくいけたらUserCredentialを返す→users.dartのユーザー情報取得に飛ぶ
    } on FirebaseAuthException catch (e) {
      print('authサインインエラー $e');
      return null;
      //firebaseauthを用いたメールアドレスログイン
    }
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn(scopes: ['email']).signIn();
      if (googleUser != null) {
        final name = googleUser.displayName ?? '名称未設定';
        final imageUrl = googleUser.photoUrl ?? '';
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        final userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        await createUserIfNotExist(
            userCredential: userCredential, name: name, imageUrl: imageUrl);
        print('googleサインイン完了');
        return userCredential;
      }
    } on FirebaseAuthException catch (e) {
      print('googleサインインエラー$e');
      return null;
    }
    return null;
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    print('================１=========');
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    print('================２=========');
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    final name = '${appleCredential.givenName}${appleCredential.familyName}';
    print('================３=========');
    await createUserIfNotExist(
        userCredential: userCredential, name: name, imageUrl: '');
    return userCredential;
  }

  Future<void> createUserIfNotExist({
    required UserCredential userCredential,
    required String name,
    required String imageUrl,
  }) async {
    final result = await UserFirestore.existsUser(userCredential.user!.uid);
    if (result) {
      return;
    }
    await UserFirestore.setUser(Account(
      id: userCredential.user!.uid,
      name: name,
      imagePath: imageUrl,
    ));
  }
}

FirebaseMessaging messaging = FirebaseMessaging.instance;

// use the returned token to send messages to users from your custom server
Future<String?> getToken() async {
  final token = await messaging.getToken();
  return token;
}
