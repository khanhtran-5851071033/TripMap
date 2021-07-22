import 'package:example/model/event.dart';
import 'package:example/model/scraper/event_scraper.dart';
import 'package:example/model/noti.dart';
import 'package:example/model/scraper/noti_scraper.dart';
import 'package:example/model/point.dart';
import 'package:example/model/scraper/point_scraper.dart';
import 'package:example/view/screens/tintuc/chi_tiet_tintuc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final blocNoti = NotiScraper();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // blocEvent.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    blocNoti.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //  final controller = TabController();
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff29166F),
            centerTitle: true,
            title: Text(
              'Tin tức',
              style: TextStyle(color: Colors.white),
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: size.width * 0.8,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: TabBar(
                    physics: BouncingScrollPhysics(),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey[600],
                    indicatorColor: Colors.transparent,
                    indicator: new BubbleTabIndicator(
                      indicatorHeight: size.height * 0.05,
                      indicatorColor: Color(0xff29166F),
                      tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    ),
                    tabs: [
                      Tab(
                        icon: Container(
                          child: Text(
                            'Thông báo',
                          ),
                        ),
                      ),
                      Tab(
                        icon: Container(
                          child: Text('Sự kiện'),
                        ),
                      ),
                      Tab(
                        icon: Container(
                          child: Text('Tuyển sinh'),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              StreamBuilder<List<Noti>>(
                  stream: blocNoti.stream,
                  builder: (context, snapshot) {
                    return NotifyList(
                      list: snapshot,
                    );
                  }),
              NewsList(),
              PointList(),
            ],
          )),
    );
  }
}

class NotifyList extends StatefulWidget {
  final AsyncSnapshot<List<Noti>> list;
  NotifyList({this.list});
  @override
  _NotifyListState createState() => _NotifyListState();
}

class _NotifyListState extends State<NotifyList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;
    return widget.list.hasData
        ? ListView.builder(
            itemCount: widget.list.data.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => NewsDetail(
                                listNoti: widget.list.data[index],
                              )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        color: Colors.blue[200].withOpacity(0.5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                        child: Column(
                          children: [
                            Text(
                              widget.list.data[index].thoigian.split('-')[0],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff29166F),
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.list.data[index].thoigian.split('-')[1] +
                                  '/' +
                                  widget.list.data[index].thoigian
                                      .split('-')[2],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xff29166F)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.list.data[index].tieude,
                            maxLines: 3,
                            style: TextStyle(fontSize: 20),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: SpinKitThreeBounce(
                          color: Color(0xff29166F),
              size: size.width * 0.06,
            ),
          );
  }
}

class PointList extends StatefulWidget {
  @override
  _PointListState createState() => _PointListState();
}

class _PointListState extends State<PointList> {
  final bloc = PointScraper();
  List listYear = <String>[];
  String year = (DateTime.now().year - 1).toString();
  int selectedIndex = 1;
  bool showSecond = false;
  @override
  void dispose() {
    // bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchTHPT('2020');
    bloc.fetchHB('2020');
    var year = DateTime.now().year;
    listYear.add(year.toString());
    listYear.add((year - 1).toString());
    listYear.add((year - 2).toString());
  }

