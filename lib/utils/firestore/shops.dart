import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/model/menu.dart';
import 'package:fluttertwitter/model/shop.dart';
import 'package:fluttertwitter/utils/authentication.dart';

class ShopFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference shops =
      _firestoreInstance.collection('shops');

  // static Future<dynamic> setUser(Shop newAccount) async {
  //   try {
  //     await users.doc(newAccount.id).set({
  //       'shop_name': newAccount.shop_name,
  //       'user_id': newAccount.userId,
  //       'self_introduction': newAccount.selfIntroduction,
  //       'image_path': newAccount.imagePath,
  //       'created_time': Timestamp.now(),
  //       'updated_time': Timestamp.now(),
  //     });
  //     print('新規ユーザー作成完了');
  //     return true;
  //   } on FirebaseException catch (e) {
  //     print('新規ユーザー作成エラー: $e');
  //     return false;
  //   }
  // }

  static Future<List<Shop>?> getShop(List<String> sid) async {
    try {
      List<Shop> _shopList = [];
      String? basho;
      for (int i = 0; i < sid.length; i++) {
        DocumentSnapshot documentSnapshot = await shops.doc(sid[i]).get();
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        switch (data['place']) {
          case 1:
            basho = '高松';
            break;
          case 2:
            basho = '丸亀';
            break;
          case 3:
            basho = '三豊';
            break;
          case 4:
            basho = 'まんのう・綾川';
            break;
          case 5:
            basho = 'さぬき・三木';
            break;
          case 6:
            basho = '高松';
            break;
          default:
            basho = '位置情報なし';
            break;
        }

        print(data['menu_genre3']);
        Shop shop = Shop(
            id: sid[i],
            shop_name: data['shop_name'],
            // shop_account_id: data['shop_account_id'],
            address: data['address'],
            selfIntroduction: data['selfIntroduction'],
            image_path: data['image_path'],
            instagram: data['instagram'],
            googlemap: data['googlemap'],
            service: data['service'],
            place: data['place'],
            place_string: basho,
            menu_genre1: data['menu_genre1'],
            menu_genre2: data['menu_genre2'],
            menu_genre3: data['menu_genre3'],
            createdTime: data['created_time'],
            updatedTime: data['updated_time']);
        _shopList.add(shop);
      }
      print('お店情報取得完了');
      return _shopList;
    } on FirebaseException catch (e) {
      print('お店情報取得失敗');
      return null;
      //ログイン時にfirestoreからユーザーの情報を取得
    }
  }

  static Future<List<Shop>?> getGenreShops(
      List<String> sid, String genreId) async {
    String? basho;

    List<Shop> shopGenreList = [];
    print(genreId);
    try {
      var snapshot = await shops.where('category', isEqualTo: genreId).get();
      var docs = snapshot.docs;

      for (int i = 0; i < docs.length; i++) {
        DocumentSnapshot documentSnapshot = await shops.doc(sid[i]).get();
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        if (data['place'] == 1) {
          basho = '高松';
        } else {
          basho = '丸亀';
        }
        Shop shop = Shop(
            id: sid[i],
            shop_name: data['shop_name'],
            // shop_account_id: data['shop_account_id'],
            address: data['address'],
            selfIntroduction: data['selfIntroduction'],
            image_path: data['image_path'],
            instagram: data['instagram'],
            googlemap: data['googlemap'],
            service: data['service'],
            place: data['place'],
            createdTime: data['created_time'],
            menu_genre1: data['menu_genre1'],
            menu_genre2: data['menu_genre2'],
            menu_genre3: data['menu_genre3'],
            updatedTime: data['updated_time']);
        shopGenreList.add(shop);
      }

      print('ジャンルごとのお店取得完了');
      return shopGenreList;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  // プロフィール画面で編集したユーザーの情報を更新する
  static Future<dynamic> updateUser(Shop sid) async {
    try {
      await shops.doc(sid.id).update({
        'shop_name': sid.shop_name,
        'address': sid.address,
        'image_path': sid.image_path,
        'shop_account_id': sid.shop_account_id,
        'selfIntroduction': sid.selfIntroduction,
        'instagram': sid.instagram,
        'googlemap': sid.googlemap,
        'place': sid.place,
        'service': sid.service,
        'updated_time': Timestamp.now()
      });
      print('ユーザー情報の更新完了');
      return true;
    } on FirebaseException catch (e) {
      print('ユーザー情報の更新エラー $e');
      return false;
    }
  }

  static Future<List<Menu>?> getShopMenu(String sid, int menuNum) async {
    CollectionReference doc = await shops.doc(sid).collection('menu');
    print(shops.id);
    print(doc.id);
    final QuerySnapshot querySnapshot =
        await doc.where('menu_genre_num', isEqualTo: menuNum).get();
    final queryDocSnapshot = querySnapshot.docs;
    print(queryDocSnapshot.length);
    List<Menu> menuList = [];
    print(querySnapshot.docs.length);
    try {
      // for (int i = 0; i < querySnapshot.docs.length; i++) {
      // List<QueryDocumentSnapshot>
      for (final snapshot in queryDocSnapshot) {
        Map<String, dynamic> data =
            snapshot.data() as Map<String, dynamic>; // `data()`で中身を取り出す
        // final document = await doc.doc().get();
        // Map<String, dynamic> data = querySnapshot.docs as Map<String, dynamic>;
        print(
          data['menu_name'],
        );

        Menu menu = Menu(
          id: doc.id,
          menu_name: data['menu_name'],
          image_path: data['image_path'],
          price: data['price'],
          menu_genre_num: data['menu_genre_num'],
        );
        menuList.add(menu);
      }

      ;
      print('お店のメニュー取得完了');
      return menuList;
    } on FirebaseException catch (e) {
      print('お店のメニュー取得エラー');
      return null;
    }
  }

  //ユーザーの情報を取ってくる

  static Future<Map<String, Account>?> getPostUserMap(
      List<String> accountIds) async {
    Map<String, Account> map = {};
    try {
      await Future.forEach(accountIds, (String accountId) async {
        var doc = await shops.doc(accountId).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Account postAccount = Account(
            id: accountId,
            name: data['name'],
            userId: data['user_id'],
            imagePath: data['image_path'],
            selfIntroduction: data['self_introduction'],
            createdTime: data['created_time'],
            updatedTime: data['updated_time']);
        map[accountId] = postAccount;
      });
      print('投稿ユーザーの情報取得完了');
      return map;
    } on FirebaseException catch (e) {
      print('投稿ユーザーの情報取得失敗: $e');
      return null;
    }
  }

  static Future<List<Shop>?> getShiboriShops(int place) async {
    List<Shop> shopShiboriList = [];
    try {
      print(place);
      var snapshot = await shops.where('place', isEqualTo: place).get();
      var docs = snapshot.docs;
      //for分の中身にasyncawaitが出てくる時はfuture.foreach
      await Future.forEach(docs, (QueryDocumentSnapshot doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String basho;

        Shop shop = Shop(
          id: doc.id,
          shop_name: data['shop_name'],
          // shop_account_id: data['shop_account_id'],
          address: data['address'],
          selfIntroduction: data['selfIntroduction'],
          image_path: data['image_path'],
          instagram: data['instagram'],
          googlemap: data['googlemap'],
          service: data['service'],
          // place_string: basho,
          place: data['place'],
          createdTime: data['created_time'],
          updatedTime: data['updated_time'],
          menu_genre1: data['menu_genre1'],
          menu_genre2: data['menu_genre2'],
          menu_genre3: data['menu_genre3'],
          // options: optionList,
        );

        shopShiboriList.add(shop);
      });

      print('問題取得完了');
      return shopShiboriList;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }
}