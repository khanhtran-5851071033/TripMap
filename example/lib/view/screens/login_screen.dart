import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: width * 0.1,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: width * 0.15,
                    height: width * 0.15,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(1, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/utc_logo_plash.png'),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Welcome to \nTrip Map !',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Image.asset('assets/path@2x.png'),
                  Positioned(
                    bottom: 150,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        // height: 200,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('Email',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.grey,
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
                                  hintText: 'Youremail@st.utc2.edu.vn'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('Password',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.visibility_off,
                                      color: Colors.green,
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
                                obscureText: true)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
