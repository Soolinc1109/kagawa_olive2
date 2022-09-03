import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/utils/authentication.dart';

class UserFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users =
      _firestoreInstance.collection('users');

  static Future<dynamic> setUser(Account newAccount) async {
    try {
      await users.doc(newAccount.id).set({
        'name': newAccount.name,
        'user_id': newAccount.userId,
        'self_introduction': newAccount.selfIntroduction,
        'image_path': newAccount.imagePath,
        'universal': '',
        'highschool': '',
        'junior_high_school': '',
        'sanukiben': '',
        'kagawareki': '',
        'zokusei': '',
        'likemovie': '',
        'likefood': '',
        'hobby': '',
        'is_shop': false,
        'shop_account_id': '',
        'created_time': Timestamp.now(),
        'updated_time': Timestamp.now(),
      });
      print('新規ユーザー作成完了');
      return true;
    } on FirebaseException catch (e) {
      print('新規ユーザー作成エラー: $e');
      return false;
    }
  }

  static Future<bool> existsUser(String uid) async {
    try {
      final documentSnapshot = await users.doc(uid).get();
      return documentSnapshot.exists;
      // final data = documentSnapshot.data() as Map<String, dynamic>;
      // // Account myAccount = Account(
      // //     id: uid,
      // //     name: data['name'],
      // //     userId: data['user_id'],
      // //     selfIntroduction: data['self_introduction'],
      // //     imagePath: data['image_path'],
      // //     universal: data['universal'],
      // //     highschool: data['highschool'],
      // //     junior_high_school: data['junior_high_school'],
      // //     createdTime: data['created_time'],
      // //     updatedTime: data['updated_time'],
      // //     sanukiben: data['sanukiben'],
      // //     kagawareki: data['kagawareki'],
      // //     zokusei: data['zokusei'],
      // //     likemovie: data['likemovie'],
      // //     likefood: data['likefood'],
      // //     hobby: data['hobby']);
      // // Authentication.myAccount = myAccount;
      // print('ユーザー取得完了');
      // return true;
    } on FirebaseException catch (e) {
      print('ユーザー取得失敗');
      return false;
      //ログイン時にfirestoreからユーザーの情報を取得
    }
  }

  static Future<Account?> getUserInfo(String uid) async {
    try {
      final documentSnapshot = await users.doc(uid).get();

      final data = documentSnapshot.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }
      final myAccount = Account(
          id: uid,
          name: data['name'],
          userId: data['user_id'],
          selfIntroduction: data['self_introduction'],
          imagePath: data['image_path'],
          universal: data['universal'],
          highschool: data['highschool'],
          junior_high_school: data['junior_high_school'],
          sanukiben: data['sanukiben'],
          kagawareki: data['kagawareki'],
          zokusei: data['zokusei'],
          likemovie: data['likemovie'],
          likefood: data['likefood'],
          hobby: data['hobby'],
          shop_account_id: data['shop_account_id'],
          is_shop: data['is_shop'],
          createdTime: data['created_time'],
          updatedTime: data['updated_time']);
      print('ユーザー取得完了です');
      return myAccount;
    } on FirebaseException catch (e) {
      print('ユーザー取得失敗');
      return null;
      //ログイン時にfirestoreからユーザーの情報を取得
    }
  }

  // プロフィール画面で編集したユーザーの情報を更新する
  static Future<dynamic> updateUser(Account updateAccount) async {
    try {
      await users.doc(updateAccount.id).update({
        'name': updateAccount.name,
        'image_path': updateAccount.imagePath,
        'user_id': updateAccount.userId,
        'self_introduction': updateAccount.name,
        'universal': updateAccount.universal,
        'highschool': updateAccount.highschool,
        'junior_high_school': updateAccount.junior_high_school,
        'sanukiben': updateAccount.sanukiben,
        'kagawareki': updateAccount.kagawareki,
        'zokusei': updateAccount.zokusei,
        'likemovie': updateAccount.likemovie,
        'likefood': updateAccount.likefood,
        'hobby': updateAccount.hobby,
        'updated_time': Timestamp.now()
      });
      print('ユーザー情報の更新完了');
      return true;
    } on FirebaseException catch (e) {
      print('ユーザー情報の更新エラー $e');
      return false;
    }
  }

  //ユーザーの情報を取ってくる

  // static Future<Map<String, Account>?> getPostUserMap(
  //     List<String> accountIds) async {
  //   Map<String, Account> map = {};
  //   try {
  //     await Future.forEach(accountIds, (String accountId) async {
  //       var doc = await users.doc(accountId).get();
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       Account postAccount = Account(
  //           id: accountId,
  //           name: data['name'],
  //           userId: data['user_id'],
  //           imagePath: data['image_path'],
  //           selfIntroduction: data['self_introduction'],
  //           createdTime: data['created_time'],
  //           updatedTime: data['updated_time']);
  //       map[accountId] = postAccount;
  //     });
  //     print('投稿ユーザーの情報取得完了');
  //     return map;
  //   } on FirebaseException catch (e) {
  //     print('投稿ユーザーの情報取得失敗: $e');
  //     return null;
  //   }
  // }
}
