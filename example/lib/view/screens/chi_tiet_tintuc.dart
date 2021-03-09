import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/model/event.dart';
import 'package:example/model/event_scraper.dart';
import 'package:example/model/noti.dart';
import 'package:example/model/noti_scraper.dart';
import 'package:example/view/shared/util.dart';
import 'package:example/view/widgets/photo_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatefulWidget {
  final Event list;
  final Noti listNoti;
  NewsDetail({this.list, this.listNoti});
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  ScrollController controller;
  bool showBack = true, scroll = false, isEvent = true;
  double top = 0, offset = 0, showAppbar = 0;
  final blocEvent = EventScraper();
  final blocNoti = NotiScraper();
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    if (widget.list != null)
      blocEvent.getContent(widget.list.link);
    else {
      blocNoti.getContent(widget.listNoti.link);
      isEvent = false;
    }
  }

  @override
  void dispose() {
    // blocEvent.dispose();
    // blocNoti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   backgroundColor: Color(0xff29166F),
      //   child:
      // ),
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
                child: isEvent
                    ? Hero(
                        tag: Key(widget.list.img),
                        child: CachedNetworkImage(
                          imageUrl: widget.list.img,
                          // height: size.height * 0.3,
                          width: size.width + offset,
                          // height: offset == 0 ? null : size.width * 0.67 + offset,
                          fit: BoxFit.fitWidth,
                          memCacheWidth: size.width.toInt() * 2,
                        ),
                      )
                    : Container(
                        color: Util.myColor,
                        width: size.width,
                        height: size.height * 0.6,
                      ),
              ),
            ),
            CupertinoScrollbar(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  // padding: EdgeInsets.only(bottom: size.height * 0.2),
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
                                padding: EdgeInsets.fromLTRB(
                                    10, 10, 10, 20 + offset),
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
                                  isEvent
                                      ? widget.list.tittle
                                      : widget.listNoti.tieude,
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
                        padding:
                            EdgeInsets.fromLTRB(8, 8, 8, size.height * 0.2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(size.width * 0.05)),
                        child: Column(children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              isEvent
                                                  ? widget.list.ngay
                                                  : widget.listNoti.thoigian,
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
                                            isEvent
                                                ? Text(
                                                    widget.list.luotxem,
                                                    style: TextStyle(
                                                      color: Color(0xff29166F),
                                                    ),
                                                  )
                                                : StreamBuilder<List<Block>>(
                                                    stream:
                                                        blocNoti.streamContent,
                                                    builder:
                                                        (context, snapshot) {
                                                      return snapshot.hasData
                                                          ? Text(
                                                              snapshot.data[0]
                                                                  .luotxem,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff29166F),
                                                              ),
                                                            )
                                                          : Container(
                                                              // child:
                                                              //     SpinKitThreeBounce(
                                                              //   size: size.width *
                                                              //       0.06,
                                                              //   color:
                                                              //       Util.myColor,
                                                              // ),
                                                              );
                                                    }),
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
                          StreamBuilder<List<Block>>(
                              stream: isEvent
                                  ? blocEvent.streamContent
                                  : blocNoti.streamContent,
                              builder: (context, snapshot) {
                                return snapshot.hasData
                                    ? Column(
                                        children: List.generate(
                                            snapshot.data.length, (index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              snapshot.data[index].link != null
                                                  ? InkWell(
                                                      onTap: () {
                                                        launch(snapshot
                                                            .data[index].link);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .blue)),
                                                        child: Text(
                                                          snapshot
                                                              .data[index].text
                                                              .trim(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      ),
                                                    )
                                                  : Text('    ' +
                                                      snapshot.data[index].text
                                                          .trim()),
                                              snapshot.data[index].imgLink ==
                                                      null
                                                  ? Container()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PhotoViewWidget(
                                                                    img: snapshot
                                                                        .data[
                                                                            index]
                                                                        .imgLink,
                                                                  )),
                                                        );
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: snapshot
                                                              .data[index]
                                                              .imgLink,
                                                          // height: size.height * 0.3,
                                                          width: size.width,
                                                          fit: BoxFit.fitWidth,
                                                          memCacheWidth: size
                                                                  .width
                                                                  .toInt() *
                                                              2,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        }),
                                      )
                                    : Container(
                                        height: size.height * 0.5,
                                        child: Center(
                                          child: SpinKitThreeBounce(
                                            color: Util.myColor,
                                            size: size.width * 0.06,
                                          ),
                                        ),
                                      );
                              })
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: statusBarHeight,
              child: Stack(
                children: [
                  AnimatedOpacity(
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
                      padding: EdgeInsets.fromLTRB(70, 10, 10, 10),

                      width: size.width,
                      // height: size.width * 0.3,
                      child: Text(
                        isEvent ? widget.list.tittle : widget.listNoti.tieude,
                        style: TextStyle(
                            wordSpacing: 1.5,
                            letterSpacing: 0.5,
                            fontSize: size.width * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: RawMaterialButton(
                      fillColor: Util.myColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
