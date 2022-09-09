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
import 'package:fluttertwitter/view/edit_like_shop.dart';
import 'package:fluttertwitter/view/start_up/login_page.dart';
import 'package:fluttertwitter/view/time_line/front_page.dart';
import 'package:fluttertwitter/view/time_line/shop_page.dart';
import 'package:fluttertwitter/view/visit_user_page.dart';
import 'package:fluttertwitter/visit_shop_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/account.dart';
import '../../model/post.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
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

class _AccountPageState extends State<AccountPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _city = '';
  // final myAccount = Authentication.myAccount!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          return FutureBuilder<Account?>(
              future: UserFirestore.getUserInfo(
                  FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                final myAccount = snapshot.data;
                if (myAccount == null) {
                  return SizedBox();
                }

                return myAccount.is_shop
                    ? FutureBuilder<Shop?>(
                        future:
                            ShopFirestore.getShop(myAccount.shop_account_id),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox();
                          }
                          Shop shopMyInfo = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Scaffold(
                              key: _scaffoldKey,
                              endDrawer: Drawer(
                                child: ListView(
                                  children: <Widget>[
                                    Container(
                                      height: 100,
                                      child: DrawerHeader(
                                        child: Text(
                                          '設定',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 255, 183, 0),
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        '来店者',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => VistUserPage(
                                              shopInfo: shopMyInfo,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                      thickness: 0.6,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Color.fromARGB(255, 135, 135, 135),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'プロフィールを編集する',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditAccountPage(
                                              myaccount: myAccount,
                                            ),
                                            fullscreenDialog: true,
                                          ),
                                        );
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                      thickness: 0.6,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Color.fromARGB(255, 135, 135, 135),
                                    ),
                                    ListTile(
                                      title: Text(
                                        '運営に連絡/お問い合わせ',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      onTap: () async {
                                        final url = Uri.parse(
                                          'https://lin.ee/2xq2AZx',
                                        );
                                        if (await canLaunchUrl(url)) {
                                          launchUrl(url);
                                        } else {
                                          // ignore: avoid_print
                                          print("Can't launch $url");
                                        }
                                      },
                                    ),
                                    Divider(
                                      height: 10,
                                      thickness: 0.6,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Color.fromARGB(255, 135, 135, 135),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'ログアウトする',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: 100,
                                              child: SimpleDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    40))),
                                                title: Text("本当にログアウトしますか？"),
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              300.0),
                                                    ),
                                                    height: 100,
                                                    child: Column(
                                                      children: [
                                                        SimpleDialogOption(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Authentication
                                                                          .signOut();
                                                                      while (Navigator
                                                                          .canPop(
                                                                              context)) {
                                                                        Navigator.pop(
                                                                            context);
                                                                      }
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => FrontPage()));
                                                                    },
                                                                    child: Text(
                                                                        'ログアウトする'))),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    Column(
                                      children: [
                                        Divider(
                                          height: 10,
                                          thickness: 0.6,
                                          indent: 20,
                                          endIndent: 20,
                                          color: Color.fromARGB(
                                              255, 135, 135, 135),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'プライバシーポリシー',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          onTap: () async {
                                            final url = Uri.parse(
                                              'https://aware-trumpet-339.notion.site/olive-9484611a2ce44155af6c31584b4c2e3e',
                                            );
                                            if (await canLaunchUrl(url)) {
                                              launchUrl(url);
                                            } else {
                                              // ignore: avoid_print
                                              print("Can't launch $url");
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 10,
                                      thickness: 0.6,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Color.fromARGB(255, 135, 135, 135),
                                    ),
                                  ],
                                ),
                              ),
                              body: DefaultTabController(
                                  length: _tabs
                                      .length, // This is the number of tabs.
                                  child: NestedScrollView(
                                    headerSliverBuilder: (BuildContext context,
                                        bool innerBoxIsScrolled) {
                                      return <Widget>[
                                        SliverList(
                                          delegate: SliverChildListDelegate(
                                            [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: 0, left: 0, top: 20),
                                                height: 400,
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 17.0),
                                                          child: Text(
                                                            shopMyInfo
                                                                .shop_name,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            onTap: () => _scaffoldKey
                                                                .currentState!
                                                                .openEndDrawer(),
                                                            child: Container(
                                                              height: 40,
                                                              width: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            26,
                                                                            69,
                                                                            69,
                                                                            69), //色
                                                                    spreadRadius:
                                                                        3,
                                                                    blurRadius:
                                                                        3,
                                                                    offset:
                                                                        Offset(
                                                                            1,
                                                                            1),
                                                                  ),
                                                                ],
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        196,
                                                                        0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25.0),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  '店舗設定',
                                                                  style: TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Text('ユーザーからの見え方↓'),
                                                    Container(
                                                      height: 160,
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        child: Image.network(
                                                          shopMyInfo.image_path,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  final url =
                                                                      Uri.parse(
                                                                    shopMyInfo
                                                                        .instagram,
                                                                  );
                                                                  if (await canLaunchUrl(
                                                                      url)) {
                                                                    launchUrl(
                                                                        url);
                                                                  } else {
                                                                    // ignore: avoid_print
                                                                    print(
                                                                        "Can't launch $url");
                                                                  }
                                                                },
                                                                child: CircleAvatar(
                                                                    radius: 24,
                                                                    foregroundImage:
                                                                        NetworkImage(
                                                                            'https://pbs.twimg.com/profile_images/1132882384318152705/sJx01uiK_400x400.png')),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  final url =
                                                                      Uri.parse(
                                                                    shopMyInfo
                                                                        .googlemap,
                                                                  );
                                                                  if (await canLaunchUrl(
                                                                      url)) {
                                                                    launchUrl(
                                                                        url);
                                                                  } else {
                                                                    // ignore: avoid_print
                                                                    print(
                                                                        "Can't launch $url");
                                                                  }
                                                                },
                                                                child: CircleAvatar(
                                                                    radius: 24,
                                                                    foregroundImage:
                                                                        NetworkImage(
                                                                            'https://play-lh.googleusercontent.com/Kf8WTct65hFJxBUDm5E-EpYsiDoLQiGGbnuyP6HBNax43YShXti9THPon1YKB6zPYpA')),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              CircleAvatar(
                                                                  radius: 24,
                                                                  foregroundImage:
                                                                      NetworkImage(
                                                                          'https://pbs.twimg.com/profile_images/1132882384318152705/sJx01uiK_400x400.png')),
                                                            ],
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  String text =
                                                                      shopMyInfo
                                                                          .instagram;
                                                                  text = text
                                                                      .replaceAll(
                                                                          "https://www.instagram.com/",
                                                                          "");
                                                                  return SizedBox(
                                                                    height: 300,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          100,
                                                                      child:
                                                                          SimpleDialog(
                                                                        shape: const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(40))),
                                                                        title:
                                                                            Text(
                                                                          shopMyInfo
                                                                              .shop_name,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(300.0),
                                                                            ),
                                                                            height:
                                                                                170,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 23.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 3,
                                                                                        height: 20,
                                                                                        decoration: BoxDecoration(color: Colors.green),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      Text(
                                                                                        "あなたにやって欲しいこと",
                                                                                        textAlign: TextAlign.start,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 9,
                                                                                ),
                                                                                Container(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 23),
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Row(
                                                                                          children: [
                                                                                            Container(
                                                                                                width: 90,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color.fromARGB(255, 255, 216, 99),
                                                                                                  border: Border.all(width: 0.5, color: Color.fromARGB(255, 96, 96, 96)),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text('PR方法'),
                                                                                                )),
                                                                                            Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color.fromARGB(0, 145, 126, 70),
                                                                                                  border: Border(
                                                                                                    right: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    top: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    bottom: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                width: 170,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text(
                                                                                                    'ストーリーズ',
                                                                                                    style: TextStyle(color: Colors.black),
                                                                                                    textAlign: TextAlign.center,
                                                                                                  ),
                                                                                                )),
                                                                                          ],
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Container(
                                                                                                height: 50,
                                                                                                width: 90,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color.fromARGB(255, 255, 216, 99),
                                                                                                  border: Border(
                                                                                                    right: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    left: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text(
                                                                                                    'タグ付アカウント',
                                                                                                    style: TextStyle(fontSize: 12),
                                                                                                  ),
                                                                                                )),
                                                                                            Container(
                                                                                              height: 50,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Color.fromARGB(0, 145, 126, 70),
                                                                                                border: Border(
                                                                                                  right: BorderSide(
                                                                                                    color: Color.fromARGB(255, 96, 96, 96),
                                                                                                    width: 0.5,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              width: 170,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                child: Text(
                                                                                                  '@$text',
                                                                                                  style: TextStyle(color: Colors.black),
                                                                                                  textAlign: TextAlign.center,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Container(
                                                                                                width: 90,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color.fromARGB(255, 255, 216, 99),
                                                                                                  border: Border(
                                                                                                    right: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    left: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    top: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    bottom: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text('PR方法'),
                                                                                                )),
                                                                                            Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color.fromARGB(0, 145, 126, 70),
                                                                                                  border: Border(
                                                                                                    right: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    top: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    bottom: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                width: 170,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text(
                                                                                                    'ストーリーズ',
                                                                                                    style: TextStyle(color: Colors.black),
                                                                                                    textAlign: TextAlign.center,
                                                                                                  ),
                                                                                                )),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(300.0),
                                                                            ),
                                                                            height:
                                                                                500,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 23.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 3,
                                                                                        height: 20,
                                                                                        decoration: BoxDecoration(color: Colors.green),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      Text(
                                                                                        "サービス内容",
                                                                                        textAlign: TextAlign.start,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 9,
                                                                                ),
                                                                                Container(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 23),
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Row(
                                                                                          children: [
                                                                                            Container(
                                                                                                height: 40,
                                                                                                width: 90,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color.fromARGB(255, 255, 216, 99),
                                                                                                  border: Border.all(width: 0.5, color: Color.fromARGB(255, 96, 96, 96)),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text(
                                                                                                    'サービスの内容',
                                                                                                    style: TextStyle(fontSize: 10),
                                                                                                  ),
                                                                                                )),
                                                                                            Container(
                                                                                                height: 40,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color.fromARGB(0, 145, 126, 70),
                                                                                                  border: Border(
                                                                                                    right: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    top: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    bottom: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                width: 170,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text(
                                                                                                    shopMyInfo.service,
                                                                                                    style: TextStyle(color: Colors.black),
                                                                                                    textAlign: TextAlign.center,
                                                                                                  ),
                                                                                                )),
                                                                                          ],
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Container(
                                                                                                height: 50,
                                                                                                width: 90,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color.fromARGB(255, 255, 216, 99),
                                                                                                  border: Border(
                                                                                                    right: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    left: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text(
                                                                                                    '住所',
                                                                                                    style: TextStyle(fontSize: 12),
                                                                                                  ),
                                                                                                )),
                                                                                            Container(
                                                                                              height: 50,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Color.fromARGB(0, 145, 126, 70),
                                                                                                border: Border(
                                                                                                  right: BorderSide(
                                                                                                    color: Color.fromARGB(255, 96, 96, 96),
                                                                                                    width: 0.5,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              width: 170,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                child: Text(
                                                                                                  shopMyInfo.address,
                                                                                                  style: TextStyle(fontSize: 11, color: Colors.black),
                                                                                                  textAlign: TextAlign.center,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Container(
                                                                                                width: 90,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color.fromARGB(255, 255, 216, 99),
                                                                                                  border: Border(
                                                                                                    right: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    left: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    top: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    bottom: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text('PR方法'),
                                                                                                )),
                                                                                            Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color.fromARGB(0, 145, 126, 70),
                                                                                                  border: Border(
                                                                                                    right: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    top: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                    bottom: BorderSide(
                                                                                                      color: Color.fromARGB(255, 96, 96, 96),
                                                                                                      width: 0.5,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                width: 170,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text(
                                                                                                    'ストーリーズ',
                                                                                                    style: TextStyle(color: Colors.black),
                                                                                                    textAlign: TextAlign.center,
                                                                                                  ),
                                                                                                )),
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Container(
                                                                                              width: 3,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(color: Colors.green),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 5,
                                                                                            ),
                                                                                            Text(
                                                                                              "注意事項",
                                                                                              textAlign: TextAlign.start,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Column(
                                                                                          children: [
                                                                                            Container(
                                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.amber),
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(10.0),
                                                                                                child: Column(
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      children: [
                                                                                                        Text('※交通費は自己負担となります'),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      children: [
                                                                                                        Text('※お1人さま一回までとなります'),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Text('※投稿がお見受けできない場合凍結してしまう可能性がございます'),
                                                                                                    Row(
                                                                                                      children: [
                                                                                                        Text('※交通費は自己負担となります'),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height: 40,
                                                                width: 130,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          74,
                                                                          232,
                                                                          79),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    'このお店に行く',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                    '【営業時間】'),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                    '土日休み'),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                    '10:00~19:00'),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Container(
                                                            width: 270,
                                                            child: Text(
                                                              shopMyInfo
                                                                  .selfIntroduction,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SliverPersistentHeader(
                                          pinned: true,
                                          delegate: _StickyTabBarDelegate(
                                            TabBar(
                                              labelColor:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              labelStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                              ),
                                              indicatorColor: Color.fromARGB(
                                                  255, 98, 255, 59),
                                              tabs: <Widget>[
                                                Tab(
                                                  text: shopMyInfo
                                                      .menu_genre1![1],
                                                ),
                                                Tab(
                                                  text: shopMyInfo
                                                      .menu_genre2![1],
                                                ),
                                                Tab(
                                                  text: shopMyInfo
                                                      .menu_genre3![1],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ];
                                    },
                                    body: TabBarView(
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Expanded(
                                              child: StreamBuilder<
                                                      QuerySnapshot>(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('shops')
                                                      .doc(myAccount
                                                          .shop_account_id)
                                                      .collection('menu')
                                                      .snapshots(),

                                                  // .collection('my_user_post')
                                                  // .orderBy('created_time', descending: true)

                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return SizedBox();
                                                    }
                                                    List<String> shoplist =
                                                        List.generate(
                                                            snapshot.data!.docs
                                                                .length,
                                                            (index) {
                                                      return snapshot
                                                          .data!.docs[index].id;

                                                      //自分のmypostsのIDとpostsコレクションにある同じIDの投稿をとってくるために参照
                                                      //futureで情報を取る前にじぶんのIDと同じものを取るためにやらないといけない処理↑
                                                    });
                                                    return FutureBuilder<
                                                            List<Menu>?>(
                                                        future: ShopFirestore
                                                            .getShopMenu(
                                                                myAccount
                                                                    .shop_account_id,
                                                                1),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return SizedBox();
                                                          }
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 8.0,
                                                            ),
                                                            child: GridView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    primary:
                                                                        false,
                                                                    physics:
                                                                        NeverScrollableScrollPhysics(), //追加

                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                        childAspectRatio:
                                                                            3 /
                                                                                4,
                                                                        crossAxisCount:
                                                                            2),
                                                                    itemCount:
                                                                        snapshot
                                                                            .data!
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return SizedBox();
                                                                      }
                                                                      Menu
                                                                          shopAccount =
                                                                          snapshot
                                                                              .data![index];

                                                                      return Container(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(1),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return SimpleDialog(
                                                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                                                                                    children: [
                                                                                      Container(
                                                                                        height: 500,
                                                                                        child: Column(
                                                                                          children: [
                                                                                            Container(
                                                                                              height: 200,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(100),
                                                                                              ),
                                                                                              child: Container(
                                                                                                height: 220,
                                                                                                child: ClipRRect(
                                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
                                                                                                  child: Image(image: NetworkImage(shopAccount.image_path)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SimpleDialogOption(
                                                                                              onPressed: () => Navigator.pop(context),
                                                                                              child: Text(shopAccount.menu_name),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Color.fromARGB(26, 69, 69, 69), //色
                                                                                  spreadRadius: 3,
                                                                                  blurRadius: 3,
                                                                                  offset: Offset(1, 1),
                                                                                ),
                                                                              ], color: Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(10)),
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    height: 155,
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                      child: Image.network(
                                                                                        shopAccount.image_path,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: SizedBox(
                                                                                      width: double.infinity,
                                                                                      child: Text(
                                                                                        shopAccount.menu_name,
                                                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                                                                        textAlign: TextAlign.left,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(right: 10, bottom: 0),
                                                                                    child: Container(
                                                                                      alignment: Alignment.bottomRight,
                                                                                      width: double.infinity,
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                        children: [
                                                                                          Text(
                                                                                            shopAccount.price.toString(),
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                                                            textAlign: TextAlign.left,
                                                                                          ),
                                                                                          Text(
                                                                                            '円',
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                                                            textAlign: TextAlign.left,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(right: 10, bottom: 0),
                                                                                    child: Container(
                                                                                      alignment: Alignment.bottomRight,
                                                                                      width: double.infinity,
                                                                                      child: Text(
                                                                                        'オリジナルパスタ',
                                                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 1),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                          );
                                                        });
                                                  }),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: StreamBuilder<
                                                        QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('shops')
                                                        .doc(myAccount
                                                            .shop_account_id)
                                                        .collection('menu')
                                                        .snapshots(),

                                                    // .collection('my_user_post')
                                                    // .orderBy('created_time', descending: true)

                                                    builder:
                                                        (context, snapshot) {
                                                      if (!snapshot.hasData) {
                                                        return SizedBox();
                                                      }
                                                      List<String> shoplist =
                                                          List.generate(
                                                              snapshot.data!
                                                                  .docs.length,
                                                              (index) {
                                                        return snapshot.data!
                                                            .docs[index].id;

                                                        //自分のmypostsのIDとpostsコレクションにある同じIDの投稿をとってくるために参照
                                                        //futureで情報を取る前にじぶんのIDと同じものを取るためにやらないといけない処理↑
                                                      });
                                                      return FutureBuilder<
                                                              List<Menu>?>(
                                                          future: ShopFirestore
                                                              .getShopMenu(
                                                                  myAccount
                                                                      .shop_account_id,
                                                                  2),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (!snapshot
                                                                .hasData) {
                                                              return SizedBox();
                                                            }
                                                            return GridView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    primary:
                                                                        false,
                                                                    physics:
                                                                        NeverScrollableScrollPhysics(), //追加

                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                        childAspectRatio:
                                                                            3 /
                                                                                4,
                                                                        crossAxisCount:
                                                                            2),
                                                                    itemCount:
                                                                        snapshot
                                                                            .data!
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return SizedBox();
                                                                      }

                                                                      Menu
                                                                          shopAccount =
                                                                          snapshot
                                                                              .data![index];

                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return SimpleDialog(
                                                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                                                                                  title: Text(shopAccount.menu_name),
                                                                                  children: [
                                                                                    Container(
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(300.0),
                                                                                      ),
                                                                                      height: 500,
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Image(image: NetworkImage(shopAccount.image_path)),
                                                                                          SimpleDialogOption(
                                                                                            onPressed: () => Navigator.pop(context),
                                                                                            child: Text("サービス内容"),
                                                                                          ),
                                                                                          SimpleDialogOption(
                                                                                            onPressed: () => Navigator.pop(context),
                                                                                            child: Text(""),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            decoration:
                                                                                BoxDecoration(boxShadow: [
                                                                              BoxShadow(
                                                                                color: Color.fromARGB(26, 69, 69, 69), //色
                                                                                spreadRadius: 3,
                                                                                blurRadius: 3,
                                                                                offset: Offset(1, 1),
                                                                              ),
                                                                            ], color: Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(10)),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Container(
                                                                                  height: 130,
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                    child: Image.network(
                                                                                      shopAccount.image_path,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: SizedBox(
                                                                                    width: double.infinity,
                                                                                    child: Text(
                                                                                      shopAccount.menu_name,
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                                                                      textAlign: TextAlign.left,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(right: 10, bottom: 0),
                                                                                  child: Container(
                                                                                    alignment: Alignment.bottomRight,
                                                                                    width: double.infinity,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        Text(
                                                                                          shopAccount.price.toString(),
                                                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                                                          textAlign: TextAlign.left,
                                                                                        ),
                                                                                        Text(
                                                                                          '円',
                                                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                                                          textAlign: TextAlign.left,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(right: 10, bottom: 0),
                                                                                  child: Container(
                                                                                    alignment: Alignment.bottomRight,
                                                                                    width: double.infinity,
                                                                                    child: Text(
                                                                                      'オリジナルパスタ',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 1),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                          });
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: StreamBuilder<
                                                        QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('shops')
                                                        .doc(myAccount
                                                            .shop_account_id)
                                                        .collection('menu')
                                                        .snapshots(),
                                                    // .collection('my_user_post')
                                                    // .orderBy('created_time', descending: true)
                                                    builder:
                                                        (context, snapshot) {
                                                      if (!snapshot.hasData) {
                                                        return SizedBox();
                                                      }
                                                      List<String> shoplist =
                                                          List.generate(
                                                              snapshot.data!
                                                                  .docs.length,
                                                              (index) {
                                                        return snapshot.data!
                                                            .docs[index].id;
                                                      });
                                                      return FutureBuilder<
                                                              List<Menu>?>(
                                                          future: ShopFirestore
                                                              .getShopMenu(
                                                                  myAccount
                                                                      .shop_account_id,
                                                                  3),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (!snapshot
                                                                .hasData) {
                                                              return SizedBox();
                                                            }
                                                            return GridView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    primary:
                                                                        false,
                                                                    physics:
                                                                        NeverScrollableScrollPhysics(), //追加

                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                        childAspectRatio:
                                                                            3 /
                                                                                4,
                                                                        crossAxisCount:
                                                                            2),
                                                                    itemCount:
                                                                        snapshot
                                                                            .data!
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      Menu
                                                                          shopAccount =
                                                                          snapshot
                                                                              .data![index];
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return SimpleDialog(
                                                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                                                                                  title: Text(shopAccount.menu_name),
                                                                                  children: [
                                                                                    Container(
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(300.0),
                                                                                      ),
                                                                                      height: 500,
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Image(image: NetworkImage(shopAccount.image_path)),
                                                                                          SimpleDialogOption(
                                                                                            onPressed: () => Navigator.pop(context),
                                                                                            child: Text("サービス内容"),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            decoration:
                                                                                BoxDecoration(boxShadow: [
                                                                              BoxShadow(
                                                                                color: Color.fromARGB(26, 69, 69, 69), //色
                                                                                spreadRadius: 3,
                                                                                blurRadius: 3,
                                                                                offset: Offset(1, 1),
                                                                              ),
                                                                            ], color: Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(10)),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Container(
                                                                                  height: 130,
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                    child: Image.network(
                                                                                      shopAccount.image_path,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: SizedBox(
                                                                                    width: double.infinity,
                                                                                    child: Text(
                                                                                      shopAccount.menu_name,
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                                                                      textAlign: TextAlign.left,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(right: 10, bottom: 0),
                                                                                  child: Container(
                                                                                    alignment: Alignment.bottomRight,
                                                                                    width: double.infinity,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        Text(
                                                                                          shopAccount.price.toString(),
                                                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                                                          textAlign: TextAlign.left,
                                                                                        ),
                                                                                        Text(
                                                                                          '円',
                                                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                                                          textAlign: TextAlign.left,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(right: 10, bottom: 0),
                                                                                  child: Container(
                                                                                    alignment: Alignment.bottomRight,
                                                                                    width: double.infinity,
                                                                                    child: Text(
                                                                                      'オリジナルパスタ',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 1),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                          });
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        })
                    : Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-1.0, 0.0),
                            end: Alignment(1.0, 0.0),
                            colors: [
                              Color.fromARGB(255, 255, 255, 255),
                              Color.fromARGB(255, 255, 255, 255)
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
                            iconTheme:
                                IconThemeData(color: Colors.black, size: 35),
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                          ),
                          endDrawer: Drawer(
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  child: DrawerHeader(
                                    child: Text(
                                      '設定',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 183, 0),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    '貢献したお店',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VistShopPage(
                                          myInfo: myAccount,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 0.6,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Color.fromARGB(255, 135, 135, 135),
                                ),
                                ListTile(
                                  title: Text(
                                    'プロフィールを編集する',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditAccountPage(
                                          myaccount: myAccount,
                                        ),
                                        fullscreenDialog: true,
                                      ),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 0.6,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Color.fromARGB(255, 135, 135, 135),
                                ),
                                ListTile(
                                  title: Text(
                                    'お問い合わせ/相談',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  onTap: () async {
                                    final url = Uri.parse(
                                      'https://lin.ee/UFt1ube',
                                    );
                                    if (await canLaunchUrl(url)) {
                                      launchUrl(url);
                                    } else {
                                      // ignore: avoid_print
                                      print("Can't launch $url");
                                    }
                                  },
                                ),
                                Column(
                                  children: [
                                    Divider(
                                      height: 10,
                                      thickness: 0.6,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Color.fromARGB(255, 135, 135, 135),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'プライバシーポリシー',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      onTap: () async {
                                        final url = Uri.parse(
                                          'https://aware-trumpet-339.notion.site/olive-9484611a2ce44155af6c31584b4c2e3e',
                                        );
                                        if (await canLaunchUrl(url)) {
                                          launchUrl(url);
                                        } else {
                                          // ignore: avoid_print
                                          print("Can't launch $url");
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 0.6,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Color.fromARGB(255, 135, 135, 135),
                                ),
                                ListTile(
                                  title: Text(
                                    'ログアウトする',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 100,
                                          child: SimpleDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40))),
                                            title: Text("本当にログアウトしますか？"),
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          300.0),
                                                ),
                                                height: 100,
                                                child: Column(
                                                  children: [
                                                    SimpleDialogOption(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              Authentication
                                                                  .signOut();
                                                              while (Navigator
                                                                  .canPop(
                                                                      context)) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                              Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              FrontPage()));
                                                            },
                                                            child: Text(
                                                                'ログアウトする'))),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 0.6,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Color.fromARGB(255, 135, 135, 135),
                                ),
                              ],
                            ),
                          ),
                          body: Container(
                            height: 600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: const AssetImage(
                                                                'images/olive.png'),
                                                            fit: BoxFit.contain,
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
                                                                      214,
                                                                      59,
                                                                      181),
                                                              offset:
                                                                  Offset(0, 1),
                                                              blurRadius: 13,
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
                                                              begin: Alignment(
                                                                  -1.0, 0.0),
                                                              end: Alignment(
                                                                  1.0, 0.0),
                                                              colors: [
                                                                Color.fromARGB(
                                                                    208,
                                                                    245,
                                                                    136,
                                                                    255),
                                                                Color.fromARGB(
                                                                    255,
                                                                    237,
                                                                    100,
                                                                    255)
                                                              ],
                                                              stops: [0.0, 1.0],
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            EditAccountPage(
                                                                      myaccount:
                                                                          myAccount,
                                                                    ),
                                                                    fullscreenDialog:
                                                                        true,
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    image: NetworkImage(
                                                                        myAccount
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      0),
                                                          child: Text(
                                                            myAccount.name,
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
                                                        myAccount.instagram
                                                                    .length ==
                                                                0
                                                            ? SizedBox()
                                                            : InkWell(
                                                                onTap:
                                                                    () async {
                                                                  final url =
                                                                      Uri.parse(
                                                                    myAccount
                                                                        .instagram,
                                                                  );
                                                                  if (await canLaunchUrl(
                                                                      url)) {
                                                                    launchUrl(
                                                                        url);
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
                                                      ],
                                                    ),
                                                    Container(
                                                      width: 200,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                shape:
                                                                    StadiumBorder(),
                                                                side:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          0,
                                                                          0,
                                                                          107,
                                                                          195),
                                                                  width: 2,
                                                                ),
                                                                primary: Color
                                                                    .fromARGB(
                                                                        0,
                                                                        255,
                                                                        193,
                                                                        7)),
                                                        onPressed: () async {
                                                          var result =
                                                              await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            EditAccountPage(
                                                                      myaccount:
                                                                          myAccount,
                                                                    ),
                                                                    fullscreenDialog:
                                                                        true,
                                                                  ));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Text(
                                                            'プロフィール編集',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 25),
                                            StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (myAccount
                                                          .like_shop.length <
                                                      5) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              bottom: 20),
                                                      child: InkWell(
                                                        onTap: () {},
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: 190,
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            26,
                                                                            69,
                                                                            69,
                                                                            69), //色
                                                                    spreadRadius:
                                                                        3,
                                                                    blurRadius:
                                                                        3,
                                                                    offset:
                                                                        Offset(
                                                                            1,
                                                                            1),
                                                                  ),
                                                                ],
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        226,
                                                                        36),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25.0),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        13.0),
                                                                child: Text(
                                                                  '好きなお店を選ぼう',
                                                                  style: TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                  return FutureBuilder<Shop?>(
                                                      future:
                                                          ShopFirestore.getShop(
                                                              myAccount
                                                                  .like_shop),
                                                      builder:
                                                          (context, snapshot) {
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
                                                                      width: 50,
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
                                                                                50,
                                                                            height:
                                                                                50,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image: NetworkImage(likeShopInfo.image_path),
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
                                                                Text(
                                                                    likeShopInfo
                                                                        .shop_name,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            FutureBuilder<
                                                                    Category?>(
                                                                future: CategoryFirestore
                                                                    .getCategorie(
                                                                        myAccount
                                                                            .like_genre),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return SizedBox();
                                                                  }
                                                                  Category
                                                                      categoryInfo =
                                                                      snapshot
                                                                          .data!;
                                                                  return Column(
                                                                    children: [
                                                                      Container(
                                                                          height:
                                                                              105,
                                                                          width:
                                                                              120,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(
                                                                              image: const AssetImage('images/olive.png'),
                                                                              fit: BoxFit.contain,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(25.0),
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Color.fromARGB(255, 255, 217, 0),
                                                                                offset: Offset(0, 1),
                                                                                blurRadius: 13,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                60,
                                                                            height:
                                                                                50,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              gradient: LinearGradient(
                                                                                begin: Alignment(-1.0, 0.0),
                                                                                end: Alignment(1.0, 0.0),
                                                                                colors: [
                                                                                  Color.fromARGB(208, 255, 238, 0),
                                                                                  Color.fromARGB(255, 255, 193, 8)
                                                                                ],
                                                                                stops: [
                                                                                  0.0,
                                                                                  1.0
                                                                                ],
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(30),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(3.0),
                                                                              child: InkWell(
                                                                                onTap: () {
                                                                                  Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) => EditLikeShop(
                                                                                        myaccount: myAccount,
                                                                                      ),
                                                                                      fullscreenDialog: true,
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                  width: 60,
                                                                                  height: 50,
                                                                                  decoration: BoxDecoration(
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
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          '好きなジャンル',
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold))
                                                                    ],
                                                                  );
                                                                }),
                                                          ],
                                                        );
                                                      });
                                                }),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 30,
                                                  right: 10,
                                                  bottom: 40),
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    const Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                    ),
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            myAccount.universal
                                                                        .length >
                                                                    1
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 0),
                                                                    child:
                                                                        Container(
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 25),
                                                                              child: Text(
                                                                                '大学',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'YuGothic',
                                                                                  fontSize: 15,
                                                                                  color: const Color(0xff171616),
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                                softWrap: false,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 50),
                                                                              child: Text(
                                                                                '${myAccount.universal}大学',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'YuGothic',
                                                                                  fontSize: 15,
                                                                                  color: const Color(0xff171616),
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                                softWrap: false,
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                            myAccount.highschool
                                                                        .length >
                                                                    1
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            4),
                                                                    child:
                                                                        Container(
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 25),
                                                                              child: Text(
                                                                                '高校',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'YuGothic',
                                                                                  fontSize: 15,
                                                                                  color: const Color(0xff171616),
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                                softWrap: false,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 50),
                                                                              child: Text(
                                                                                '${myAccount.highschool}高校',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'YuGothic',
                                                                                  fontSize: 15,
                                                                                  color: const Color(0xff171616),
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                                softWrap: false,
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                            myAccount.junior_high_school
                                                                        .length >
                                                                    1
                                                                ? Container(
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 25),
                                                                            child:
                                                                                Text(
                                                                              '中学',
                                                                              style: TextStyle(
                                                                                fontFamily: 'YuGothic',
                                                                                fontSize: 15,
                                                                                color: const Color(0xff171616),
                                                                                fontWeight: FontWeight.w700,
                                                                              ),
                                                                              softWrap: false,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 50),
                                                                            child:
                                                                                Text(
                                                                              '${myAccount.junior_high_school}中学',
                                                                              style: TextStyle(
                                                                                fontFamily: 'YuGothic',
                                                                                fontSize: 15,
                                                                                color: const Color(0xff171616),
                                                                                fontWeight: FontWeight.w700,
                                                                              ),
                                                                              softWrap: false,
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                  )
                                                                : Container(),
                                                            myAccount.sanukiben
                                                                        .length >
                                                                    1
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 0),
                                                                    child:
                                                                        Container(
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 25),
                                                                              child: Text(
                                                                                '好きな讃岐弁',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'YuGothic',
                                                                                  fontSize: 15,
                                                                                  color: const Color(0xff171616),
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                                softWrap: false,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 50),
                                                                              child: Text(
                                                                                '${myAccount.sanukiben}',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'YuGothic',
                                                                                  fontSize: 15,
                                                                                  color: const Color(0xff171616),
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                                softWrap: false,
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                            myAccount.kagawareki
                                                                        .length >
                                                                    1
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            4),
                                                                    child:
                                                                        Container(
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 25),
                                                                              child: Text(
                                                                                '香川歴',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'YuGothic',
                                                                                  fontSize: 15,
                                                                                  color: const Color(0xff171616),
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                                softWrap: false,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 50),
                                                                              child: Text(
                                                                                '${myAccount.kagawareki}',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'YuGothic',
                                                                                  fontSize: 15,
                                                                                  color: const Color(0xff171616),
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                                softWrap: false,
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                            myAccount.zokusei
                                                                        .length >
                                                                    1
                                                                ? Container(
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 25),
                                                                            child:
                                                                                Text(
                                                                              '属性',
                                                                              style: TextStyle(
                                                                                fontFamily: 'YuGothic',
                                                                                fontSize: 15,
                                                                                color: const Color(0xff171616),
                                                                                fontWeight: FontWeight.w700,
                                                                              ),
                                                                              softWrap: false,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 50),
                                                                            child:
                                                                                Text(
                                                                              '${myAccount.zokusei}',
                                                                              style: TextStyle(
                                                                                fontFamily: 'YuGothic',
                                                                                fontSize: 15,
                                                                                color: const Color(0xff171616),
                                                                                fontWeight: FontWeight.w700,
                                                                              ),
                                                                              softWrap: false,
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                  )
                                                                : Container(),
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment(
                                                              -1.0, 0.0),
                                                          end: Alignment(
                                                              1.0, 0.0),
                                                          colors: [
                                                            Color.fromARGB(208,
                                                                136, 255, 96),
                                                            Color.fromARGB(255,
                                                                239, 255, 117)
                                                          ],
                                                          stops: [0.0, 1.0],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(51.0),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    154,
                                                                    215,
                                                                    231,
                                                                    42),
                                                            offset:
                                                                Offset(6, 3),
                                                            blurRadius: 33,
                                                          ),
                                                        ],
                                                      ),
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
                      );
              });
        });
  }
}
