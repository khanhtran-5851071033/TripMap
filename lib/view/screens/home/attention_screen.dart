import 'dart:convert';

import 'package:utc2/model/sinh_vien.dart';
import 'package:utc2/view/shared/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:utc2/view/shared/geo_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class AttentionScreen extends StatefulWidget {
  final SinhVien sinhvien;
  AttentionScreen({this.sinhvien});
  @override
  _CheckinScreenState createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<AttentionScreen> {
  PageController _controller = PageController(initialPage: 0);
  String lat, long;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unfocus(context);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Điểm danh',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            CheckInPage(
              sinhvien: widget.sinhvien,
              complete: (_lat, _long) {
                _controller.animateToPage(1,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.fastLinearToSlowEaseIn);
                setState(() {
                  lat = _lat;
                  long = _long;
                });
              },
            ),
            CompleteCheckPage(
              lat: lat,
              long: long,
              sinhvien: widget.sinhvien,
              complete: () {
                _controller.jumpToPage(0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
////////////////////////////PAGE CHECK IN/////////////////////

class CheckInPage extends StatefulWidget {
  final SinhVien sinhvien;
  final Function(String, String) complete;
  CheckInPage({this.complete, this.sinhvien});
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  bool isLoading = false;
  String code, error = 'Nhập mã điểm danh';
  TextEditingController textEditingController = TextEditingController();
  Position location;
  GeoService geoService = GeoService();
  Future<Position> getLocation() async {
    var currentPosition = await geoService.getCurrentLocation();
    return currentPosition;
  }

  // void checkIn(String code) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   // var id = await getMsv();
  //   Position location = await getLocation();
  //   if (location == null) {
  //     setState(() {
  //       isLoading = false;
  //       error = 'Bật dịch vụ vị trí và thử lại';
  //     });
  //   } else {
  //     print(location.latitude.toString() + '/' + location.longitude.toString());
  //     if (code == '123') {
  //       widget.complete(
  //           location.latitude.toString(), location.longitude.toString());
  //       setState(() {
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       showError(2);
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // checkInApiProvider.streamController.stream.listen((info) async {
    //   print(info);
    //   var result = await checkInApiProvider.checkIn(
    //     info[0],
    //     info[1],
    //     info[2],
    //     info[3],
    //   );
    //   switch (result) {
    //     case '1':
    //       widget.complete();
    //       setState(() {
    //         isLoading = false;
    //       });
    //       showError('1');
    //       break;
    //     case '2':
    //       // widget.complete();
    //       setState(() {
    //         isLoading = false;
    //       });
    //       showError('2');
    //       break;
    //     case '3':
    //       // widget.complete();
    //       setState(() {
    //         isLoading = false;
    //       });
    //       showError('3');
    //       break;
    //     case '4':
    //       // widget.complete();
    //       setState(() {
    //         isLoading = false;
    //       });
    //       showError('4');
    //       break;
    //     default:
    //       break;
    //   }
    // });
  }

  void showError(int result) {
    switch (result) {
      case 0:
        setState(() {
          error = 'Nhập mã điểm danh';
        });
        break;
      case 1:
        setState(() {
          error = 'Điểm danh thành công';
        });
        break;
      case 2:
        setState(() {
          error = 'Mã điểm danh không đúng';
        });
        break;
      case 3:
        setState(() {
          error = 'Mã điểm danh hết hạn';
        });
        break;
      case 4:
        setState(() {
          error = 'Bạn đang không có mặt';
        });
        break;
      default:
        break;
    }
  }

  Future _scan() async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      checkIn(barcode);
    }
  }

  Future checkIn(String code) async {
    setState(() {
      isLoading = true;
    });
    location = await getLocation();
    if (location == null) {
      setState(() {
        isLoading = false;
        error = 'Bật dịch vụ vị trí và thử lại';
      });
    } else {
      // if (code == '123') {
      setState(() {
        isLoading = false;
      });
      try {
        if (code == '123') {
          showError(1);
        } else
          showError(2);

        var geocoding = Geocoder.local;
        var longitude = location.longitude;
        var latitude = location.latitude;
        var results = await geocoding
            .findAddressesFromCoordinates(new Coordinates(latitude, longitude));

        var now =
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(DateTime.now().toString());
        // var attenTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.time);
        ///API
        http.post(
          Uri.parse(
              'https://6058c0c5c3f49200173aed5b.mockapi.io/api/khanh/attendance'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'id_student': widget.sinhvien.msv,
            'name': widget.sinhvien.hoten,
            'time': now.toString(),
            'location': location.latitude.toString() +
                ',' +
                location.longitude.toString(),
            'address': widget.sinhvien.msv,
          }),
        );

        print(results[0].addressLine);
      } catch (e) {
        print("Error occured: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(height: 10.0),
        Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.only(top: 20.0),
              child: FittedBox(
                fit: BoxFit.fill,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logoUTC.png'),
                  backgroundColor: Color(0xffE6E6E6),
                  // radius: 50,
                ),
              ),
            )),
        Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                      margin: EdgeInsets.only(top: 5.0),
                      padding: EdgeInsets.only(top: 10.0),
                      alignment: Alignment.bottomCenter,
                      child: GradientText(
                        sizeScreen.width * 0.065,
                        widget.sinhvien.hoten,
                        gradient: LinearGradient(
                            colors: [Color(0xff4C6E89), Color(0xffA4CCCE)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      )),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                      margin: EdgeInsets.only(top: 5.0),
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Nhấn để quét mã',
                        style: TextStyle(
                            fontSize: sizeScreen.width * 0.065,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () async {
                      _scan();
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        alignment: Alignment.center,
                        child: Container(
                          width: sizeScreen.width * 0.18,
                          height: sizeScreen.width * 0.18,
                          padding: EdgeInsets.all(sizeScreen.width * 0.03),
                          decoration: BoxDecoration(
                              color: Color(0xff29166F), shape: BoxShape.circle),
                          child: FittedBox(
                            child: isLoading
                                ? SpinKitFadingCircle(
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.crop_free,
                                    color: Colors.white,
                                  ),
                          ),
                        )),
                  ),
                ),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      error,
                      style: TextStyle(
                          fontSize: sizeScreen.width * 0.055,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0,
                          child: Container(
                            // onPressed: () {},
                            child: Icon(
                              Icons.exit_to_app,
                              size: sizeScreen.width * 0.08,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        Container(
                          // padding: EdgeInsets.only(bottom: 25.0),
                          width: sizeScreen.width * 0.5,
                          child: TextFormField(
                            controller: textEditingController,
                            onTap: () {
                              setState(() {
                                error = 'Nhập mã điểm danh';
                              });
                            },
                            autofocus: false,
                            // controller: textEditingController,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black)),
                            ),
                            // length: 6,
                            // width: sizeScreen.width * 0.05,
                            // fieldWidth: 30,
                            style: TextStyle(
                              fontSize: sizeScreen.width * 0.05,
                            ),
                            // textFieldAlignment: MainAxisAlignment.spaceAround,
                            // fieldStyle: FieldStyle.underline,
                            // onCompleted: (pin) async {
                            //   ///////////////////////////////////////
                            //   print("Completed: " + pin);
                            //   checkIn('123');
                            // },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            unfocus(context);
                            checkIn(textEditingController.text.trim());
                          },
                          icon: Icon(
                            Icons.exit_to_app,
                            size: sizeScreen.width * 0.08,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 20.0)
              ],
            )),
      ]),
    );
  }
}

