import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PointTableScreen extends StatefulWidget {
  @override
  _PointTableScreenState createState() => _PointTableScreenState();
}

class _PointTableScreenState extends State<PointTableScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Bảng điểm học tập',
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              height: size.height / 4,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xff29166F),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xff29166F),
                        Color(0xff29166F).withOpacity(.8),
                        Color(0xff29166F).withOpacity(.7),
                      ])),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              white('Điểm tích lũy'),
                              Container(
                                  height: 18,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.amber,
                                      ),
                                      white('Hệ 4 :  2.95'),
                                    ],
                                  )),
                              Container(
                                  height: 18,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.greenAccent,
                                      ),
                                      white('Hệ 10 :  7.6'),
                                    ],
                                  )),
                              Container(
                                  height: 18,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                      ),
                                      white('Số tín chỉ :  100'),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                      white('Học lực : Khá'),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: size.width * 0.3,
                          lineWidth: size.width * 0.02,
                          animation: true,
                          percent: 60 / 100,
                          animationDuration: 2500,
                          restartAnimation: true,

                          center: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * 0.1,
                                horizontal: size.width * 0.1),
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Countup(
                                  begin: 0,
                                  end: 68,
                                  duration: Duration(milliseconds: 2500),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: size.width * 0.03),
                                ),
                                Container(
                                  //color: Colors.black,
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                new Text(
                                  "100",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: size.width * 0.03),
                                ),
                              ],
                            ),
                          ),

                          circularStrokeCap: CircularStrokeCap.round,
                          // progressColor: Color(0xffFCD24B),
                          backgroundColor: Colors.white,
                          backgroundWidth: .2,
                          linearGradient: LinearGradient(
                            begin: Alignment(-1.3, 0),
                            end: Alignment(1.3,
                                0), // 10% of the width, so there are ten blinds.
                            colors: [
                              Colors.green,
                              Colors.greenAccent
                            ], // red to yellow
                            tileMode: TileMode
                                .repeated, // repeats the gradient over the canvas
                          ),
                        ),
                        CircularPercentIndicator(
                          radius: size.width * 0.37,
                          lineWidth: size.width * 0.02,
                          animation: true,
                          percent: 90 / 100,
                          animationDuration: 2500,
                          restartAnimation: true,

                          circularStrokeCap: CircularStrokeCap.round,
                          // progressColor: Color(0xffFCD24B),
                          backgroundColor: Colors.white,
                          backgroundWidth: 0.5,
                          linearGradient: LinearGradient(
                            begin: Alignment(-1.3, 0),
                            end: Alignment(1.3,
                                0), // 10% of the width, so there are ten blinds.
                            colors: [Colors.amber, Colors.red], // red to yellow
                            tileMode: TileMode
                                .repeated, // repeats the gradient over the canvas
                          ),
                        ),
                        CircularPercentIndicator(
                          radius: size.width * 0.43,
                          lineWidth: size.width * 0.02,
                          animation: true,
                          percent: 10 / 100,
                          animationDuration: 2500,
                          restartAnimation: true,

                          circularStrokeCap: CircularStrokeCap.round,
                          // progressColor: Color(0xffFCD24B),
                          backgroundColor: Colors.white,
                          backgroundWidth: 1,
                          linearGradient: LinearGradient(
                            begin: Alignment(-1.3, 0),
                            end: Alignment(1.3,
                                0), // 10% of the width, so there are ten blinds.
                            colors: [
                              Colors.blue,
                              Colors.lightBlueAccent
                            ], // red to yellow
                            tileMode: TileMode
                                .repeated, // repeats the gradient over the canvas
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                // height: size.height / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(-2, 5), // changes position of shadow
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget white(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.white),
  );
}
