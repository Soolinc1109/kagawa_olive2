import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/model/genre.dart';
import 'package:fluttertwitter/model/post.dart';
import 'package:fluttertwitter/model/shop.dart';
import 'package:fluttertwitter/model/visitShops.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/posts.dart';
import 'package:fluttertwitter/utils/firestore/shops.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/view/account/account_page.dart';
import 'package:fluttertwitter/view/account/edit_account_page.dart';
import 'package:fluttertwitter/view/account/user_page.dart';
import 'package:fluttertwitter/view/time_line/front_page.dart';
import 'package:fluttertwitter/view/time_line/post_page.dart';
import 'package:fluttertwitter/view/time_line/shibori_page.dart';
import 'package:fluttertwitter/view/time_line/shop_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationPage extends StatefulWidget {
  // final Shop shopInfo;
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var _city = '';
  int? isSelectedPlace = 1;
  bool _gourmetchecked = false;
  bool _travelchecked = false;
  bool _aparerchecked = false;
  bool _beautychecked = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            Color.fromARGB(208, 162, 255, 132),
            Color.fromARGB(255, 242, 255, 140)
          ],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(144, 198, 255, 148),
            offset: Offset(6, 3),
            blurRadius: 18,
          ),
        ],
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        appBar: AppBar(
          actions: [Container()],
          automaticallyImplyLeading: false,
          // leading: TextButton(
          //   child: Text('?????????????????????',),
          //   onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          // ),
          centerTitle: true,

          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.bottomLeft,
              height: 40,
              child: Text('??????',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),

          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '?????????',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                            onTap: () =>
                                _scaffoldKey.currentState!.openEndDrawer(),
                            child: Container(
                              height: 50,
                              width: 130,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(26, 69, 69, 69), //???
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: Color.fromARGB(255, 255, 226, 36),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Text(
                                  '?????????????????????',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  FutureBuilder<Account?>(
                      future: UserFirestore.getUserInfo(
                          FirebaseAuth.instance.currentUser!.uid),
                      builder: (context, snapshot) {
                        print(snapshot.data);

                        if (!snapshot.hasData) {
                          return SizedBox();
                        }
                        final myAccount = snapshot.data;
                        if (myAccount == null) {
                          return SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('shops')
                                  .doc(myAccount.shop_account_id)
                                  .collection('visit_user')
                                  .where('is_nice', isEqualTo: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                print('=============???sdf============');
                                if (!snapshot.hasData) {
                                  return SizedBox();
                                }
                                List<String> userList = List.generate(
                                    snapshot.data!.docs.length, (index) {
                                  return snapshot.data!.docs[index].id;
                                });
                                return FutureBuilder<List<Account>?>(
                                    future: UserFirestore.getUsers(userList),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: SpinKitChasingDots(
                                            color: Color.fromARGB(
                                                255, 255, 204, 0),
                                          ),
                                        );
                                      } else {
                                        if (!snapshot.hasData) {
                                          return SizedBox(
                                            child: Text(''),
                                          );
                                        }
                                        if (snapshot.data!.length == 0) {
                                          return Container(
                                            child: Text('??????????????????????????????'),
                                          );
                                        }
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            final userAccount =
                                                snapshot.data![index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserPage(
                                                              userInfo:
                                                                  userAccount,
                                                            )),
                                                  );
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: 60,
                                                                width: 60,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    userAccount
                                                                        .imagePath,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          userAccount
                                                                              .name,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16),
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                        ),
                                                                        Text(
                                                                          '????????????PR???????????????????????????',
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              2,
                                                                          style: TextStyle(
                                                                              color: Color.fromARGB(255, 154, 154, 154),
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 10),
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
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
                                                                              80,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              SimpleDialogOption(
                                                                                onPressed: () => Navigator.pop(context),
                                                                                child: Text(
                                                                                  '????????????',
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(25.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              VisitShop visitShopInfo = VisitShop(
                                                                                visit_time: Timestamp.now(),
                                                                                shop_id: myAccount.shop_account_id,
                                                                              );

                                                                              final result = await UserFirestore.permitedVisiter(userAccount.id, myAccount.shop_account_id);
                                                                              final changeBool = await ShopFirestore.permitedVisiter(myAccount.shop_account_id, userAccount.id);
                                                                              if (result == true && changeBool == true) {
                                                                                return showDialog(
                                                                                    barrierDismissible: false,
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return SimpleDialog(
                                                                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                                                                                        children: [
                                                                                          Container(
                                                                                            height: 160,
                                                                                            child: Column(
                                                                                              children: [
                                                                                                SimpleDialogOption(
                                                                                                  onPressed: () {
                                                                                                    Navigator.pop(context);
                                                                                                    Navigator.pop(context);
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    '?????????????????????????????????',
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 30,
                                                                                                ),
                                                                                                Text(
                                                                                                  '${userAccount.name}?????????\n???????????????????????????',
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                  maxLines: 2,
                                                                                                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16, fontWeight: FontWeight.bold),
                                                                                                  textAlign: TextAlign.center,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                                                                            child: InkWell(
                                                                                              onTap: () async {
                                                                                                Navigator.pop(context);
                                                                                                Navigator.pop(context);
                                                                                              },
                                                                                              child: Container(
                                                                                                height: 50,
                                                                                                width: 50,
                                                                                                decoration: BoxDecoration(
                                                                                                  boxShadow: [
                                                                                                    BoxShadow(
                                                                                                      color: Color.fromARGB(26, 69, 69, 69), //???
                                                                                                      spreadRadius: 3,
                                                                                                      blurRadius: 3,
                                                                                                      offset: Offset(1, 1),
                                                                                                    ),
                                                                                                  ],
                                                                                                  color: Color.fromARGB(255, 255, 226, 36),
                                                                                                  borderRadius: BorderRadius.circular(25.0),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(13.0),
                                                                                                  child: Text(
                                                                                                    '??????',
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    maxLines: 2,
                                                                                                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 14, fontWeight: FontWeight.bold),
                                                                                                    textAlign: TextAlign.center,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    });
                                                                              }
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 50,
                                                                              width: 50,
                                                                              decoration: BoxDecoration(
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    color: Color.fromARGB(26, 69, 69, 69), //???
                                                                                    spreadRadius: 3,
                                                                                    blurRadius: 3,
                                                                                    offset: Offset(1, 1),
                                                                                  ),
                                                                                ],
                                                                                color: Color.fromARGB(255, 255, 226, 36),
                                                                                borderRadius: BorderRadius.circular(25.0),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(13.0),
                                                                                child: Text(
                                                                                  '???????????????',
                                                                                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 14, fontWeight: FontWeight.bold),
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 40,
                                                                width: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Color.fromARGB(
                                                                          26,
                                                                          69,
                                                                          69,
                                                                          69), //???
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
                                                                              5.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    '??????',
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    });
                              }),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              Container(
                height: 80,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 255, 255, 255),
                  ),
                  child: Text(
                    '???????????????????????????',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  '??????',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {},
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
                              '??????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '??????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '??????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '?????????????????????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '??????????????????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '?????????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '?????????????????????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 7,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '????????????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 8,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '??????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 9,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '??????????????????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 10,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '??????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 11,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '?????????',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 11,
                          ),
                        ],
                        //6
                        onChanged: (int? value) {
                          setState(() {
                            isSelectedPlace = value;
                          });
                        },
                        //7
                        value: isSelectedPlace,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  '????????????',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29.0),
                child: Row(
                  children: [
                    Text('?????????'),
                    Container(
                      child: Checkbox(
                        activeColor: Colors.red,
                        value: _gourmetchecked,
                        onChanged: (bool? value) => {
                          setState(() {
                            _gourmetchecked = value!;
                          })
                        },
                      ),
                    ),
                    Text('????????????'),
                    Container(
                      child: Checkbox(
                        activeColor: Colors.red,
                        value: _travelchecked,
                        onChanged: (bool? value) => {
                          setState(() {
                            _travelchecked = value!;
                          })
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29.0),
                child: Row(
                  children: [
                    Text('????????????'),
                    Container(
                      child: Checkbox(
                        activeColor: Colors.red,
                        value: _aparerchecked,
                        onChanged: (bool? value) => {
                          setState(() {
                            _aparerchecked = value!;
                          })
                        },
                      ),
                    ),
                    Text('??????????????????'),
                    Container(
                      child: Checkbox(
                        activeColor: Colors.red,
                        value: _beautychecked,
                        onChanged: (bool? value) => {
                          setState(() {
                            _beautychecked = value!;
                          })
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 50, //??????
                  child: ElevatedButton(
                    child: const Text('??????'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 217, 0),
                      onPrimary: Colors.black,
                      elevation: 16,
                    ),
                    onPressed: () {
                      String basho = '??????';
                      switch (isSelectedPlace) {
                        case 1:
                          basho = '??????';
                          break;
                        case 2:
                          basho = '??????';
                          break;
                        case 3:
                          basho = '??????';
                          break;
                        case 4:
                          basho = '?????????????????????';
                          break;
                        case 5:
                          basho = '??????????????????';
                          break;
                        case 6:
                          basho = '??????';
                          break;
                        default:
                          basho = '??????????????????';
                          break;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShiboriPage(
                                  place: isSelectedPlace!,
                                  basho: basho,
                                )),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
