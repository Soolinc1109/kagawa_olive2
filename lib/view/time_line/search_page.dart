import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/model/genre.dart';
import 'package:fluttertwitter/model/post.dart';
import 'package:fluttertwitter/model/shop.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/posts.dart';
import 'package:fluttertwitter/utils/firestore/shops.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/view/account/edit_account_page.dart';
import 'package:fluttertwitter/view/time_line/front_page.dart';
import 'package:fluttertwitter/view/time_line/post_page.dart';
import 'package:fluttertwitter/view/time_line/shibori_page.dart';
import 'package:fluttertwitter/view/time_line/shop_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _city = '';
  int? isSelectedPlace = 1;
  bool _gourmetchecked = false;
  bool _travelchecked = false;
  bool _aparerchecked = false;
  bool _beautychecked = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // List<Shop> shopList = [
  //   Shop(
  //   shop_name:'スッカラン',
  //   service:　'無料',
  //   image_path: 'https://img.ku-zou.com/images/suckaran/640/12.jpg'),
  //   Shop(shop_name: 'linomalie', service: '無料', image_path: ''),
  //   Shop(shop_name: 'きさらぎ', service: '無料', image_path: ''),
  //   Shop(shop_name: 'カモメ', service: '無料', image_path: ''),
  //   Shop(shop_name: 'umie', service: '無料', image_path: ''),
  //   Shop(shop_name: 'ゆう', service: '無料', image_path: ''),
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            Color.fromARGB(208, 136, 255, 96),
            Color.fromARGB(255, 239, 255, 117)
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
          //   child: Text('条件を変更する',),
          //   onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          // ),
          centerTitle: true,

          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.bottomLeft,
              height: 40,
              child: Text('キャンペーンを探す',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),

          // Text(
          //   '香川olive',
          //   style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          // ),
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
                          '新着順',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                        // Text(
                        //   '人気順',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, fontSize: 16),
                        //   textAlign: TextAlign.left,
                        // ),
                        // Text(
                        //   'お得順',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, fontSize: 16),
                        //   textAlign: TextAlign.left,
                        // ),
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
                                    color: Color.fromARGB(26, 69, 69, 69), //色
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
                                  '条件を変更する',
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
                  Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('shops')
                            .orderBy('created_time', descending: true)
                            .snapshots(),

                        // .collection('my_user_post')
                        // .orderBy('created_time', descending: true)

                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox();
                          }
                          List<String> shoplist = List.generate(
                              snapshot.data!.docs.length, (index) {
                            return snapshot.data!.docs[index].id;

                            //自分のmypostsのIDとpostsコレクションにある同じIDの投稿をとってくるために参照
                            //futureで情報を取る前にじぶんのIDと同じものを取るためにやらないといけない処理↑
                          });
                          return FutureBuilder<List<Shop>?>(
                              future: ShopFirestore.getShops(shoplist),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: SpinKitChasingDots(
                                      color: Color.fromARGB(255, 255, 204, 0),
                                    ),
                                  );
                                } else {
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 3 / 4,
                                            crossAxisCount: 2),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      Shop shopAccount = snapshot.data![index];
                                      return Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShopPage(
                                                          shopinfo:
                                                              shopAccount)),
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Stack(children: [
                                                  Container(
                                                    height: 150,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10)),
                                                      child: Image.network(
                                                        shopAccount.image_path,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Container(
                                                        width: 32,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 2,
                                                                  horizontal:
                                                                      4),
                                                          child: Text(
                                                            shopAccount
                                                                .place_string,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 11),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      shopAccount.shop_name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10, bottom: 0),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    width: double.infinity,
                                                    child: Text(
                                                      '1000~1999',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 11),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10, bottom: 0),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    width: double.infinity,
                                                    child: Text(
                                                      shopAccount.service,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ),
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
                  ),
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
                    '条件を指定して探す',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  '場所',
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
                              '高松',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '丸亀',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '三豊',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'まんのう・綾川',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'さぬき・三木',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '観音寺',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '多度津・善通寺',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 7,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '東かがわ',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 8,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '琴平',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 9,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '宇多津・坂出',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 10,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '直島',
                              style: TextStyle(fontSize: 19),
                            ),
                            value: 11,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '小豆島',
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
                  'ジャンル',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29.0),
                child: Row(
                  children: [
                    Text('グルメ'),
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
                    Text('トラベル'),
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
                    Text('アパレル'),
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
                    Text('ビューティー'),
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
                  height: 50, //高さ
                  child: ElevatedButton(
                    child: const Text('探す'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 217, 0),
                      onPrimary: Colors.black,
                      elevation: 16,
                    ),
                    onPressed: () {
                      String basho = '高松';
                      switch (isSelectedPlace) {
                        case 1:
                          basho = '高松';
                          break;
                        case 2:
                          basho = '丸亀';
                          break;
                        case 3:
                          basho = '三豊';
                          break;
                        case 4:
                          basho = 'まんのう・綾川';
                          break;
                        case 5:
                          basho = 'さぬき・三木';
                          break;
                        case 6:
                          basho = '高松';
                          break;
                        default:
                          basho = '位置情報なし';
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
