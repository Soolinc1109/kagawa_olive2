import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/model/category.dart';
import 'package:fluttertwitter/model/genre.dart';
import 'package:fluttertwitter/model/post.dart';
import 'package:fluttertwitter/model/shop.dart';
import 'package:fluttertwitter/model/visitShops.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/category_firestore.dart';
import 'package:fluttertwitter/utils/firestore/posts.dart';
import 'package:fluttertwitter/utils/firestore/shops.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/view/account/edit_account_page.dart';
import 'package:fluttertwitter/view/time_line/front_page.dart';
import 'package:fluttertwitter/view/time_line/genre_line_page.dart';
import 'package:fluttertwitter/view/time_line/permit_wait_page.dart';
import 'package:fluttertwitter/view/time_line/post_page.dart';
import 'package:fluttertwitter/view/time_line/shop_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

List<String> image = [
  'cafe.png',
  'udon.png',
  'yousyoku.png',
  'ramen.png',
  'insta.png',
  'teishoku.png',
  'kankoku.png',
  'donmono.png',
  'izakaya.png',
];

class _TimeLinePageState extends State<TimeLinePage> {
  var _city = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            Color.fromARGB(208, 136, 255, 96),
            Color.fromARGB(255, 239, 255, 117)
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
      child: FutureBuilder<Account?>(
          future:
              UserFirestore.getUserInfo(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            }
            final myAccount = snapshot.data;
            if (myAccount == null) {
              return SizedBox();
            }

            return Scaffold(
              backgroundColor: Color.fromARGB(0, 255, 255, 255),

              appBar: AppBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    height: 40,
                    child: Image(
                      image: AssetImage('images/olive.png'),
                    ),
                  ),
                ),
                actions: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(myAccount.id)
                          .collection('visit_shop')
                          .snapshots(),
                      builder: (context, snapshot) {
                        return FutureBuilder<List<VisitShop>?>(
                            future: UserFirestore.getPrShop(uid: myAccount.id),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return SizedBox();
                              }
                              final prShop = snapshot.data;
                              if (prShop!.length == 0) {
                                return SizedBox();
                              }

                              return IconButton(
                                  icon: Icon(
                                    Icons.notification_important_outlined,
                                    color: Color.fromARGB(255, 255, 0, 0),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WaitPermit(
                                                myInfo: myAccount,
                                              )),
                                    );
                                  });
                            });
                      }),
                ],
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                elevation: 0,
              ),
              body: Scrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 45.0),
                            child: FutureBuilder<List<Category>>(
                                future: CategoryFirestore.getCategories(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      alignment: Alignment.centerLeft,
                                      child: SpinKitChasingDots(
                                        color: Color.fromARGB(255, 255, 204, 0),
                                      ),
                                    );
                                  } else if (snapshot.hasData) {
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3),
                                      itemCount: 9,
                                      itemBuilder: (context, index) {
                                        Category category =
                                            snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GenreLinePage(
                                                          category: category,
                                                        )),
                                              );
                                            },
                                            child: Container(
                                              height: 110,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                child: Image(
                                                  image: AssetImage(
                                                      'images/${image[index]}'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                })),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  'おすすめのキャンペーン',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('shops')
                                .where('olive', isEqualTo: 1)
                                .snapshots(),
                            // .collection('my_user_post')
                            // .orderBy('created_time', descending: true)
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return SizedBox();
                              }
                              List<String> shoplist = List.generate(
                                  snapshot.data!.docs.length, (index) {
                                return snapshot.data!.docs[index].id;

                                //自分のmypostsのIDとpostsコレクションにある同じIDの投稿をとってくるために参照
                                //futureで情報を取る前にじぶんのIDと同じものを取るためにやらないといけない処理↑
                              });
                              return FutureBuilder<List<Shop>?>(
                                  future: ShopFirestore.getShops(shoplist),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: SpinKitChasingDots(
                                          color:
                                              Color.fromARGB(255, 255, 204, 0),
                                        ),
                                      );
                                    } else if (snapshot.hasData) {
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 3 / 4,
                                                crossAxisCount: 2),
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          Shop shopAccount =
                                              snapshot.data![index];
                                          return Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ShopPage(
                                                              shopinfo:
                                                                  shopAccount)),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                              39, 0, 0, 0),
                                                          offset: Offset(0, 2),
                                                          blurRadius: 3.0,
                                                          spreadRadius: 2.0,
                                                        ),
                                                      ],
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    children: [
                                                      Stack(children: [
                                                        Container(
                                                          height: 150,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                            child:
                                                                Image.network(
                                                              shopAccount
                                                                  .image_path,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Container(
                                                              width: 32,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 2,
                                                                    horizontal:
                                                                        4),
                                                                child: Text(
                                                                  shopAccount
                                                                      .place_string,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          11),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                shopAccount
                                                                    .shop_name,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10,
                                                                bottom: 0),
                                                        child: Container(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            '1000~1999',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 11),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10,
                                                                left: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              shopAccount
                                                                  .service,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
            );
          }),
    );
  }
}
