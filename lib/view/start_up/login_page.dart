import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/model/account.dart';
// import 'package:fluttertwitter/utils/auth_manager.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/view/main_page.dart';
import 'package:fluttertwitter/view/start_up/create_account_page.dart';
import 'package:fluttertwitter/view/time_line/front_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfddefdc8),
        border: Border.all(width: 1.0, color: const Color(0xff707070)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                return Container(
                  width: double.infinity,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        'ログイン情報を入力',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        width: 300,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: 'メールアドレス',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        width: 300,
                        child: TextField(
                          controller: passController,
                          decoration: InputDecoration(
                              hintText: 'パスワード',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              )),
                          obscureText: true, //
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 60,
                    ),
                    //ボタンを押してログイン
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 71, 240, 158),
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          final result = await Authentication.emailSignIn(
                              email: emailController.text,
                              pass: passController.text);
                          if (result is UserCredential) {
                            if (result.user!.emailVerified == true) {
                              final _result = await UserFirestore.getUserInfo(
                                  result.user!.uid);
                              if (_result is Account) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Screen(num: 0)),
                                  (route) => false,
                                );
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      children: <Widget>[
                                        AlertDialog(
                                          title: Text("認証失敗"),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Column(
                                                    // コンテンツ
                                                    ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            // ボタン
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    children: <Widget>[
                                      AlertDialog(
                                        title: Text("サインインエラー　やり直してください"),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Column(
                                                  // コンテンツ
                                                  ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          // ボタン
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        child: Text('emailでログイン')),
                  ]),
                );
              }),
        ),
      ),
    );
  }
}