  Widget cellContent(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          value ?? '',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton(
              onPressed: () {
                setState(() {
                  showSecond = false;
                });
              },
              child: Text(
                'Xét điểm thi THPT',
                style: TextStyle(
                    color: showSecond ? Colors.black : Color(0xff29166F),
                    fontSize:
                        showSecond ? size.width * 0.03 : size.width * 0.038),
              ),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  showSecond = true;
                });
              },
              child: Text(
                'Xét điểm học bạ',
                style: TextStyle(
                    color: !showSecond ? Colors.black : Color(0xff29166F),
                    fontSize:
                        !showSecond ? size.width * 0.03 : size.width * 0.038),
              ),
            ),
            Row(
              children: [
                Text('Năm: '),
                SizedBox(
                  width: 5,
                ),
                DropdownButton(
                  value: year,
                  onChanged: (val) {
                    setState(() {
                      year = val;
                    });

                    bloc.fetchHB(val);
                    bloc.fetchTHPT(val);
                  },
                  selectedItemBuilder: (context) {
                    return listYear.map<Widget>((val) {
                      return DropdownMenuItem(
                        child: Text(
                          val,
                          style: TextStyle(color: Colors.red),
                        ),
                        value: val,
                      );
                    }).toList();
                  },
                  items: List.generate(listYear.length, (index) {
                    return DropdownMenuItem(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(listYear[index]),
                          index == selectedIndex
                              ? Icon(Icons.check_circle,
                                  size: size.width * 0.05,
                                  color: Color(0xff29166F))
                              : Container(),
                        ],
                      ),
                      value: listYear[index],
                    );
                  }),
                )
              ],
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 300),
              crossFadeState: showSecond
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: StreamBuilder<List<Point>>(
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Container(
                          height: size.height / 2,
                          child: Center(
                            child: Text(
                              'Năm học này chưa có dữ liệu',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: size.width * 0.04),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.all(8),
                          child: Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: {
                              0: FlexColumnWidth(0.5),
                              1: FlexColumnWidth(1.5),
                              2: FlexColumnWidth(3),
                              3: FlexColumnWidth(2),
                              4: FlexColumnWidth(1),
                              5: FlexColumnWidth(2),
                            },
                            border: TableBorder.symmetric(
                              inside:
                                  BorderSide(color: Colors.green, width: 0.2),
                              outside:
                                  BorderSide(color: Colors.green, width: 0.5),
                            ),
                            children:
                                List.generate(snapshot.data.length, (index) {
                              return index == 0
                                  ? TableRow(
                                      decoration: BoxDecoration(
                                          color: Colors.blue[200]
                                              .withOpacity(0.5)),
                                      children: [
                                          cellContent('STT'),
                                          cellContent('Mã'),
                                          cellContent('Tên Ngành'),
                                          cellContent('Tổ hợp'),
                                          cellContent('Điểm chuẩn'),
                                          cellContent('Ghi chú'),
                                        ])
                                  : TableRow(children: [
                                      cellContent(snapshot.data[index - 1].stt),
                                      cellContent(
                                          snapshot.data[index - 1].manganh),
                                      cellContent(
                                          snapshot.data[index - 1].tennganh),
                                      cellContent(
                                          snapshot.data[index - 1].tohopmon),
                                      cellContent(
                                          snapshot.data[index - 1].diemchuan),
                                      cellContent(
                                          snapshot.data[index - 1].ghichu),
                                    ]);
                            }),
                          ),
                        );
                      }
                    } else {
                      return SpinKitThreeBounce(
                                    color: Color(
                                                                    0xff29166F),
                        size: size.width * 0.06,
                      );
                    }
                  }),
              secondChild: StreamBuilder<List<Point>>(
                  stream: bloc.streamHB,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Container(
                          height: size.height / 2,
                          child: Center(
                            child: Text(
                              'Năm học này chưa có dữ liệu',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: size.width * 0.04),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.all(8),
                          child: Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: {
                              0: FlexColumnWidth(0.5),
                              1: FlexColumnWidth(1.5),
                              2: FlexColumnWidth(4),
                              // 3: FlexColumnWidth(0.5),
                              3: FlexColumnWidth(1.8),
                              // 5: FlexColumnWidth(0.5),
                            },
                            border: TableBorder.symmetric(
                              inside:
                                  BorderSide(color: Colors.green, width: 0.2),
                              outside:
                                  BorderSide(color: Colors.green, width: 0.5),
                            ),
                            children:
                                List.generate(snapshot.data.length, (index) {
                              return index == 0
                                  ? TableRow(
                                      decoration: BoxDecoration(
                                          color: Colors.blue[200]
                                              .withOpacity(0.5)),
                                      children: [
                                          cellContent('STT'),
                                          cellContent('Mã'),
                                          cellContent('Tên Ngành'),
                                          // cellContent('Tổ hợp'),
                                          cellContent('Điểm chuẩn'),
                                          // cellContent('Ghi chú'),
                                        ])
                                  : TableRow(children: [
                                      cellContent(snapshot.data[index - 1].stt),
                                      cellContent(
                                          snapshot.data[index - 1].manganh),
                                      cellContent(
                                          snapshot.data[index - 1].tennganh),
                                      // cellContent(
                                      // snapshot.data[index - 1].tohopmon),
                                      cellContent(
                                          snapshot.data[index - 1].diemchuan),
                                      // cellContent(
                                      // snapshot.data[index - 1].ghichu),
                                    ]);
                            }),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: SpinKitThreeBounce(
                                      color: Color(
                                                                    0xff29166F),
                          size: size.width * 0.06,
                        ),
                      );
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }
}

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList>
    with AutomaticKeepAliveClientMixin {
  final blocEvent = EventScraper();
  @override
  void initState() {
    super.initState();

    blocEvent.fetchEvent();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<Event>>(
        stream: blocEvent.stream,
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Container(
                  child: Center(
                      child: SpinKitThreeBounce(
                    color: Color(0xff29166F),
                    size: size.width * 0.06,
                  )),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length < 11
                      ? snapshot.data.length + 1
                      : snapshot.data.length,
                  itemBuilder: (context, index) {
                    return index == snapshot.data.length &&
                            snapshot.data.length < 11
                        ? Container(
                            height: 100,
                            child: Center(
                                child: SpinKitThreeBounce(
                              color: Color(0xff29166F),
                              size: 30,
                            )),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => NewsDetail(
                                          list: snapshot.data[index])));
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              margin: EdgeInsets.all(8),
                              width: size.width,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ]),
                              child: Row(
                                children: [
                                  Hero(
                                    tag: Key(snapshot.data[index].img),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data[index].img,
                                          width: size.width / 3,
                                          fit: BoxFit.fitHeight,
                                          height: 130,
                                          memCacheWidth: 300,
                                          // memCacheHeight: 200,
                                          placeholder: (context, url) =>
                                              CupertinoActivityIndicator(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index].tittle,
                                          style: TextStyle(fontSize: 17),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: Colors.blue[200]
                                                        .withOpacity(0.2)),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.timelapse,
                                                      color: Colors.grey,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      snapshot.data[index].ngay,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: Colors.blue[200]
                                                        .withOpacity(0.2)),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.visibility,
                                                      color: Colors.grey,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      snapshot.data[index]
                                                              .luotxem +
                                                          ' Lượt xem',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  });
        });
  }
}
