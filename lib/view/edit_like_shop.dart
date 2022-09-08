import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/utils/function_utils.dart';
import 'package:fluttertwitter/utils/widget_utils.dart';
import 'package:fluttertwitter/view/start_up/login_page.dart';
import 'package:image_picker/image_picker.dart';

class EditLikeShop extends StatefulWidget {
  final Account myaccount;
  const EditLikeShop({Key? key, required this.myaccount}) : super(key: key);

  @override
  _EditLikeShopState createState() => _EditLikeShopState();
}

class _EditLikeShopState extends State<EditLikeShop> {
  int? isSelectedGenre = 1;

  @override //初期段階で編集画面に内容を追加する

  @override
  Widget build(BuildContext context) {
    return Container(
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
          appBar: WidgetUtils.createAppBar('プロフィール編集'),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            child: Column(
                              children: [
                                Text('好きなジャンル'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //3
                                SizedBox(
                                  width: 240,
                                  child: DropdownButton(
                                    //4
                                    underline: Container(
                                      height: 1,
                                      color: Colors.red,
                                    ),
                                    isExpanded: true,
                                    items: const [
                                      //5
                                      DropdownMenuItem(
                                        child: Text(
                                          'カフェ',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          'うどん',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          '洋食',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: 3,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          'ラーメン',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: 4,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          'インスタ映え',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: 5,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          '定食',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: 6,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          '韓国料理',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: 7,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          '丼もの',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: 8,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          '居酒屋',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: 9,
                                      ),
                                    ],
                                    //6
                                    onChanged: (int? value) {
                                      setState(() {
                                        isSelectedGenre = value;
                                      });
                                    },
                                    //7
                                    value: isSelectedGenre,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        Account updateAccount = Account(
                          id: widget.myaccount.id,
                          like_genre: isSelectedGenre!,
                        ); // Account

                        final result = await UserFirestore.updateUserLikeGenre(
                            updateAccount);
                        if (result == true) {
                          Navigator.pop(context, true);
                        }
                      },
                      child: Text('更新')),
                  SizedBox(height: 30),
                ],
              ),
            ),
          )),
    );
  }
}
