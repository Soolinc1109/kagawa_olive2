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
  final Account myaccount;
  const EditAccountPage({Key? key, required this.myaccount}) : super(key: key);

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  String? isSelectedtype = '観光客';
  // var myAccount = Authentication.myAccount!; //初期段階で編集画面に内容を追加する
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
      return NetworkImage(widget.myaccount.imagePath);
    } else {
      return FileImage(image!);
    }
  }

  @override //初期段階で編集画面に内容を追加する
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.myaccount.name);
    userIdController = TextEditingController(text: widget.myaccount.userId);
    selfIntroductionController =
        TextEditingController(text: widget.myaccount.selfIntroduction);
    universalController =
        TextEditingController(text: widget.myaccount.universal);
    highschoolController =
        TextEditingController(text: widget.myaccount.highschool);
    junior_high_schoolController =
        TextEditingController(text: widget.myaccount.junior_high_school);
    sanukibenController =
        TextEditingController(text: widget.myaccount.sanukiben);
    kagawarekiController =
        TextEditingController(text: widget.myaccount.kagawareki);
    zokuseiController = TextEditingController(text: widget.myaccount.zokusei);
    likemovieController =
        TextEditingController(text: widget.myaccount.likemovie);
    likefoodController = TextEditingController(text: widget.myaccount.likefood);
    hobbyController = TextEditingController(text: widget.myaccount.hobby);
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
                                          '観光客',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: '観光客',
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          '移住者',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: '移住者',
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          '定住者',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        value: '定住者',
                                      )
                                    ],
                                    //6
                                    onChanged: (String? value) {
                                      setState(() {
                                        isSelectedtype = value;
                                      });
                                    },
                                    //7
                                    value: isSelectedtype,
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

                  // 情報を更新
                  ElevatedButton(
                      onPressed: () async {
                        if (nameController.text.isNotEmpty) {
                          String imagePath = '';
                          if (image == null) {
                            imagePath = widget.myaccount.imagePath;
                          } else {
                            var result = await FunctionUtils.upLoadImage(
                                widget.myaccount.id, image!);
                            imagePath = result;
                          }
                          Account updateAccount = Account(
                              id: widget.myaccount.id,
                              name: nameController.text,
                              userId: userIdController.text,
                              selfIntroduction: selfIntroductionController.text,
                              universal: universalController.text,
                              highschool: highschoolController.text,
                              junior_high_school:
                                  junior_high_schoolController.text,
                              sanukiben: sanukibenController.text,
                              kagawareki: kagawarekiController.text,
                              zokusei: isSelectedtype.toString(),
                              likemovie: likemovieController.text,
                              likefood: likefoodController.text,
                              hobby: hobbyController.text,
                              imagePath: imagePath); // Account

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
