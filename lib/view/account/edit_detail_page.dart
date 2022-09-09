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

class EditDetail extends StatefulWidget {
  final Account myaccount;
  const EditDetail({Key? key, required this.myaccount}) : super(key: key);

  @override
  _EditDetailState createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail> {
  int? isSelectedtype = 1;

  // var myAccount = Authentication.myAccount!; //初期段階で編集画面に内容を追加する

  TextEditingController universalController = TextEditingController();
  TextEditingController highschoolController = TextEditingController();

  @override //初期段階で編集画面に内容を追加する
  void initState() {
    super.initState();
    universalController =
        TextEditingController(text: widget.myaccount.universal);
    highschoolController =
        TextEditingController(text: widget.myaccount.highschool);
  }

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
                                Text('大学名'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 220,
                            child: TextField(
                              controller: universalController,
                              decoration: InputDecoration(
                                  hintText: '香川大学',
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 185, 185, 185))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                Text('高校名'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 220,
                            child: TextField(
                              controller: highschoolController,
                              decoration: InputDecoration(
                                  hintText: '高松高校',
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 185, 185, 185))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

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
                                Text('好きな　ジャンル'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // DropdownButton(
                          //   //4
                          //   underline: Container(
                          //     height: 1,
                          //     color: Colors.red,
                          //   ),
                          //   isExpanded: true,
                          //   items: const [
                          //     //5
                          //     DropdownMenuItem(
                          //       child: Text(
                          //         '定住者',
                          //         style: TextStyle(fontSize: 19),
                          //       ),
                          //       value: 1,
                          //     ),
                          //     DropdownMenuItem(
                          //       child: Text(
                          //         '移住者',
                          //         style: TextStyle(fontSize: 19),
                          //       ),
                          //       value: 2,
                          //     ),

                          //     DropdownMenuItem(
                          //       child: Text(
                          //         '観光客',
                          //         style: TextStyle(fontSize: 19),
                          //       ),
                          //       value: 3,
                          //     ),
                          //   ],
                          //   //6
                          //   onChanged: (int? value) {
                          //     setState(() {
                          //       isSelectedtype = value;
                          //     });
                          //   },
                          //   //7
                          //   value: isSelectedtype,
                          // )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  // 情報を更新
                  ElevatedButton(
                      onPressed: () async {
                        if (highschoolController.text.isNotEmpty) {
                          Account updateAccount = Account(
                            id: widget.myaccount.id,
                            universal: universalController.text,
                            highschool: highschoolController.text,
                          ); // Account

                          final result =
                              await UserFirestore.updateUser(updateAccount);
                          if (result == true) {
                            Navigator.pop(context, true);
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Column(
                                  children: <Widget>[
                                    AlertDialog(
                                      title: Text("名前、ユーザーID、自己紹介を入力してください"),
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
                      child: Text('更新')),
                  SizedBox(height: 30),
                ],
              ),
            ),
          )),
    );
  }
}
