//投稿をFirestoreに保存可能に

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertwitter/model/post.dart';

class PostFirestore {
  static final _firestoreInsstance = FirebaseFirestore.instance;
  static final CollectionReference posts =
      _firestoreInsstance.collection('posts');

  Future<dynamic> addPost(Post newPost) async {
    try {
      final CollectionReference _userPosts = FirebaseFirestore.instance
          .collection('users')
          .doc(newPost.postAccountId)
          .collection('my_posts');
      var result = await posts.add({
        'content': newPost.content,
        'post_account_id': newPost.postAccountId,
        'created_time': Timestamp.now()
      });
      _userPosts
          .doc(result.id)
          .set({'post_id': result.id, 'created_time': Timestamp.now()});
      print('投稿完了');
      return true;
    } on FirebaseException catch (e) {
      print('投稿エラー: $e');
      return false;
    }
  }

  //自分の投稿をアカウントページに表示
  Future<List<Post>?> getPostsFromIds(List<String> ids) async {
    List<Post> postList = [];
    try {
      //postsとmypostsのIDの一致を確認
      for (String id in ids) {
        DocumentSnapshot<Object?> doc = await posts.doc(id).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Post post = Post(
            id: doc.id,
            content: data['content'],
            postAccountId: data['post_account_id'],
            createdTime: data['created_time']);
        postList.add(post);
      }

      print('自分の投稿を取得完了');
      return postList;
    } catch (e) {
      print('自分の投稿取得エラー: $e');
      return null;
    }
  }
}
