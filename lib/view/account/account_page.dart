import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/model/menu.dart';
import 'package:fluttertwitter/model/shop.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/posts.dart';
import 'package:fluttertwitter/utils/firestore/shops.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/view/account/edit_account_page.dart';
import 'package:fluttertwitter/view/start_up/login_page.dart';
import 'package:fluttertwitter/view/time_line/front_page.dart';
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
  String _city = '';
  // final myAccount = Authentication.myAccount!;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Account?>(
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

          return myAccount.is_shop
              ? FutureBuilder<Shop?>(
                  future: ShopFirestore.getShop(myAccount.shop_account_id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    }
                    Shop shopMyInfo = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Scaffold(
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
                                    color: Color.fromARGB(255, 255, 183, 0),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  '注意事項',
                                  style: TextStyle(fontSize: 17),
                                ),
                                onTap: () {
                                  setState(() => _city = 'Dallas, TX');
                                  Navigator.pop(context);
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
                                      builder: (context) => EditAccountPage(),
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
                                  'お問い合せ',
                                  style: TextStyle(fontSize: 17),
                                ),
                                onTap: () {
                                  setState(() => _city = 'お問合せ');
                                  Navigator.pop(context);
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
                                                          child:
                                                              Text('ログアウトする'))),
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
                        body: DefaultTabController(
                            length: _tabs.length, // This is the number of tabs.
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
                                              Container(
                                                height: 220,
                                                width: double.infinity,
                                                alignment: Alignment.topCenter,
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
                                                    shopMyInfo.image_path,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                          onTap: () async {
                                                            final url =
                                                                Uri.parse(
                                                              shopMyInfo
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
                                                              radius: 24,
                                                              foregroundImage:
                                                                  NetworkImage(
                                                                      'https://pbs.twimg.com/profile_images/1132882384318152705/sJx01uiK_400x400.png')),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            final url =
                                                                Uri.parse(
                                                              shopMyInfo
                                                                  .googlemap,
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
                                                          context: context,
                                                          builder: (context) {
                                                            String text =
                                                                shopMyInfo
                                                                    .instagram;
                                                            text = text.replaceAll(
                                                                "https://www.instagram.com/",
                                                                "");
                                                            return SizedBox(
                                                              height: 300,
                                                              child: Container(
                                                                height: 100,
                                                                child:
                                                                    SimpleDialog(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(40))),
                                                                  title: Text(
                                                                    shopMyInfo
                                                                        .shop_name,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(300.0),
                                                                      ),
                                                                      height:
                                                                          170,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 23.0),
                                                                            child:
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
                                                                                  "あなたにやって欲しいこと",
                                                                                  textAlign: TextAlign.start,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                9,
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Padding(
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
                                                                        borderRadius:
                                                                            BorderRadius.circular(300.0),
                                                                      ),
                                                                      height:
                                                                          500,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 23.0),
                                                                            child:
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
                                                                                  "サービス内容",
                                                                                  textAlign: TextAlign.start,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                9,
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Padding(
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
                                                            color:
                                                                Color.fromARGB(
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
                                                                    .all(8.0),
                                                            child: Text(
                                                              'このお店に行く',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
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
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          child: Text('【営業時間】'),
                                                        ),
                                                        Container(
                                                          child: Text('土日休み'),
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
                                                            color:
                                                                Colors.black),
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
                                        indicatorColor:
                                            Color.fromARGB(255, 98, 255, 59),
                                        tabs: <Widget>[
                                          Tab(
                                            text: shopMyInfo.menu_genre1![1],
                                          ),
                                          Tab(
                                            text: shopMyInfo.menu_genre2![1],
                                          ),
                                          Tab(
                                            text: shopMyInfo.menu_genre3![1],
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
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('shops')
                                                .doc(myAccount.shop_account_id)
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
                                                          .length, (index) {
                                                return snapshot
                                                    .data!.docs[index].id;

                                                //自分のmypostsのIDとpostsコレクションにある同じIDの投稿をとってくるために参照
                                                //futureで情報を取る前にじぶんのIDと同じものを取るためにやらないといけない処理↑
                                              });
                                              return FutureBuilder<List<Menu>?>(
                                                  future:
                                                      ShopFirestore.getShopMenu(
                                                          myAccount
                                                              .shop_account_id,
                                                          1),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return SizedBox();
                                                    }
                                                    return GridView.builder(
                                                        shrinkWrap: true,
                                                        primary: false,
                                                        physics:
                                                            NeverScrollableScrollPhysics(), //追加

                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                childAspectRatio: 3 /
                                                                    4,
                                                                crossAxisCount:
                                                                    2),
                                                        itemCount: snapshot
                                                            .data!.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return SizedBox();
                                                          }
                                                          Menu shopAccount =
                                                              snapshot
                                                                  .data![index];

                                                          return Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return SimpleDialog(
                                                                        shape: const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(40))),
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                500,
                                                                            child:
                                                                                Column(
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
                                                                  width: double
                                                                      .infinity,
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Color.fromARGB(
                                                                              26,
                                                                              69,
                                                                              69,
                                                                              69), //色
                                                                          spreadRadius:
                                                                              3,
                                                                          blurRadius:
                                                                              3,
                                                                          offset: Offset(
                                                                              1,
                                                                              1),
                                                                        ),
                                                                      ],
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            130,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10)),
                                                                          child:
                                                                              Image.network(
                                                                            shopAccount.image_path,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Text(
                                                                            shopAccount.menu_name,
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                10,
                                                                            bottom:
                                                                                0),
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.bottomRight,
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
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
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                10,
                                                                            bottom:
                                                                                0),
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.bottomRight,
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Text(
                                                                            'オリジナルパスタ',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 1),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
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
                                  Container(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('shops')
                                                  .doc(
                                                      myAccount.shop_account_id)
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
                                                            .length, (index) {
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
                                                            2),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (!snapshot.hasData) {
                                                        return SizedBox();
                                                      }
                                                      return GridView.builder(
                                                          shrinkWrap: true,
                                                          primary: false,
                                                          physics:
                                                              NeverScrollableScrollPhysics(), //追加

                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                                  childAspectRatio:
                                                                      3 / 4,
                                                                  crossAxisCount:
                                                                      2),
                                                          itemCount: snapshot
                                                              .data!.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            if (!snapshot
                                                                .hasData) {
                                                              return SizedBox();
                                                            }

                                                            Menu shopAccount =
                                                                snapshot.data![
                                                                    index];

                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return SimpleDialog(
                                                                        shape: const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(40))),
                                                                        title: Text(
                                                                            shopAccount.menu_name),
                                                                        children: [
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
                                                                  width: double
                                                                      .infinity,
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Color.fromARGB(
                                                                              26,
                                                                              69,
                                                                              69,
                                                                              69), //色
                                                                          spreadRadius:
                                                                              3,
                                                                          blurRadius:
                                                                              3,
                                                                          offset: Offset(
                                                                              1,
                                                                              1),
                                                                        ),
                                                                      ],
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            130,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10)),
                                                                          child:
                                                                              Image.network(
                                                                            shopAccount.image_path,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Text(
                                                                            shopAccount.menu_name,
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                10,
                                                                            bottom:
                                                                                0),
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.bottomRight,
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
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
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                10,
                                                                            bottom:
                                                                                0),
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.bottomRight,
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Text(
                                                                            'オリジナルパスタ',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 1),
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
                                          child: StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('shops')
                                                  .doc(
                                                      myAccount.shop_account_id)
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
                                                            .length, (index) {
                                                  return snapshot
                                                      .data!.docs[index].id;
                                                });
                                                return FutureBuilder<
                                                        List<Menu>?>(
                                                    future: ShopFirestore
                                                        .getShopMenu(
                                                            myAccount
                                                                .shop_account_id,
                                                            3),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (!snapshot.hasData) {
                                                        return SizedBox();
                                                      }
                                                      return GridView.builder(
                                                          shrinkWrap: true,
                                                          primary: false,
                                                          physics:
                                                              NeverScrollableScrollPhysics(), //追加

                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                                  childAspectRatio:
                                                                      3 / 4,
                                                                  crossAxisCount:
                                                                      2),
                                                          itemCount: snapshot
                                                              .data!.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            Menu shopAccount =
                                                                snapshot.data![
                                                                    index];
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return SimpleDialog(
                                                                        shape: const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(40))),
                                                                        title: Text(
                                                                            shopAccount.menu_name),
                                                                        children: [
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
                                                                  width: double
                                                                      .infinity,
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Color.fromARGB(
                                                                              26,
                                                                              69,
                                                                              69,
                                                                              69), //色
                                                                          spreadRadius:
                                                                              3,
                                                                          blurRadius:
                                                                              3,
                                                                          offset: Offset(
                                                                              1,
                                                                              1),
                                                                        ),
                                                                      ],
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            130,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10)),
                                                                          child:
                                                                              Image.network(
                                                                            shopAccount.image_path,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Text(
                                                                            shopAccount.menu_name,
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                10,
                                                                            bottom:
                                                                                0),
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.bottomRight,
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
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
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                10,
                                                                            bottom:
                                                                                0),
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.bottomRight,
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Text(
                                                                            'オリジナルパスタ',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 1),
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
                                color: Color.fromARGB(255, 255, 183, 0),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '注意事項',
                              style: TextStyle(fontSize: 17),
                            ),
                            onTap: () {
                              setState(() => _city = 'Dallas, TX');
                              Navigator.pop(context);
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
                                  builder: (context) => EditAccountPage(),
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
                              'お問い合せ',
                              style: TextStyle(fontSize: 17),
                            ),
                            onTap: () {
                              setState(() => _city = 'お問合せ');
                              Navigator.pop(context);
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
                                                BorderRadius.circular(300.0),
                                          ),
                                          height: 100,
                                          child: Column(
                                            children: [
                                              SimpleDialogOption(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Authentication
                                                            .signOut();
                                                        while (Navigator.canPop(
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
                                                      child: Text('ログアウトする'))),
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
                    body: SingleChildScrollView(
                      child: Container(
                        height: 700,
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
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditAccountPage(),
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
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 0),
                                                      child: Text(
                                                        myAccount.name,
                                                        style: TextStyle(
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Container(
                                                //   height: 70,
                                                //   width: 210,
                                                //   decoration: BoxDecoration(
                                                //     color: const Color(0xffffffff),
                                                //     borderRadius:
                                                //         BorderRadius.circular(35.0),
                                                //   ),
                                                //   child: Padding(
                                                //     padding: const EdgeInsets.all(14.0),
                                                //     child: Row(
                                                //       children: [
                                                //         Text(
                                                //           'instaの\nフォロワー数',
                                                //           style: TextStyle(
                                                //             fontFamily: 'YuGothic',
                                                //             fontSize: 17,
                                                //             color: const Color(0xff171616),
                                                //             fontWeight: FontWeight.w700,
                                                //             height: 1.3529411764705883,
                                                //           ),
                                                //           textHeightBehavior:
                                                //               TextHeightBehavior(
                                                //                   applyHeightToFirstAscent:
                                                //                       false),
                                                //           softWrap: false,
                                                //         ),
                                                //         Padding(
                                                //           padding: const EdgeInsets.only(
                                                //               left: 10),
                                                //           child: Text(
                                                //             '3161',
                                                //             style: TextStyle(
                                                //               fontFamily: 'Apple Braille',
                                                //               fontSize: 33,
                                                //               color:
                                                //                   const Color(0xffc4e4b3),
                                                //               letterSpacing: -0.722,
                                                //               height: 0.42105263157894735,
                                                //               shadows: [
                                                //                 Shadow(
                                                //                   color: Color.fromARGB(
                                                //                       255, 237, 255, 146),
                                                //                   offset: Offset(0, 3),
                                                //                   blurRadius: 11,
                                                //                 )
                                                //               ],
                                                //             ),
                                                //             textHeightBehavior:
                                                //                 TextHeightBehavior(
                                                //                     applyHeightToFirstAscent:
                                                //                         false),
                                                //             softWrap: false,
                                                //           ),
                                                //         )
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),
                                                Container(
                                                  width: 200,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            shape:
                                                                StadiumBorder(),
                                                            side: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      0,
                                                                      0,
                                                                      107,
                                                                      195),
                                                              width: 2,
                                                            ),
                                                            primary:
                                                                Color.fromARGB(
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
                                                                        EditAccountPage(),
                                                                fullscreenDialog:
                                                                    true,
                                                              ));
                                                      // if (result) {
                                                      //   setState(() {
                                                      //     myAccount = Authentication
                                                      //         .myAccount!;
                                                      //   });
                                                      // }
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
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
                                        SizedBox(height: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(left: 20),
                                            //   child: Row(
                                            //     children: [
                                            //       Container(
                                            //         alignment: Alignment.bottomRight,
                                            //         child: Padding(
                                            //           padding: const EdgeInsets.all(18.0),
                                            //           child: Text(
                                            //             '23',
                                            //             style: TextStyle(
                                            //               fontFamily: 'Apple Braille',
                                            //               fontSize: 44,
                                            //               color: const Color(0xffffffff),
                                            //               height: 0.36363636363636365,
                                            //               shadows: [
                                            //                 Shadow(
                                            //                   color:
                                            //                       const Color(0xe3ffffff),
                                            //                   offset: Offset(0, 3),
                                            //                   blurRadius: 11,
                                            //                 )
                                            //               ],
                                            //             ),
                                            //             textHeightBehavior:
                                            //                 TextHeightBehavior(
                                            //                     applyHeightToFirstAscent:
                                            //                         false),
                                            //             softWrap: false,
                                            //           ),
                                            //         ),
                                            //         height: 120,
                                            //         width: 130,
                                            //         decoration: BoxDecoration(
                                            //           gradient: LinearGradient(
                                            //             begin: Alignment(0.0, -1.0),
                                            //             end: Alignment(0.0, 1.0),
                                            //             colors: [
                                            //               Color.fromARGB(
                                            //                   204, 191, 113, 255),
                                            //               Color.fromARGB(209, 253, 27, 193)
                                            //             ],
                                            //             stops: [0.0, 1.0],
                                            //           ),
                                            //           borderRadius:
                                            //               BorderRadius.circular(28.0),
                                            //           boxShadow: [
                                            //             BoxShadow(
                                            //               color: const Color(0xffc262cd),
                                            //               offset: Offset(0, 3),
                                            //               blurRadius: 17,
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //       Padding(
                                            //         padding:
                                            //             const EdgeInsets.only(left: 20),
                                            //         child: Container(
                                            //           alignment: Alignment.bottomRight,
                                            //           child: Padding(
                                            //             padding: const EdgeInsets.all(18.0),
                                            //             child: Text(
                                            //               '42',
                                            //               style: TextStyle(
                                            //                 fontFamily: 'Apple Braille',
                                            //                 fontSize: 47,
                                            //                 color: const Color(0xffffffff),
                                            //                 height: 0.3617021276595745,
                                            //                 shadows: [
                                            //                   Shadow(
                                            //                     color:
                                            //                         const Color(0xe3ffffff),
                                            //                     offset: Offset(0, 3),
                                            //                     blurRadius: 11,
                                            //                   )
                                            //                 ],
                                            //               ),
                                            //               textHeightBehavior:
                                            //                   TextHeightBehavior(
                                            //                       applyHeightToFirstAscent:
                                            //                           false),
                                            //               softWrap: false,
                                            //             ),
                                            //           ),
                                            //           height: 120,
                                            //           width: 130,
                                            //           decoration: BoxDecoration(
                                            //             gradient: LinearGradient(
                                            //               begin: Alignment(0.0, -1.0),
                                            //               end: Alignment(0.0, 1.0),
                                            //               colors: [
                                            //                 Color.fromARGB(
                                            //                     255, 0, 237, 254),
                                            //                 Color.fromARGB(
                                            //                     255, 93, 161, 255)
                                            //               ],
                                            //               stops: [0.0, 1.0],
                                            //             ),
                                            //             borderRadius:
                                            //                 BorderRadius.circular(28.0),
                                            //             boxShadow: [
                                            //               BoxShadow(
                                            //                 color: const Color(0xff1bb5fc),
                                            //                 offset: Offset(0, 3),
                                            //                 blurRadius: 14,
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //       )
                                            //     ],
                                            //   ),
                                            // )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 30, right: 10),
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
                                                                        '${myAccount.universal}大学',
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
                                                                        '${myAccount.highschool}高校',
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
                                                                      '${myAccount.junior_high_school}中学',
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
                                                                        '${myAccount.sanukiben}',
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
                                                                        '${myAccount.kagawareki}',
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
                                                                      '${myAccount.zokusei}',
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
                                                                        '${myAccount.likemovie}',
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
                                                                        '${myAccount.likefood}',
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
                                                                      '${myAccount.hobby}',
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
                                // SizedBox(
                                //   height: 40,
                                // ),
                                // Container(
                                //   alignment: Alignment.center,
                                //   width: double.infinity,
                                //   decoration: BoxDecoration(
                                //       border: Border(
                                //           bottom: BorderSide(
                                //               color: Color.fromARGB(255, 114, 114, 114),
                                //               width: 3))),
                                //   child: Text('投稿',
                                //       style: TextStyle(
                                //           color: Color.fromARGB(255, 95, 95, 95),
                                //           fontSize: 15,
                                //           fontWeight: FontWeight.bold)),
                                // ),
                                // Expanded(
                                //     child: Container(
                                //   height: 500,
                                //   child: StreamBuilder<QuerySnapshot>(
                                //       stream: UserFirestore
                                //           .users //タイムラインなどのすぐ変わるページの時に使う→stream値が変わるとbuilderが発火する
                                //           .doc(myAccount.id)
                                //           .collection('my_posts')
                                //           .orderBy('created_time', descending: true)
                                //           .snapshots(),
                                //       builder: (context, snapshot) {
                                //         if (snapshot.hasData) {
                                //           List<String> myPostIds = List.generate(
                                //               snapshot.data!.docs.length, (index) {
                                //             return snapshot.data!.docs[index].id;
                                //           });
                                //           return FutureBuilder<List<Post>?>(
                                //               //一回だけ取ってくる→アカウントページなどのあまり変わらないページの時に使う
                                //               future: PostFirestore()
                                //                   .getPostsFromIds(myPostIds),
                                //               builder: (context, snapshot) {
                                //                 if (snapshot.hasData) {
                                //                   return ListView.builder(
                                //                     physics: NeverScrollableScrollPhysics(),
                                //                     itemCount: snapshot.data!.length,
                                //                     itemBuilder: (context, index) {
                                //                       Post post = snapshot.data![index];
                                //                       return Container(
                                //                         decoration: BoxDecoration(
                                //                             border: index == 0
                                //                                 ? Border(
                                //                                     top: BorderSide(
                                //                                         color: Colors.grey,
                                //                                         width: 0),
                                //                                     bottom: BorderSide(
                                //                                         color: Colors.grey,
                                //                                         width: 0))
                                //                                 : Border(
                                //                                     bottom: BorderSide(
                                //                                         color: Colors.grey,
                                //                                         width: 0),
                                //                                   )),
                                //                         padding: EdgeInsets.symmetric(
                                //                             horizontal: 10, vertical: 15),
                                //                         child: Row(
                                //                           children: [
                                //                             CircleAvatar(
                                //                               radius: 22,
                                //                               foregroundImage: NetworkImage(
                                //                                   myAccount.imagePath),
                                //                             ),
                                //                             Expanded(
                                //                               child: Padding(
                                //                                 padding: const EdgeInsets
                                //                                         .symmetric(
                                //                                     horizontal: 11),
                                //                                 child: Container(
                                //                                   child: Column(
                                //                                     crossAxisAlignment:
                                //                                         CrossAxisAlignment
                                //                                             .start,
                                //                                     children: [
                                //                                       Row(
                                //                                         mainAxisAlignment:
                                //                                             MainAxisAlignment
                                //                                                 .spaceBetween,
                                //                                         children: [
                                //                                           Row(
                                //                                             children: [
                                //                                               Text(
                                //                                                 myAccount
                                //                                                     .name,
                                //                                                 style: TextStyle(
                                //                                                     fontWeight:
                                //                                                         FontWeight.bold),
                                //                                               ),
                                //                                               Text(
                                //                                                 '@${myAccount.userId}',
                                //                                                 style: TextStyle(
                                //                                                     color: Colors
                                //                                                         .grey),
                                //                                               ),
                                //                                             ],
                                //                                           ),
                                //                                           Text(DateFormat(
                                //                                                   'M/d/yy')
                                //                                               .format(post
                                //                                                   .createdTime!
                                //                                                   .toDate()))
                                //                                         ],
                                //                                       ),
                                //                                       Text(post.content)
                                //                                     ],
                                //                                   ),
                                //                                 ),
                                //                               ),
                                //                             )
                                //                           ],
                                //                         ),
                                //                       );
                                //                     },
                                //                   );
                                //                 } else {
                                //                   return Container();
                                //                 }
                                //               });
                                //         } else {
                                //           return Container();
                                //         }
                                //       }),
                                // )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        });
  }
}
