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

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  int? isSelectedtype = 1;

  var myAccount = Authentication.myAccount!; //初期段階で編集画面に内容を追加する
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController universalController = TextEditingController();
  TextEditingController highschoolController = TextEditingController();
  TextEditingController junior_high_schoolController = TextEditingController();
  TextEditingController sanukibenController = TextEditingController();
  TextEditingController kagawarekiController = TextEditingController();
  TextEditingController zokuseiController = TextEditingController();
  TextEditingController likemovieController = TextEditingController();
  TextEditingController likefoodController = TextEditingController();
  TextEditingController hobbyController = TextEditingController();

  File? image;

  ImageProvider getImage() {
    if (image == null) {
      return NetworkImage(myAccount.imagePath);
    } else {
      return FileImage(image!);
    }
  }

  @override //初期段階で編集画面に内容を追加する
  void initState() {
    super.initState();
    nameController = TextEditingController(text: myAccount.name);
    userIdController = TextEditingController(text: myAccount.userId);
    selfIntroductionController =
        TextEditingController(text: myAccount.selfIntroduction);
    universalController = TextEditingController(text: myAccount.universal);
    highschoolController = TextEditingController(text: myAccount.highschool);
    junior_high_schoolController =
        TextEditingController(text: myAccount.junior_high_school);
    sanukibenController = TextEditingController(text: myAccount.sanukiben);
    kagawarekiController = TextEditingController(text: myAccount.kagawareki);
    zokuseiController = TextEditingController(text: myAccount.zokusei);
    likemovieController = TextEditingController(text: myAccount.likemovie);
    likefoodController = TextEditingController(text: myAccount.likefood);
    hobbyController = TextEditingController(text: myAccount.hobby);
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
                  SizedBox(
                    height: 30,
                  ),
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
                      foregroundImage: getImage(),
                      radius: 40,
                      child: Icon(Icons.add),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Container(width: 60, child: Text('名前')),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 220,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                                hintText: '名前',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 185, 185, 185))),
                          ),
                        ),
                      ],
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
                                Text('ユーザーID'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 220,
                            child: TextField(
                                controller: userIdController,
                                decoration: InputDecoration(
                                    hintText: 'ユーザーID',
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(
                                            255, 185, 185, 185))),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z0-9@_.]')),
                                ]),
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
                                Text('自己紹介'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 220,
                            child: TextField(
                              controller: selfIntroductionController,
                              decoration: InputDecoration(
                                  hintText: '自己紹介',
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
                                Text('中学名'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 220,
                            child: TextField(
                              controller: junior_high_schoolController,
                              decoration: InputDecoration(
                                  hintText: '桜町中学',
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
                                Text('好きな　讃岐弁'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 220,
                            child: TextField(
                              controller: sanukibenController,
                              decoration: InputDecoration(
                                  hintText: 'だけん',
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
                                Text('香川歴'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 220,
                            child: TextField(
                                controller: kagawarekiController,
                                decoration: InputDecoration(
                                    hintText: '20',
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(
                                            255, 185, 185, 185))),
                                keyboardType:
                                    TextInputType.number, // ② キーボードタイプを数字入力に
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ]),
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
                                Text('属性'),
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
                                Text('好きな　映画'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 220,
                            child: TextField(
                              controller: likemovieController,
                              decoration: InputDecoration(
                                  hintText: 'ホームアローン',
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
                                Text('好きな　食べ物'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 220,
                            child: TextField(
                              controller: likefoodController,
                              decoration: InputDecoration(
                                  hintText: 'うどん',
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
                                Text('趣味'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 220,
                            child: TextField(
                              controller: hobbyController,
                              decoration: InputDecoration(
                                  hintText: '旅行',
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 185, 185, 185))),
                            ),
                          ),
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
                        if (nameController.text.isNotEmpty &&
                            userIdController.text.isNotEmpty) {
                          String imagePath = '';
                          if (image == null) {
                            imagePath = myAccount.imagePath;
                          } else {
                            var result = await FunctionUtils.upLoadImage(
                                myAccount.id, image!);
                            imagePath = result;
                          }
                          Account updateAccount = Account(
                              id: myAccount.id,
                              name: nameController.text,
                              userId: userIdController.text,
                              selfIntroduction: selfIntroductionController.text,
                              universal: universalController.text,
                              highschool: highschoolController.text,
                              junior_high_school:
                                  junior_high_schoolController.text,
                              sanukiben: sanukibenController.text,
                              kagawareki: kagawarekiController.text,
                              zokusei: zokuseiController.text,
                              likemovie: likemovieController.text,
                              likefood: likefoodController.text,
                              hobby: hobbyController.text,
                              imagePath: imagePath); // Account

                          Authentication.myAccount = updateAccount;
                          myAccount = updateAccount;
                          var result =
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
