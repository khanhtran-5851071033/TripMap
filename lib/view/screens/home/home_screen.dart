import 'package:example/core/models/models.dart';
import 'package:example/model/sinh_vien.dart';
import 'package:example/view/screens/home/attention_screen.dart';
import 'package:example/view/screens/map/floorplan_screen.dart';
import 'package:example/view/screens/map/pano_screen.dart';
import 'package:example/view/screens/tintuc/point_table_screen.dart';
import 'package:example/view/shared/global.dart';
import 'package:example/view/shared/image_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  final SinhVien sinhvien;
  HomeScreen({this.sinhvien});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.85);
  final List<Building> dayNha =
      Global.dayNha.map((item) => Building.fromMap(item)).toList();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: Color(0xff29166F),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06,
                    vertical: size.height * 0.06),
                color: Color(0xff29166F),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hi ' +
                          widget.sinhvien.hoten.split(' ')[
                              widget.sinhvien.hoten.split(' ').length - 2] +
                          ' ' +
                          widget.sinhvien.hoten.split(' ')[
                              widget.sinhvien.hoten.split(' ').length - 1] +
                          ' !',
                      style: TextStyle(
                          color: Colors.white, fontSize: size.width * 0.06),
                    ),
                    Container(
                      width: size.width * 0.1,
                      height: size.width * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.9)),
                      //color: Colors.blue[200].withOpacity(0.5),
                      padding: EdgeInsets.all(3),
                      child: Image.asset('assets/logoUTC.png'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.height * 0.03),
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0)),
                      color: Colors.white),
                  //color: Colors.blue[200].withOpacity(0.5),
                  // padding: EdgeInsets.all(3),
                ),
              ),
            ],
          ),
          Positioned(
            top: size.height / 10,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06, vertical: size.height * 0.03),
              width: size.width,
              height: size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        //color: Colors.blue[200].withOpacity(0.5),
                        padding: EdgeInsets.symmetric(
                            //horizontal: size.width * 0.02,
                            vertical: size.height * 0.01),
                        child: PageView(
                          controller: pageController,
                          children: List.generate(imageIntro.length, (index) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  imageIntro[index],                              
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            );
                          }),
                        )),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttentionScreen(
                                    sinhvien: widget.sinhvien)));
                      },
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 5), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.white.withOpacity(0.9)
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                            vertical: size.height * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.1,
                              height: size.width * 0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              //color: Colors.blue[200].withOpacity(0.5),
                              padding: EdgeInsets.all(3),
                              child: Icon(
                                Icons.qr_code_scanner_rounded,
                                color: Colors.blue[700],
                              ),
                            ),
                            Center(
                                child: Text(
                              'Điểm danh',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.055,
                                  fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FloorPlanScreen()));
                      },
                      child: Container(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 7,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellow[700],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Colors.white.withOpacity(0.9),
                                ),
                                //color: Colors.blue[200].withOpacity(0.5),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.02,
                                    vertical: size.height * 0.01),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.1,
                                      height: size.width * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      //color: Colors.blue[200].withOpacity(0.5),
                                      padding: EdgeInsets.all(3),
                                      child: Icon(
                                        Icons.explore,
                                        color: Colors.yellow[900],
                                      ),
                                    ),
                                    Center(
                                        child: Text(
                                      '2D map',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.width * 0.05,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                            Flexible(
                              flex: 9,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PanoScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent[700],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Colors.white.withOpacity(0.9),
                                  ),
                                  //color: Colors.blue[200].withOpacity(0.5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.02,
                                      vertical: size.height * 0.01),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size.width * 0.1,
                                        height: size.width * 0.1,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        //color: Colors.blue[200].withOpacity(0.5),
                                        padding: EdgeInsets.all(5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.asset(
                                              'assets/utc_logo_plash.png'),
                                        ),
                                      ),
                                      Center(
                                          child: Text(
                                        '3D map',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.width * 0.055,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PointTableScreen()));
                      },
                      child: Container(
                        width: size.width,

                        decoration: BoxDecoration(
                          color: Colors.red[400],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 5), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.white.withOpacity(0.9),
                        ),
                        //color: Colors.blue[200].withOpacity(0.5),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                            vertical: size.height * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.1,
                              height: size.width * 0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              //color: Colors.blue[200].withOpacity(0.5),
                              padding: EdgeInsets.all(3),
                              child: Icon(
                                Icons.poll_outlined,
                                color: Colors.red[700],
                              ),
                            ),
                            Center(
                                child: Text(
                              'Bảng điểm học tập',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
