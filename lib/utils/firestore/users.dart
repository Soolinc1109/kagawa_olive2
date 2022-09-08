import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/model/shop.dart';
import 'package:fluttertwitter/model/visitShops.dart';
import 'package:fluttertwitter/model/visitUsers.dart';
import 'package:fluttertwitter/utils/authentication.dart';

class UserFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users =
      _firestoreInstance.collection('users');
  static final CollectionReference shops =
      _firestoreInstance.collection('shops');

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
        'like_shop': '',
        'instagram': '',
        'like_genre': 1,
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
    print(uid);
    print('=============1============');
    try {
      final documentSnapshot = await users.doc(uid).get();
      final data = documentSnapshot.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }
      Account myAccount = Account(
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
          like_shop: data['like_shop'],
          instagram: data['instagram'],
          like_genre: data['like_genre'],
          createdTime: data['created_time'],
          updatedTime: data['updated_time']);
      print(myAccount.name);
      print(myAccount.userId);
      print(myAccount.sanukiben);
      print(myAccount.universal);
      print(myAccount.name);
      print(myAccount.name);
      print('ユーザー取得完了です');
      return myAccount;
    } on FirebaseException catch (e) {
      print('ユーザー取得失敗');
      return null;
      //ログイン時にfirestoreからユーザーの情報を取得
    }
  }

  // プロフィール画面で編集したユーザーの情報を更新する
  static Future<bool> updateUser(Account updateAccount) async {
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

  static Future<bool> updateUserLikeGenre(Account updateAccount) async {
    try {
      await users.doc(updateAccount.id).update({
        'like_genre': updateAccount.like_genre,
      });
      print('好きなジャンル情報の更新完了');
      return true;
    } on FirebaseException catch (e) {
      print('ユーザー情報の更新エラー $e');
      return false;
    }
  }

  static Future<List<Account>?> getUsers(List<String> sid) async {
    try {
      List<Account> userList = [];

      for (int i = 0; i < sid.length; i++) {
        DocumentSnapshot documentSnapshot = await users.doc(sid[i]).get();
        final data = documentSnapshot.data() as Map<String, dynamic>?;
        if (data == null) {
          return null;
        }
        final user = Account(
            id: sid[i],
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
            // like_shop: data['like_shop'],
            // instagram: data['instagram'],
            // like_genre: data['like_genre'],
            createdTime: data['created_time'],
            updatedTime: data['updated_time']);
        userList.add(user);
      }
      print('ユーザー取得完了');
      return userList;
    } on FirebaseException catch (e) {
      print('ユーザー情報取得失敗');
      return null;
      //ログイン時にfirestoreからユーザーの情報を取得
    }
  }

  static Future<List<Account>?> getVisitUsers(List<String> sid) async {
    try {
      List<Account> userList = [];
      for (int i = 0; i < sid.length; i++) {
        final documentSnapshot = await users.doc(sid[i]).get();
        final data = documentSnapshot.data() as Map<String, dynamic>?;
        if (data == null) {
          return null;
        }
        final shop = Account(
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
            // like_shop: data['like_shop'],
            // instagram: data['instagram'],
            // like_genre: data['like_genre'],
            createdTime: data['created_time'],
            updatedTime: data['updated_time']);
        userList.add(shop);
      }
      print('ユーザー取得完了');
      return userList;
    } on FirebaseException catch (e) {
      print('ユーザー情報取得失敗');
      return null;
      //ログイン時にfirestoreからユーザーの情報を取得
    }
  }

  static Future<bool> AddVisitShop(String uid, String shopid) async {
    try {
      final visitShop = users.doc(uid).collection('visit_shop');
      final DocumentReference = await visitShop.doc(shopid).set({
        'is_permit': false,
        'visit_time': Timestamp.now(),
        'shop_id': shopid,
      });
      print('訪れたお店の登録完了');
      return true;
    } catch (e) {
      print('エラー$e');
      return false;
    }
  }

  static Future<bool> removeVisitShop(String uid, String shopid) async {
    try {
      final visitShop = users.doc(uid).collection('visit_shop');
      final DocumentReference = await visitShop.doc(shopid).delete();
      print('訪れたお店の削除');
      return true;
    } catch (e) {
      print('エラー$e');
      return false;
    }
  }

  static Future<bool> permitedVisiter(String sid, String visit) async {
    try {
      final visitShop = users.doc(sid).collection('visit_shop');
      final DocumentReference = await visitShop.doc(visit).update({
        'is_permit': true,
      });
      print('お客を許可');
      return true;
    } catch (e) {
      print('エラー$e');
      return false;
    }
  }

  static Future<List<Shop>?> getVisitShopsFromIds(List<String> uid) async {
    try {
      List<Shop> shopList = [];
      for (final id in uid) {
        final doc = await shops.doc(id).get();
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          return null;
        }
        final shop = Shop(
            id: id,
            shop_name: data['shop_name'],
            // shop_account_id: data['shop_account_id'],
            address: data['address'],
            selfIntroduction: data['selfIntroduction'],
            image_path: data['image_path'],
            instagram: data['instagram'],
            googlemap: data['googlemap'],
            service: data['service'],
            place: data['place'],
            menu_genre1: data['menu_genre1'],
            menu_genre2: data['menu_genre2'],
            menu_genre3: data['menu_genre3'],
            createdTime: data['created_time'],
            updatedTime: data['updated_time']);
        shopList.add(shop);
      }
      print('貢献したお店の情報取得完了');
      return shopList;
    } on FirebaseException catch (e) {
      print('貢献したお店の情報取得失敗');
      return null;
      //ログイン時にfirestoreからユーザーの情報を取得
    }
  }

  static Future<bool> addLikeShop(Account updateAccount, Shop shop) async {
    try {
      await users.doc(updateAccount.id).update({
        'like_shop': shop.id,
      });
      print('好きなお店の登録完了');
      return true;
    } on FirebaseException catch (e) {
      print('好きなお店の登録エラー $e');
      return false;
    }
  }

  static Future<VisitShop?> getNopermittedShop(
      {required String uid, required String sid}) async {
    try {
      final wantVisitShop = users.doc(uid).collection('visit_shop');
      final documentReference = await wantVisitShop.doc(sid).get();
      final data = documentReference.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }
      final visitShop = VisitShop(
        id: uid,
        is_permit: data['is_permit'],
      );
      print('貢献したお店の情報取得完了');
      return visitShop;
    } on FirebaseException catch (e) {
      print('貢献したお店の情報取得失敗');
      return null;
      //ログイン時にfirestoreからユーザーの情報を取得
    }
  }

  static Future<List<VisitShop>?> getPrShop({required String uid}) async {
    List<VisitShop> prShopList = [];
    try {
      final wantVisitShop = users.doc(uid).collection('visit_shop');
      final documentReference =
          await wantVisitShop.where('is_permit', isEqualTo: false).get();
      var docs = documentReference.docs;
      await Future.forEach(docs, (QueryDocumentSnapshot doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data == null) {
          return null;
        }
        final visitShop = VisitShop(
          id: uid,
          is_permit: data['is_permit'],
        );

        prShopList.add(visitShop);
      });

      print('貢献したお店の情報取得完了');
      return prShopList;
    } on FirebaseException catch (e) {
      print('貢献したお店の情報取得失敗');
      return null;
      //ログイン時にfirestoreからユーザーの情報を取得
    }
  }
}
