import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/view/account/account_page.dart';
import 'package:fluttertwitter/view/time_line/front_page.dart';
import 'package:fluttertwitter/view/time_line/notification.dart';
import 'package:fluttertwitter/view/time_line/post_page.dart';
import 'package:fluttertwitter/view/time_line/search_page.dart';
import 'package:fluttertwitter/view/time_line/shop_page.dart';
import 'package:fluttertwitter/view/time_line/time_line_page.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';

class Screen extends StatefulWidget {
  final int num;
  const Screen({Key? key, required this.num}) : super(key: key);

  @override
  //元々の機能に上書き
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const SizedBox();
    }
    return FutureBuilder<Account?>(
        future: UserFirestore.getUserInfo(user.uid),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return FrontPage();
          }
          final account = snapshot.data;
          if (account == null) {
            return FrontPage();
          }
          return Scaffold(
            body: [
              TimeLinePage(),
              account.is_shop ? NotificationPage() : SearchPage(),
              AccountPage(),
            ][selectedIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15,
                    offset: Offset(0, 0.6))
              ]),
              child: SizedBox(
                height: 93,
                child: BottomNavigationBar(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255), //色の指定
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: 'ホーム'),
                    account.is_shop
                        ? BottomNavigationBarItem(
                            icon: Icon(Icons.notification_add), label: '通知')
                        : BottomNavigationBarItem(
                            icon: Icon(Icons.search), label: '探す'),
                    account.is_shop
                        ? BottomNavigationBarItem(
                            icon: Icon(Icons.people),
                            label: "ショップ",
                          )
                        : BottomNavigationBarItem(
                            icon: Icon(Icons.people),
                            label: 'プロフィール',
                          ),
                  ],
                  selectedItemColor: Colors.black,
                  currentIndex: selectedIndex,
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                      UserFirestore.existsUser(user.uid);
                    });
                  },
                ),
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: Color.fromARGB(255, 71, 240, 158),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => PostPage()),
            //     );
            //   },
            //   child: Icon(
            //     Icons.chat_bubble_outline,
            //     color: Color.fromARGB(255, 57, 151, 106),
            //   ),
            // ),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.endDocked,
            // floatingActionButton: Padding(
            //   padding: const EdgeInsets.only(right: 15, top: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       Container(
            //         height: 90,
            //         width: 90,
            //         child: FloatingActionButton(
            //           shape: CircleBorder(
            //             side: BorderSide(
            //               color: Color.fromARGB(0, 244, 67, 54), //枠線の色
            //             ),
            //           ),
            //           child: CircleAvatar(
            //             radius: 50,
            //             backgroundImage: NetworkImage(myaccountinfo.imagePath),
            //           ),
            //           onPressed: () {
            //             Navigator.pushReplacement(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => Screen(
            //                         myaccount: widget.myaccount,
            //                         num: 2,
            //                       )),
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          );
        });
  }
}
