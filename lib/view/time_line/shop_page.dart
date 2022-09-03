import 'dart:io';
import 'package:adobe_xd/adobe_xd.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertwitter/model/menu.dart';
import 'package:fluttertwitter/model/shop.dart';
import 'package:fluttertwitter/utils/firestore/shops.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShopPage(),
    );
  }
}

const _tabs = <Widget>[
  Tab(
      icon: Icon(
    Icons.filter,
    color: Colors.black,
  )),
  Tab(
      icon: Icon(
    Icons.content_cut,
    color: Colors.black,
  )),
  Tab(
      icon: Icon(
    Icons.content_cut,
    color: Colors.black,
  )),
];

/// Sticky TabBarを実現するページ
class ShopPage extends StatefulWidget {
  Shop? shopinfo;

  ShopPage({Key? key, this.shopinfo}) : super(key: key);
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  static final _firestoreInstance = FirebaseFirestore.instance;
  // static final CollectionReference users = _firestoreInstance
  //     .collection('users')
  //     .doc('R2K2fmb3Z0fksPEvemk5LWSUPwv1')
  //     .collection('my_follows');

//ポストのインスタンスを格納したリスト型の変数、を定義

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black, size: 30),
          backgroundColor: Colors.white,
          title: Text(
            widget.shopinfo!.shop_name,
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: DefaultTabController(
        length: _tabs.length, // This is the number of tabs.
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.only(right: 0, left: 0, top: 20),
                      height: 400,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 220,
                            width: double.infinity,
                            alignment: Alignment.topCenter,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.network(
                                widget.shopinfo!.image_path,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final url = Uri.parse(
                                          widget.shopinfo!.instagram,
                                        );
                                        if (await canLaunchUrl(url)) {
                                          launchUrl(url);
                                        } else {
                                          // ignore: avoid_print
                                          print("Can't launch $url");
                                        }
                                      },
                                      child: CircleAvatar(
                                          radius: 24,
                                          foregroundImage: NetworkImage(
                                              'https://pbs.twimg.com/profile_images/1132882384318152705/sJx01uiK_400x400.png')),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final url = Uri.parse(
                                          widget.shopinfo!.googlemap,
                                        );
                                        if (await canLaunchUrl(url)) {
                                          launchUrl(url);
                                        } else {
                                          // ignore: avoid_print
                                          print("Can't launch $url");
                                        }
                                      },
                                      child: CircleAvatar(
                                          radius: 24,
                                          foregroundImage: NetworkImage(
                                              'https://play-lh.googleusercontent.com/Kf8WTct65hFJxBUDm5E-EpYsiDoLQiGGbnuyP6HBNax43YShXti9THPon1YKB6zPYpA')),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                        radius: 24,
                                        foregroundImage: NetworkImage(
                                            'https://pbs.twimg.com/profile_images/1132882384318152705/sJx01uiK_400x400.png')),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        String text =
                                            widget.shopinfo!.instagram;
                                        text = text.replaceAll(
                                            "https://www.instagram.com/", "");
                                        return SizedBox(
                                          height: 300,
                                          child: Container(
                                            height: 100,
                                            child: SimpleDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  40))),
                                              title: Text(
                                                widget.shopinfo!.shop_name,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            300.0),
                                                  ),
                                                  height: 170,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 23.0),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 3,
                                                              height: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .green),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "あなたにやって欲しいこと",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 9,
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      23),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      width: 90,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            216,
                                                                            99),
                                                                        border: Border.all(
                                                                            width:
                                                                                0.5,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96)),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            'PR方法'),
                                                                      )),
                                                                  Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            0,
                                                                            145,
                                                                            126,
                                                                            70),
                                                                        border:
                                                                            Border(
                                                                          right:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          top:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          bottom:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      width:
                                                                          170,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'ストーリーズ',
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      height:
                                                                          50,
                                                                      width: 90,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            216,
                                                                            99),
                                                                        border:
                                                                            Border(
                                                                          right:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          left:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'タグ付アカウント',
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        ),
                                                                      )),
                                                                  Container(
                                                                    height: 50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color.fromARGB(
                                                                          0,
                                                                          145,
                                                                          126,
                                                                          70),
                                                                      border:
                                                                          Border(
                                                                        right:
                                                                            BorderSide(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              96,
                                                                              96,
                                                                              96),
                                                                          width:
                                                                              0.5,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    width: 170,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        '@$text',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      width: 90,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            216,
                                                                            99),
                                                                        border:
                                                                            Border(
                                                                          right:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          left:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          top:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          bottom:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            'PR方法'),
                                                                      )),
                                                                  Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            0,
                                                                            145,
                                                                            126,
                                                                            70),
                                                                        border:
                                                                            Border(
                                                                          right:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          top:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          bottom:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      width:
                                                                          170,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'ストーリーズ',
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            300.0),
                                                  ),
                                                  height: 500,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 23.0),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 3,
                                                              height: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .green),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "サービス内容",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 9,
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      23),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      height:
                                                                          40,
                                                                      width: 90,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            216,
                                                                            99),
                                                                        border: Border.all(
                                                                            width:
                                                                                0.5,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96)),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'サービスの内容',
                                                                          style:
                                                                              TextStyle(fontSize: 10),
                                                                        ),
                                                                      )),
                                                                  Container(
                                                                      height:
                                                                          40,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            0,
                                                                            145,
                                                                            126,
                                                                            70),
                                                                        border:
                                                                            Border(
                                                                          right:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          top:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          bottom:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      width:
                                                                          170,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          widget
                                                                              .shopinfo!
                                                                              .service,
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      height:
                                                                          50,
                                                                      width: 90,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            216,
                                                                            99),
                                                                        border:
                                                                            Border(
                                                                          right:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          left:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          '住所',
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        ),
                                                                      )),
                                                                  Container(
                                                                    height: 50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color.fromARGB(
                                                                          0,
                                                                          145,
                                                                          126,
                                                                          70),
                                                                      border:
                                                                          Border(
                                                                        right:
                                                                            BorderSide(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              96,
                                                                              96,
                                                                              96),
                                                                          width:
                                                                              0.5,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    width: 170,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        widget
                                                                            .shopinfo!
                                                                            .address,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      width: 90,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            216,
                                                                            99),
                                                                        border:
                                                                            Border(
                                                                          right:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          left:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          top:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          bottom:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            'PR方法'),
                                                                      )),
                                                                  Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            0,
                                                                            145,
                                                                            126,
                                                                            70),
                                                                        border:
                                                                            Border(
                                                                          right:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          top:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                          bottom:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                96,
                                                                                96,
                                                                                96),
                                                                            width:
                                                                                0.5,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      width:
                                                                          170,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'ストーリーズ',
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 3,
                                                                    height: 20,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            color:
                                                                                Colors.green),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    "注意事項",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        color: Colors
                                                                            .amber),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text('※交通費は自己負担となります'),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Text('※お1人さま一回までとなります'),
                                                                            ],
                                                                          ),
                                                                          Text(
                                                                              '※投稿がお見受けできない場合凍結してしまう可能性がございます'),
                                                                          Row(
                                                                            children: [
                                                                              Text('※交通費は自己負担となります'),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 40,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 74, 232, 79),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'このお店に行く',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Text('【営業時間】'),
                                    ),
                                    Container(
                                      child: Text('土日休み'),
                                    ),
                                    Container(
                                      child: Text('10:00~19:00'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: 270,
                                  child: Text(
                                    widget.shopinfo!.selfIntroduction,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(
                  TabBar(
                    labelColor: Color.fromARGB(255, 0, 0, 0),
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    indicatorColor: Color.fromARGB(255, 98, 255, 59),
                    tabs: <Widget>[
                      Tab(
                        text: widget.shopinfo!.menu_genre1![1],
                      ),
                      Tab(
                        text: widget.shopinfo!.menu_genre2![1],
                      ),
                      Tab(
                        text: widget.shopinfo!.menu_genre3![1],
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('shops')
                            .doc(widget.shopinfo!.id)
                            .collection('menu')
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
                          return FutureBuilder<List<Menu>?>(
                              future: ShopFirestore.getShopMenu(
                                  widget.shopinfo!.id, 1),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return SizedBox();
                                }
                                return GridView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics:
                                        NeverScrollableScrollPhysics(), //追加

                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 3 / 4,
                                            crossAxisCount: 2),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      if (!snapshot.hasData) {
                                        return SizedBox();
                                      }
                                      Menu shopAccount = snapshot.data![index];

                                      return Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(11),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SimpleDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    40))),
                                                    children: [
                                                      Container(
                                                        height: 500,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 200,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                              child: Container(
                                                                height: 220,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              35),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              35)),
                                                                  child: Image(
                                                                      image: NetworkImage(
                                                                          shopAccount
                                                                              .image_path)),
                                                                ),
                                                              ),
                                                            ),
                                                            SimpleDialogOption(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: Text(
                                                                  shopAccount
                                                                      .menu_name),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          26, 69, 69, 69), //色
                                                      spreadRadius: 3,
                                                      blurRadius: 3,
                                                      offset: Offset(1, 1),
                                                    ),
                                                  ],
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 130,
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
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        shopAccount.menu_name,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            bottom: 0),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      width: double.infinity,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            shopAccount.price
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                          Text(
                                                            '円',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            bottom: 0),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      width: double.infinity,
                                                      child: Text(
                                                        'オリジナルパスタ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 1),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              });
                        }),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('shops')
                              .doc(widget.shopinfo!.id)
                              .collection('menu')
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
                            return FutureBuilder<List<Menu>?>(
                                future: ShopFirestore.getShopMenu(
                                    widget.shopinfo!.id, 2),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return SizedBox();
                                  }
                                  return GridView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      physics:
                                          NeverScrollableScrollPhysics(), //追加

                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 3 / 4,
                                              crossAxisCount: 2),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        if (!snapshot.hasData) {
                                          return SizedBox();
                                        }

                                        Menu shopAccount =
                                            snapshot.data![index];

                                        return Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SimpleDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    40))),
                                                    title: Text(
                                                        shopAccount.menu_name),
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      300.0),
                                                        ),
                                                        height: 500,
                                                        child: Column(
                                                          children: [
                                                            Image(
                                                                image: NetworkImage(
                                                                    shopAccount
                                                                        .image_path)),
                                                            SimpleDialogOption(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: Text(
                                                                  "サービス内容"),
                                                            ),
                                                            SimpleDialogOption(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: Text(""),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          26, 69, 69, 69), //色
                                                      spreadRadius: 3,
                                                      blurRadius: 3,
                                                      offset: Offset(1, 1),
                                                    ),
                                                  ],
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 130,
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
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        shopAccount.menu_name,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            bottom: 0),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      width: double.infinity,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            shopAccount.price
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                          Text(
                                                            '円',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            bottom: 0),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      width: double.infinity,
                                                      child: Text(
                                                        'オリジナルパスタ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 1),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                });
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('shops')
                              .doc(widget.shopinfo!.id)
                              .collection('menu')
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
                            });
                            return FutureBuilder<List<Menu>?>(
                                future: ShopFirestore.getShopMenu(
                                    widget.shopinfo!.id, 3),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return SizedBox();
                                  }
                                  return GridView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      physics:
                                          NeverScrollableScrollPhysics(), //追加

                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 3 / 4,
                                              crossAxisCount: 2),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        if (!snapshot.hasData) {
                                          return SizedBox();
                                        }
                                        Menu shopAccount =
                                            snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SimpleDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    40))),
                                                    title: Text(
                                                        shopAccount.menu_name),
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      300.0),
                                                        ),
                                                        height: 500,
                                                        child: Column(
                                                          children: [
                                                            Image(
                                                                image: NetworkImage(
                                                                    shopAccount
                                                                        .image_path)),
                                                            SimpleDialogOption(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: Text(
                                                                  "サービス内容"),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          26, 69, 69, 69), //色
                                                      spreadRadius: 3,
                                                      blurRadius: 3,
                                                      offset: Offset(1, 1),
                                                    ),
                                                  ],
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 130,
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
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        shopAccount.menu_name,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            bottom: 0),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      width: double.infinity,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            shopAccount.price
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                          Text(
                                                            '円',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            bottom: 0),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      width: double.infinity,
                                                      child: Text(
                                                        'オリジナルパスタ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 1),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                });
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _StickyTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Color.fromARGB(255, 254, 254, 254), child: tabBar);
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}

