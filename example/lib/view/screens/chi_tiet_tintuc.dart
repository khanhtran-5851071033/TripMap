import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  final Event list;
  NewsDetail({this.list});
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  ScrollController controller;
  bool showBack = true, scroll = false;
  double top = 0, offset = 0, showAppbar = 0;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    print(widget.list.tittle);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Color(0xff29166F),
        child: Icon(
          Icons.arrow_back_ios_sharp,
          size: 20,
          color: Colors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: Container(),
      //   backgroundColor: Colors.black45.withOpacity(0),
      //   elevation: 0,
      //   title: Text('abc'),
      // ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification t) {
          if (t.metrics.pixels <= 0) {
            setState(() {
              offset = -t.metrics.pixels;
            });
          } else {
            setState(() {
              top = t.metrics.pixels / 3;
            });
          }
          if (t.metrics.pixels >= size.height * 0.2) {
            setState(() {
              showAppbar = 1;
            });
          } else {
            setState(() {
              showAppbar = 0;
            });
          }
          if (t.metrics.pixels == 0) {
            setState(() {
              showBack = true;
            });
          } else {
            setState(() {
              showBack = false;
            });
          }
          return true;
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -top,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: widget.list.img,
                  // height: size.height * 0.3,
                  width: size.width + offset,
                  // height: offset == 0 ? null : size.width * 0.67 + offset,
                  fit: BoxFit.fitWidth,
                  memCacheWidth: size.width.toInt() * 2,
                ),
              ),
            ),
            CupertinoScrollbar(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    IgnorePointer(
                      child: Stack(
                        overflow: Overflow.visible,
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          SizedBox(
                            height: size.height * 0.3,
                          ),
                          Positioned(
                            bottom: -10 - offset,
                            child: Container(
                              // height: 100 + offset,
                              alignment: Alignment.bottomCenter,
                              padding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 20 + offset),
                              width: size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(.8),
                                      Colors.black.withOpacity(.5),
                                      Colors.black.withOpacity(.0),
                                    ]),
                              ),
                              child: Text(
                                widget.list.tittle,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.05),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      // height: size.width * 2,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius:
                              BorderRadius.circular(size.width * 0.05)),
                      child: Column(children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xff29166F),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/logoUTC.png',
                                        width: size.width * 0.07,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        'UTC2',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.blue[200]
                                              .withOpacity(0.2)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.timelapse,
                                            color: Color(0xff29166F),
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            widget.list.ngay,
                                            style: TextStyle(
                                              color: Color(0xff29166F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.blue[200]
                                              .withOpacity(0.2)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.visibility,
                                            color: Color(0xff29166F),
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(widget.list.luotxem,
                                              style: TextStyle(
                                                color: Color(0xff29166F),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Divider(
                          color: Colors.black45,
                          thickness: 0.6,
                          height: 15,
                        ),
                        Text(
                            'Nhằm tạo môi trường đào tạo bám sát với thực tiễn, chiều ngày 26 tháng 02 năm 2021, tại Hội thảo Thư Viện - Trường Đại học GTVT Phân hiệu tại TP. HCM đã tổ chức Lễ ký thỏathuận hợp tác với Viện nghiên cứu và phát triển Logistics Việt Nam (VLI). Đến tham dự buổi Lễ về phía VLI có PGS.TS Hồ hị Thu Hoà - Viện trưởng, ThS. Võ Thị Phương Lan - Ủy viên CH, trưởng ban đào tạo Hiệp hội doanh nghiệp dịch vụ ogistics Việt Nam. TS. Võ Trường Sơn - Phó Giám đốc Phân iệu, cùng các Thầy/Cô là lãnh đạo Phân hiệu và các lãnh đạo ủa Viện VLI.',
                            style: TextStyle(fontSize: 20)),
                        CachedNetworkImage(
                          imageUrl: widget.list.img,
                          // height: size.height * 0.3,
                          width: size.width + offset,
                          // height: offset == 0 ? null : size.width * 0.67 + offset,
                          fit: BoxFit.fitWidth,
                          memCacheWidth: size.width.toInt() * 2,
                        ),
                        Text(
                            'Nhằm tạo môi trường đào tạo bám sát với thực tiễn, chiều ngày 26 tháng 02 năm 2021, tại Hội thảo Thư Viện - Trường Đại học GTVT Phân hiệu tại TP. HCM đã tổ chức Lễ ký thỏathuận hợp tác với Viện nghiên cứu và phát triển Logistics Việt Nam (VLI). Đến tham dự buổi Lễ về phía VLI có PGS.TS Hồ hị Thu Hoà - Viện trưởng, ThS. Võ Thị Phương Lan - Ủy viên CH, trưởng ban đào tạo Hiệp hội doanh nghiệp dịch vụ ogistics Việt Nam. TS. Võ Trường Sơn - Phó Giám đốc Phân iệu, cùng các Thầy/Cô là lãnh đạo Phân hiệu và các lãnh đạo ủa Viện VLI.',
                            style: TextStyle(fontSize: 20)),
                        CachedNetworkImage(
                          imageUrl: widget.list.img,
                          // height: size.height * 0.3,
                          width: size.width,
                          // height: offset == 0 ? null : size.width * 0.67 + offset,
                          fit: BoxFit.fitWidth,
                          memCacheWidth: size.width.toInt() * 2,
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: statusBarHeight,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: showAppbar,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    //  BorderRadius.only(
                    //   bottomLeft: Radius.circular(15),
                    //   bottomRight: Radius.circular(15),
                    // ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 15,
                        offset: Offset(0, -22),
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 20),

                  width: size.width,
                  // height: size.width * 0.3,
                  child: Text(
                    widget.list.tittle,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
