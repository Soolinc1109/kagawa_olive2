import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/model/category.dart';
import 'package:fluttertwitter/model/menu.dart';
import 'package:fluttertwitter/model/shop.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/category_firestore.dart';
import 'package:fluttertwitter/utils/firestore/posts.dart';
import 'package:fluttertwitter/utils/firestore/shops.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/view/account/edit_account_page.dart';
import 'package:fluttertwitter/view/account/edit_detail_page.dart';
import 'package:fluttertwitter/view/start_up/login_page.dart';
import 'package:fluttertwitter/view/time_line/front_page.dart';
import 'package:fluttertwitter/view/visit_user_page.dart';
import 'package:fluttertwitter/visit_shop_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/account.dart';
import '../../model/post.dart';

class UserPage extends StatefulWidget {
  final Account userInfo;
  const UserPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _StickyTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Color.fromARGB(255, 254, 254, 254), child: tabBar);
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}

const _tabs = <Widget>[
  Tab(
      icon: Icon(
    Icons.filter,
    color: Colors.black,
  )),
  Tab(
      icon: Icon(
    Icons.content_cut,
    color: Colors.black,
  )),
  Tab(
      icon: Icon(
    Icons.content_cut,
    color: Colors.black,
  )),
];

class _UserPageState extends State<UserPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _city = '';
  // final myAccount = Authentication.myAccount!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          return FutureBuilder<Account?>(
              future: UserFirestore.getUserInfo(widget.userInfo.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                final userAccount = snapshot.data;
                if (userAccount == null) {
                  return SizedBox();
                }
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-1.0, 0.0),
                      end: Alignment(1.0, 0.0),
                      colors: [
                        Color.fromARGB(208, 145, 255, 108),
                        Color.fromARGB(255, 237, 255, 100)
                      ],
                      stops: [0.0, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x90afe383),
                        offset: Offset(6, 3),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: Colors.black, size: 35),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    body: SingleChildScrollView(
                      child: Container(
                        height: 900,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(0, 255, 255, 255),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(60),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 30, left: 25, top: 0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: const AssetImage(
                                                            'images/olive.png'),
                                                        fit: BoxFit.contain,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                              255,
                                                              214,
                                                              59,
                                                              181),
                                                          offset: Offset(0, 1),
                                                          blurRadius: 13,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment(
                                                              -1.0, 0.0),
                                                          end: Alignment(
                                                              1.0, 0.0),
                                                          colors: [
                                                            Color.fromARGB(208,
                                                                245, 136, 255),
                                                            Color.fromARGB(255,
                                                                237, 100, 255)
                                                          ],
                                                          stops: [0.0, 1.0],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: NetworkImage(
                                                                    userAccount
                                                                        .imagePath),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 0),
                                                      child: Text(
                                                        userAccount.name,
                                                        style: TextStyle(
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    userAccount.instagram !=
                                                            null
                                                        ? InkWell(
                                                            onTap: () async {
                                                              final url =
                                                                  Uri.parse(
                                                                userAccount
                                                                    .instagram,
                                                              );
                                                              if (await canLaunchUrl(
                                                                  url)) {
                                                                launchUrl(url);
                                                              } else {
                                                                // ignore: avoid_print
                                                                print(
                                                                    "Can't launch $url");
                                                              }
                                                            },
                                                            child: CircleAvatar(
                                                                backgroundColor:
                                                                    Color.fromARGB(
                                                                        0,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                radius: 24,
                                                                foregroundImage:
                                                                    NetworkImage(
                                                                        'https://pics.prcm.jp/0a3e4ccca4b12/68217265/png/68217265.png')),
                                                          )
                                                        : SizedBox()
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 25),
                                        userAccount.like_shop != null
                                            ? FutureBuilder<Shop?>(
                                                future: ShopFirestore.getShop(
                                                    userAccount.like_shop),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return SizedBox();
                                                  }
                                                  Shop likeShopInfo =
                                                      snapshot.data!;
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                              height: 105,
                                                              width: 120,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: const AssetImage(
                                                                      'images/olive.png'),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            217,
                                                                            0),
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            1),
                                                                    blurRadius:
                                                                        13,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    begin:
                                                                        Alignment(
                                                                            -1.0,
                                                                            0.0),
                                                                    end: Alignment(
                                                                        1.0,
                                                                        0.0),
                                                                    colors: [
                                                                      Color.fromARGB(
                                                                          208,
                                                                          255,
                                                                          238,
                                                                          0),
                                                                      Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          193,
                                                                          8)
                                                                    ],
                                                                    stops: [
                                                                      0.0,
                                                                      1.0
                                                                    ],
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          3.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () {},
                                                                    child:
                                                                        Container(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage(likeShopInfo.image_path),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text('好きなお店',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      FutureBuilder<Category?>(
                                                          future: CategoryFirestore
                                                              .getCategorie(
                                                                  userAccount
                                                                      .like_genre),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (!snapshot
                                                                .hasData) {
                                                              return SizedBox();
                                                            }
                                                            Category
                                                                categoryInfo =
                                                                snapshot.data!;
                                                            return Column(
                                                              children: [
                                                                Container(
                                                                    height: 105,
                                                                    width: 120,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image: const AssetImage(
                                                                            'images/olive.png'),
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              25.0),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              217,
                                                                              0),
                                                                          offset: Offset(
                                                                              0,
                                                                              1),
                                                                          blurRadius:
                                                                              13,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: 60,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient:
                                                                            LinearGradient(
                                                                          begin: Alignment(
                                                                              -1.0,
                                                                              0.0),
                                                                          end: Alignment(
                                                                              1.0,
                                                                              0.0),
                                                                          colors: [
                                                                            Color.fromARGB(
                                                                                208,
                                                                                255,
                                                                                238,
                                                                                0),
                                                                            Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                193,
                                                                                8)
                                                                          ],
                                                                          stops: [
                                                                            0.0,
                                                                            1.0
                                                                          ],
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(3.0),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                60,
                                                                            height:
                                                                                50,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: NetworkImage(categoryInfo.image_path),
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(30),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text('好きなジャンル',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold))
                                                              ],
                                                            );
                                                          }),
                                                    ],
                                                  );
                                                })
                                            : SizedBox(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 30, right: 10),
                                          child: Container(
                                            height: 500,
                                            child: Column(
                                              children: [
                                                const Align(
                                                  alignment: Alignment.topRight,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20),
                                                            child: Container(
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              25),
                                                                      child:
                                                                          Text(
                                                                        '大学',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              50),
                                                                      child:
                                                                          Text(
                                                                        '${userAccount.universal}大学',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4),
                                                            child: Container(
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              25),
                                                                      child:
                                                                          Text(
                                                                        '高校',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              50),
                                                                      child:
                                                                          Text(
                                                                        '${userAccount.highschool}高校',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            25),
                                                                    child: Text(
                                                                      '中学',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'YuGothic',
                                                                        fontSize:
                                                                            15,
                                                                        color: const Color(
                                                                            0xff171616),
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                      softWrap:
                                                                          false,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            50),
                                                                    child: Text(
                                                                      '${userAccount.junior_high_school}中学',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'YuGothic',
                                                                        fontSize:
                                                                            15,
                                                                        color: const Color(
                                                                            0xff171616),
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                      softWrap:
                                                                          false,
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20),
                                                            child: Container(
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              25),
                                                                      child:
                                                                          Text(
                                                                        '好きな讃岐弁',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              50),
                                                                      child:
                                                                          Text(
                                                                        '${userAccount.sanukiben}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4),
                                                            child: Container(
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              25),
                                                                      child:
                                                                          Text(
                                                                        '香川歴',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              50),
                                                                      child:
                                                                          Text(
                                                                        '${userAccount.kagawareki}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            25),
                                                                    child: Text(
                                                                      '属性',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'YuGothic',
                                                                        fontSize:
                                                                            15,
                                                                        color: const Color(
                                                                            0xff171616),
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                      softWrap:
                                                                          false,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            50),
                                                                    child: Text(
                                                                      '${userAccount.zokusei}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'YuGothic',
                                                                        fontSize:
                                                                            15,
                                                                        color: const Color(
                                                                            0xff171616),
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                      softWrap:
                                                                          false,
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20),
                                                            child: Container(
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              25),
                                                                      child:
                                                                          Text(
                                                                        '好きな映画',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              50),
                                                                      child:
                                                                          Text(
                                                                        '${userAccount.likemovie}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4),
                                                            child: Container(
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              25),
                                                                      child:
                                                                          Text(
                                                                        '好きな食べ物',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              50),
                                                                      child:
                                                                          Text(
                                                                        '${userAccount.likefood}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'YuGothic',
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              const Color(0xff171616),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            25),
                                                                    child: Text(
                                                                      '趣味',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'YuGothic',
                                                                        fontSize:
                                                                            15,
                                                                        color: const Color(
                                                                            0xff171616),
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                      softWrap:
                                                                          false,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            50),
                                                                    child: Text(
                                                                      '${userAccount.hobby}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'YuGothic',
                                                                        fontSize:
                                                                            15,
                                                                        color: const Color(
                                                                            0xff171616),
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                      softWrap:
                                                                          false,
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                        ],
                                                      ),
                                                      height: 320,
                                                      width: 300,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0x9affffff),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(51.0),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color(
                                                                0xbcffffff),
                                                            offset:
                                                                Offset(6, 3),
                                                            blurRadius: 33,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
