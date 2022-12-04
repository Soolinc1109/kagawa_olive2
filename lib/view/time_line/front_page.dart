import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/view/main_page.dart';
import 'package:fluttertwitter/view/start_up/create_account_page.dart';
import 'package:fluttertwitter/view/start_up/login_page.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

//ログイン関連の整理整頓
//ラインログインの実装
//webページの整理

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  bool _isChecked = false;
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
                    SizedBox(height: 55),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: 80,
                        child: Image(
                          image: AssetImage(
                            'images/olive.png',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SizedBox(
                        height: 270,
                        child: Image(
                          image: AssetImage(
                            'images/frontpage.png',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text('instagramを使って\nお店を宣伝して割引してもらおう！',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _isChecked, //「bool _isChecked = false;」を定義済み
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                          activeColor: Color.fromARGB(255, 255, 209, 3),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: '利用規約',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 156, 68),
                                    fontSize: 14),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('"RichText" がタップされました');
                                  },
                              ),
                              TextSpan(
                                text: 'と',
                              ),
                              TextSpan(
                                text: ' プライバシーポリシー',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 156, 68),
                                    fontSize: 14),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
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
                              TextSpan(
                                text: ' に同意します',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    //ボタンを押してログイン
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 55,
                            width: 140,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 255, 209, 3),
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  if (_isChecked == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAccountPage()),
                                    );
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            children: <Widget>[
                                              AlertDialog(
                                                title: Text(
                                                  "エラー",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Column(
                                                        children: [
                                                          Text(
                                                              '利用規約と、プライバシーポリシーへの同意が必要です')
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[],
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (context) {
                                  //       return Column(
                                  //         children: <Widget>[
                                  //           AlertDialog(
                                  //             title: Text("同意画面"),
                                  //             content: SingleChildScrollView(
                                  //               child: ListBody(
                                  //                 children: <Widget>[
                                  //                   Column(
                                  //                       // コンテンツ
                                  //                       ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             actions: <Widget>[],
                                  //           ),
                                  //         ],
                                  //       );
                                  //     });
                                },
                                child: Text(
                                  '会員登録',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 55,
                            width: 140,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0), //枠線の色
                                ),
                                primary: Color.fromARGB(255, 0, 0, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {
                                if (_isChecked == true) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 200),
                                          child: Column(
                                            children: <Widget>[
                                              AlertDialog(
                                                title: Text(
                                                  "ログイン方法をお選びください",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Column(
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              LoginPage()),
                                                                );
                                                              },
                                                              child: Text(
                                                                  'メールアドレスでログインする')),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          SignInButton(
                                                              Buttons.Google,
                                                              onPressed:
                                                                  () async {
                                                            final userCredential =
                                                                await Authentication()
                                                                    .signInWithGoogle();

                                                            if (userCredential ==
                                                                null) {
                                                              //エラーの処理
                                                              return;
                                                            }
                                                            await Navigator
                                                                .pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Screen(
                                                                            num:
                                                                                1,
                                                                          )),
                                                              ((route) =>
                                                                  false),
                                                            );
                                                            //   return;
                                                            // }
                                                          }),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          SignInWithAppleButton(
                                                            onPressed:
                                                                () async {
                                                              final credential =
                                                                  await SignInWithApple
                                                                      .getAppleIDCredential(
                                                                scopes: [
                                                                  AppleIDAuthorizationScopes
                                                                      .email,
                                                                  AppleIDAuthorizationScopes
                                                                      .fullName,
                                                                ],
                                                              );

                                                              print(credential);

                                                              // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                                                              // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                                                            },
                                                          )
                                                          // ElevatedButton(
                                                          //     onPressed:
                                                          //         () async {
                                                          //       final userCredential =
                                                          //           await Authentication()
                                                          //               .signInWithApple();

                                                          //       await Navigator
                                                          //           .pushAndRemoveUntil(
                                                          //         context,
                                                          //         MaterialPageRoute(
                                                          //             builder:
                                                          //                 (context) =>
                                                          //                     Screen(
                                                          //                       num: 1,
                                                          //                     )),
                                                          //         ((route) =>
                                                          //             false),
                                                          //       );
                                                          //     },
                                                          //     child: Text(
                                                          //         'appleサインイン'))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[],
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          children: <Widget>[
                                            AlertDialog(
                                              title: Text(
                                                "エラー",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Column(
                                                      children: [
                                                        Text(
                                                            '利用規約と、プライバシーポリシーへの同意が必要です')
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[],
                                            ),
                                          ],
                                        );
                                      });
                                }
                              },
                              child: Text('ログイン',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                );
              }),
        ),
      ),
    );
  }
}