class SlideImage extends StatefulWidget {
  final List<dynamic> beforeimagePhoto;
  final List<dynamic> afterimagePhoto;
  const SlideImage(
      {Key? key, required this.beforeimagePhoto, required this.afterimagePhoto})
      : super(key: key);

  @override
  State<SlideImage> createState() => _SlideImageState();
}

class _SlideImageState extends State<SlideImage> {
  List beforeimages = [];
  List afterimages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    beforeimages = widget.beforeimagePhoto;
    afterimages = widget.afterimagePhoto;
  }

  int activeIndex = 0;
  Widget buildImage(beforepath, afterpath, index) => Row(
        children: [
          Column(
            children: [
              Text('before'),
              Container(
                height: 230,
                width: 180,
                color: Colors.grey,
                child: Image.network(
                  beforepath,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text('after'),
              Container(
                height: 230,
                width: 180,
                color: Colors.grey,
                child: Image.network(
                  afterpath,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 3,
        //エフェクトはドキュメントを見た方がわかりやすい
        effect: JumpingDotEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Colors.green,
            dotColor: Colors.black12),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (context, index, realIndex) {
            final beforepath = beforeimages[index];
            final afterpath = afterimages[index];

            return buildImage(beforepath, afterpath, index);
          },
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            viewportFraction: 1,
            // enlargeCenterPage: true,
            onPageChanged: (index, reason) => setState(
              () {
                activeIndex = index;
              },
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Text('front'),
        SizedBox(
          height: 5,
        ),
        buildIndicator(),
      ]),
    );
  }
}
