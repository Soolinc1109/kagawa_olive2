import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/utils/widget_utils.dart';
import 'package:fluttertwitter/view/main_page.dart';
import 'package:fluttertwitter/view/start_up/check_email_page.dart';
import 'package:fluttertwitter/view/time_line/time_line_page.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/function_utils.dart';

class CreateAccountPage extends StatefulWidget {
  final bool isSignInWithGoogle;

  const CreateAccountPage({Key? key, this.isSignInWithGoogle = false})
      : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  // TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfddefdc8),
        border: Border.all(width: 1.0, color: const Color(0xff707070)),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: WidgetUtils.createAppBar('アカウントを開設する'),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      var result = await FunctionUtils.getImageFromGallery();
                      if (result != null) {
                        setState(() {
                          image = File(result.path);
                        });
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      foregroundImage: image == null ? null : FileImage(image!),
                      radius: 40,
                      child: Container(
                        height: 40,
                        child: Image(
                          image: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/16/16410.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text('画像を挿入'),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: '名前',
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
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      width: 300,
                      child: TextField(
                          controller: userIdController,
                          decoration: InputDecoration(
                              hintText: 'ユーザーID',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              )),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z0-9@_.]')),
                          ]),
                    ),
                  ),
                  widget.isSignInWithGoogle
                      ? Container()
                      : Column(
                          children: [
                            Container(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
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
                                ),
                              ),
                            ),
                          ],
                        ),

                  // Container(
                  //   width: 300,
                  //   child: TextField(
                  //     // controller: selfIntroductionController,
                  //     decoration: InputDecoration(
                  //         hintText: '自己紹介',
                  //         filled: true,
                  //         fillColor: Colors.white,
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //           borderSide: BorderSide.none,
                  //         )),
                  //   ),
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 71, 240, 158),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (nameController.text.isNotEmpty &&
                            userIdController.text.isNotEmpty &&
                            // emailController.text.isNotEmpty &&
                            // passController.text.isNotEmpty &&
                            image != null) {
                          if (widget.isSignInWithGoogle) {
                            var _result = await createAccaount(
                                Authentication.currentFirebaseUser!.uid);
                            if (_result is UserCredential) {
                              await UserFirestore.existsUser(
                                  (Authentication.currentFirebaseUser!.uid));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Screen(
                                         
                                          num: 1,
                                        )),
                              );
                            }
                          }
                          var result = await Authentication.signUp(
                              email: emailController.text,
                              pass: passController.text);
                          if (result is UserCredential) {
                            var _result = createAccaount(result.user!.uid);
                            if (_result is UserCredential) {
                              // print('============メール送信=============');
                              // result.user!.sendEmailVerification();

                              // print('=========================');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Screen(
                                
                                          num: 0,
                                          // email: emailController.text,
                                          // pass: passController.text,
                                        )),
                              );
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      children: <Widget>[
                                        AlertDialog(
                                          title: Text("メールが送信できませんでした$e"),
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
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Column(
                                  children: <Widget>[
                                    AlertDialog(
                                      title: Text("アカウント作成に失敗しました$e"),
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
                      child: Text('アカウントを作成'))
                ],
              ),
            ),
          )),
    );
  }

  Future<User> createAccaount(String uid) async {
    String imagePath = await FunctionUtils.upLoadImage(uid, image!);
    Account newAccount = Account(
      id: uid,
      name: nameController.text,
      userId: userIdController.text,
      imagePath: imagePath,
    );
    var _result = await UserFirestore.setUser(newAccount);
    return _result;
  }
}
