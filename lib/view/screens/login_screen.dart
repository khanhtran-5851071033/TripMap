import 'package:utc2/model/scraper/diem_scraper.dart';
import 'package:utc2/model/sinh_vien.dart';
import 'package:utc2/view/screens/home_route.dart';
import 'package:utc2/view/shared/util.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  DiemScraper diemScraper = DiemScraper();
  bool checkBoxValue = true,
      focus = false,
      isPass = true,
      isEmail = false,
      isErro = false,
      isIconColorPass = false,
      isIconColorEmail = false;
  @override
  void initState() {
    super.initState();
    diemScraper.streamController.stream.listen((msv) async {
      var sinhvien = await diemScraper.getThongTin(msv);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeRoute(
                    sinhvien: sinhvien,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool isValidateEmail(String em) {
      return em.length == 10 ? true : false;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: height * 0.1),
                      child: Image.asset('assets/path@2x.png')),
                  Container(
                    padding: EdgeInsets.only(top: height * 0.05),
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.2,
                          height: width * 0.2,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset:
                                    Offset(1, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset('assets/utc_logo_plash.png'),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Text(
                          'Welcome to \nSchool Map !',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.w600,
                              wordSpacing: 1.5,
                              letterSpacing: 1.5),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: height * 0.33,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03, vertical: height * 0.01),
                      // height: 1000,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.015,
                          ),
                          Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  wordSpacing: 1.5,
                                  letterSpacing: 1.5),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text('ID Student',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextField(
                            controller: emailController,
                            onTap: () {
                              setState(() {
                                focus = true;
                              });
                            },
                            onChanged: (email) {
                              setState(() {
                                isEmail = isValidateEmail(email);
                              });
                              if (email.isNotEmpty) {
                                setState(() {
                                  isErro = true;
                                  isIconColorEmail = true;
                                });
                              } else {
                                setState(() {
                                  isErro = false;
                                  isIconColorEmail = false;
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: height * 0.03),
                                suffixIcon: isEmail
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: width * 0.05,
                                      )
                                    : isErro
                                        ? Icon(
                                            Icons.error,
                                            color: Colors.red,
                                            size: width * 0.05,
                                          )
                                        : null,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: isIconColorEmail
                                      ? Colors.amber
                                      : Colors.grey,
                                ),
                                filled: true,
                                fillColor: Color(0xFFF6F6FF),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      width: 0.5, color: Color(0xff29166F)),
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: '58510710**'),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text('Password',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextField(
                              controller: passController,
                              onTap: () {
                                setState(() {
                                  focus = true;
                                });
                              },
                              onChanged: (pass) {
                                if (pass.isNotEmpty) {
                                  setState(() {
                                    isIconColorPass = true;
                                  });
                                } else {
                                  setState(() {
                                    isIconColorPass = false;
                                  });
                                }
                              },
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: height * 0.03),
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: isIconColorPass
                                        ? Colors.amber
                                        : Colors.grey,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isPass ? isPass = false : isPass = true;
                                      });
                                    },
                                    child: Icon(
                                      isPass
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                      size: width * 0.05,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF6F6FF),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Color(0xff29166F)),
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: '...........'),
                              obscureText: isPass),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          CheckboxListTile(
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            // selected: true,
                            title: Text("Remember me",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300)),
                            value: checkBoxValue,
                            onChanged: (newValue) {
                              setState(() {
                                checkBoxValue = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff29166F))),
                            onPressed: () {
                              saveUserInfo(emailController.text.trim(),
                                  passController.text.trim());
                              diemScraper.streamController.sink
                                  .add(emailController.text.trim());
                            },
                            child: Container(
                              width: width,
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.02),
                              decoration: BoxDecoration(
                                color: Color(0xff29166F),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      wordSpacing: 1.5,
                                      letterSpacing: 1.5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  Size(width, height * 0.06)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                          color: Color(0xff29166F)))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(color: Color(0xff29166F))),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                vertical: height * 0.02,
                              )),
                            ),
                            onPressed: () {
                              diemScraper.streamController.sink
                                  .add('5851071033');
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeRoute(
                                              sinhvien: SinhVien(
                                                  'Sinh viên',
                                                  '5851071044',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  ''),
                                            )));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      child: Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.transparent,
                                  )),
                                  Text(
                                    "Skip",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xff29166F),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        wordSpacing: 1.5,
                                        letterSpacing: 1.5),
                                  ),
                                  Container(
                                      child:
                                          Icon(Icons.arrow_right_alt_outlined))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: focus ? height * 0.002 : 0,
            ),
          ],
        ),
      ),
    );
  }
}
