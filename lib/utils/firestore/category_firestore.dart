import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertwitter/model/category.dart';

class CategoryFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference categories =
      _firestoreInstance.collection('category');

  static Future<List<Category>> getSpecificCategories(String categoryId) async {
    var categorySnapshot =
        await categories.orderBy('num', descending: true).get();
    List<Category> categoryList = [];
    var docs = categorySnapshot.docs;

    for (int i = 0; i < docs.length; i++) {
      Map<String, dynamic> data = docs[i].data() as Map<String, dynamic>;
      // List<String> dataEra = data['era'] as List<String>;

      Category cate = Category(
          num: data['num'],
          categoryName: data['categoryName'],
          id: categoryId,
          image_path: data['image_path']);
      categoryList.add(cate);
    }
    print('カテゴリー情報の取得完了');
    return categoryList;
  }

  static Future<List<Category>> getCategories() async {
    var categorySnapshot =
        await categories.orderBy('num', descending: false).get();
    List<Category> categoryList = [];
    var docs = categorySnapshot.docs;

    for (int i = 0; i < docs.length; i++) {
      Map<String, dynamic> data = docs[i].data() as Map<String, dynamic>;
      // List<String> dataEra = data['era'] as List<String>;

      Category cate = Category(
        num: data['num'],
        categoryName: data['categoryName'],
        id: docs[i].id,
        image_path: data['image_path'],
      );

      categoryList.add(cate);
    }
    print('カテゴリー情報の取得完了');
    return categoryList;
  }

  static Future<Category?> getCategorie(int num) async {
    var categorySnapshot = await categories.where('num', isEqualTo: num).get();

    final docs = categorySnapshot.docs;

    final data = docs[0].data() as Map<String, dynamic>?;
    // List<String> dataEra = data['era'] as List<String>;
    if (data == null) {
      return null;
    }
    Category cate = Category(
      num: data['num'],
      categoryName: data['categoryName'],
      id: docs[0].id,
      image_path: data['image_path'],
    );

    print('カテゴリー情報の取得完了');
    return cate;
  }
}
