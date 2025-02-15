import 'package:utc2/model/scraper/diem_scraper.dart';
import 'package:utc2/model/sinh_vien.dart';
import 'package:utc2/view/screens/home_route.dart';
import 'package:utc2/view/screens/login_screen.dart';
import 'package:utc2/view/shared/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DiemScraper diemScraper = DiemScraper();
  @override
  void initState() {
    super.initState();
    loadThongTin();
    // diemScraper.getThongTin('5851071033');
  }

  void loadThongTin() async {
    var msv = await getMsv();
    if (msv != null) {
      diemScraper.getThongTin(msv);
    } else {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<SinhVien>(
          stream: diemScraper.streamThongTin,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Future.delayed(Duration(seconds: 2), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeRoute(sinhvien: snapshot.data)));
              });
              return Center(
                child: Container(
                  width: width * 0.3,
                  height: width * 0.3,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset('assets/utc_logo_plash.png'),
                  ),
                ),
              );
            } else {
              return Center(
                child: Container(
                  width: width * 0.3,
                  height: width * 0.3,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset('assets/utc_logo_plash.png'),
                  ),
                ),
              );
            }
          }),
    );
  }
}
