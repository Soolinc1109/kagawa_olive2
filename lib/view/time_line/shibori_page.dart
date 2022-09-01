import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/model/category.dart';
import 'package:fluttertwitter/model/genre.dart';
import 'package:fluttertwitter/model/post.dart';
import 'package:fluttertwitter/model/shop.dart';
import 'package:fluttertwitter/utils/firestore/category_firestore.dart';
import 'package:fluttertwitter/utils/firestore/posts.dart';
import 'package:fluttertwitter/utils/firestore/shops.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/view/time_line/post_page.dart';
import 'package:fluttertwitter/view/time_line/shop_page.dart';
import 'package:intl/intl.dart';

class ShiboriPage extends StatefulWidget {
  final int place;
  final String basho;
  const ShiboriPage({Key? key, required this.place, required this.basho})
      : super(key: key);

  @override
  _ShiboriPageState createState() => _ShiboriPageState();
}

class _ShiboriPageState extends State<ShiboriPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            Color.fromARGB(208, 162, 255, 132),
            Color.fromARGB(255, 242, 255, 140)
          ],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(144, 198, 255, 148),
            offset: Offset(6, 3),
            blurRadius: 18,
          ),
        ],
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        appBar: AppBar(
          centerTitle: true,

          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              height: 40,
              child: Text(
                widget.basho,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),

          // Text(
          //   '香川olive',
          //   style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          // ),
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('shops')
                          .orderBy('created_time', descending: true)
                          .snapshots(),

                      // .collection('my_user_post')
                      // .orderBy('created_time', descending: true)

                      builder: (context, snapshot) {
                        List<String> shoplist =
                            List.generate(snapshot.data!.docs.length, (index) {
                          return snapshot.data!.docs[index].id;

                          //自分のmypostsのIDとpostsコレクションにある同じIDの投稿をとってくるために参照
                          //futureで情報を取る前にじぶんのIDと同じものを取るためにやらないといけない処理↑
                        });
                        return FutureBuilder<List<Shop>?>(
                            future: ShopFirestore.getShiboriShops(widget.place),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 3 / 4,
                                          crossAxisCount: 2),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    Shop shopAccount = snapshot.data![index];

                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: InkWell(
                                        onTap: () {
                                          print('===========123==============');
                                          print(shopAccount.id);
                                          print(
                                              '=============11113============');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ShopPage(
                                                    shopinfo: shopAccount)),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 130,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                  child: Image.network(
                                                    shopAccount.image_path,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    shopAccount.shop_name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, bottom: 0),
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  width: double.infinity,
                                                  child: Text(
                                                    '1000~1999',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, bottom: 0),
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  width: double.infinity,
                                                  child: Text(
                                                    shopAccount.service,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            });
                      }),
                ],
              ),
            ),
          ),
        ),

        //  StreamBuilder<QuerySnapshot>(
        //     stream: PostFirestore.posts
        //         .orderBy('created_time', descending: true)
        //         .snapshots(),
        //     builder: (context, postSnapshot) {
        //       if (postSnapshot.hasData) {
        //         List<String> postAccountIds = [];
        //         postSnapshot.data!.docs.forEach((doc) {
        //           Map<String, dynamic> data =
        //               doc.data() as Map<String, dynamic>;
        //           if (!postAccountIds.contains(data['post_account_id'])) {
        //             postAccountIds.add(data['post_account_id']);
        //           }
        //         });
        //         return FutureBuilder<Map<String, Account>?>(
        //             future: UserFirestore.getPostUserMap(postAccountIds),
        //             builder: (context, userSnapshot) {
        //               if (userSnapshot.hasData &&
        //                   userSnapshot.connectionState ==
        //                       ConnectionState.done) {
        //                 return ListView.builder(
        //                   itemCount: postSnapshot.data!.docs.length,
        //                   itemBuilder: (context, index) {
        //                     Map<String, dynamic> data =
        //                         postSnapshot.data!.docs[index].data()
        //                             as Map<String, dynamic>;
        //                     Post post = Post(
        //                         id: postSnapshot.data!.docs[index].id,
        //                         content: data['content'],
        //                         postAccountId: data['post_account_id'],
        //                         createdTime: data['created_time']);
        //                     Account postAccount =
        //                         userSnapshot.data![post.postAccountId]!;
        //                     return Container(
        //                       decoration: BoxDecoration(
        //                           border: index == 0
        //                               ? Border(
        //                                   top: BorderSide(
        //                                       color: Colors.grey, width: 0),
        //                                   bottom: BorderSide(
        //                                       color: Colors.grey, width: 0))
        //                               : Border(
        //                                   bottom: BorderSide(
        //                                       color: Colors.grey, width: 0),
        //                                 )),
        //                       padding: EdgeInsets.symmetric(
        //                           horizontal: 10, vertical: 15),
        //                       child: Row(
        //                         children: [
        //                           Padding(
        //                             padding: const EdgeInsets.only(
        //                               top: 6,
        //                               right: 8,
        //                             ),
        //                             child: CircleAvatar(
        //                               radius: 28,
        //                               foregroundImage:
        //                                   NetworkImage(postAccount.imagePath),
        //                             ),
        //                           ),
        //                           Expanded(
        //                             child: Container(
        //                               child: Column(
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                 children: [
        //                                   Row(
        //                                     mainAxisAlignment:
        //                                         MainAxisAlignment.spaceBetween,
        //                                     children: [
        //                                       Row(
        //                                         children: [
        //                                           Text(
        //                                             postAccount.name,
        //                                             style: TextStyle(
        //                                                 fontWeight:
        //                                                     FontWeight.bold,
        //                                                 color: Color.fromARGB(
        //                                                     255, 0, 0, 0)),
        //                                           ),
        //                                           Padding(
        //                                             padding:
        //                                                 const EdgeInsets.only(
        //                                                     left: 7),
        //                                             child: Text(
        //                                               '@${postAccount.userId}',
        //                                               style: TextStyle(
        //                                                   color: Colors.grey),
        //                                             ),
        //                                           ),
        //                                         ],
        //                                       ),
        //                                       Text(DateFormat('M/d').format(
        //                                           post.createdTime!.toDate()))
        //                                     ],
        //                                   ),
        //                                   Text(post.content)
        //                                 ],
        //                               ),
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                     );
        //                   },
        //                 );
        //               } else {
        //                 return Container();
        //               }
        //             });
        //       } else {
        //         return Container();
        //       }
        //     }),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => PostPage()),
        //     );
        //   },
        //   child: Icon(Icons.chat_bubble_outline),
        // ),
      ),
    );
  }
}
