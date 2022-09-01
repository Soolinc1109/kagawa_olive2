import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  static Future<dynamic> emailSignIn(
      {required String email, required String pass}) async {
    try {
      print(email);
      final UserCredential _result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);
      currentFirebaseUser = _result.user;
      print('Authサインイン完了');
      return _result;
      //正しくいけたらUserCredentialを返す→users.dartのユーザー情報取得に飛ぶ
    } on FirebaseAuthException catch (e) {
      print('authサインインエラー $e');
      return false;
      //firebaseauthを用いたメールアドレスログイン
    }
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn(scopes: ['email']).signIn();
      if (googleUser != null) {
        final name = googleUser.displayName ?? '名称未設定';
        final imageUrl = googleUser.photoUrl;

        
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        final userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        print('googleサインイン完了');
        return userCredential;
      }
    } on FirebaseAuthException catch (e) {
      print('googleサインインエラー$e');
      return null;
    }
    return null;
  }
}