//////////////////////////////////////PAGE COMPLETE
class CompleteCheckPage extends StatefulWidget {
  final VoidCallback complete;
  final SinhVien sinhvien;
  final String lat, long;
  CompleteCheckPage({this.complete, this.sinhvien, this.lat, this.long});
  @override
  _CompleteCheckPageState createState() => _CompleteCheckPageState();
}

class _CompleteCheckPageState extends State<CompleteCheckPage> {
  String time = '';
  @override
  void initState() {
    super.initState();
    // time = DateFormat('HH:mm:ss').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        unfocus(context);
      },
      child: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(height: 10.0),
          Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Container(
                padding: EdgeInsets.only(top: 20.0),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/utc3_10.jpg'),
                    backgroundColor: Color(0xffE6E6E6),
                    // radius: 50,
                  ),
                ),
              )),
          Flexible(
              flex: 6,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                        margin: EdgeInsets.only(top: 5.0),
                        padding: EdgeInsets.only(top: 10.0),
                        alignment: Alignment.bottomCenter,
                        child: GradientText(
                          sizeScreen.width * 0.065,
                          widget.sinhvien.hoten,
                          gradient: LinearGradient(
                              colors: [Color(0xff4C6E89), Color(0xffA4CCCE)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        )),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        // alignment: Alignment.bottomCenter,
                        child: Text(
                          'Tận hưởng ngày tốt lành',
                          style: TextStyle(
                              fontSize: sizeScreen.width * 0.045,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Có mặt lúc ' + time,
                            style: TextStyle(
                                fontSize: sizeScreen.width * 0.045,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600),
                          ))),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text(
                        '01 giờ, 01 phút\n' + widget.lat + '/' + widget.long,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: sizeScreen.width * 0.05,
                            color: Color(0xff29166F),
                            fontWeight: FontWeight.bold),
                      )),
                  Flexible(
                      flex: 1,
                      // fit: FlexFit.tight,
                      child: InkWell(
                        onTap: () {
                          widget.complete();
                        },
                        child: Container(
                          // padding: EdgeInsets.symmetric(
                          //     vertical: sizeScreen.width * 0.02),
                          width: sizeScreen.width * 0.7,
                          height: sizeScreen.width * 0.12,
                          decoration: BoxDecoration(
                              color: Color(0xff29166F),
                              borderRadius: BorderRadius.circular(
                                  sizeScreen.width * 0.03)),
                          alignment: Alignment.center,
                          child: Text(
                            'TẠM BIỆT',
                            style: TextStyle(
                                fontSize: sizeScreen.width * 0.045,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                  const SizedBox(height: 20.0)
                ],
              )),
        ]),
      ),
    );
  }
}
