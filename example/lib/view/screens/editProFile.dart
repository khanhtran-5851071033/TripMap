import 'package:flutter/material.dart';

class EditProFile extends StatefulWidget {
  @override
  _EditProFileState createState() => _EditProFileState();
}

class _EditProFileState extends State<EditProFile> {
  bool focus,
      isEmail = false,
      isErro = false,
      isIconColorPass = false,
      isIconColorEmail = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isValidateEmail(String em) {
      String p =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regExp = new RegExp(p);

      return regExp.hasMatch(em);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Thông tin tài khoản',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              //-----------------------------------------------------------
              Text('Name',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              SizedBox(
                height: height * 0.02,
              ),
              TextField(
                onTap: () {
                  setState(() {
                    focus = true;
                  });
                },
                onChanged: (name) {
                  if (name.isNotEmpty) {
                    setState(() {});
                  } else {
                    setState(() {});
                  }
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: height * 0.03),
                    // suffixIcon: isEmail
                    //     ? Icon(
                    //         Icons.check_circle,
                    //         color: Colors.green,
                    //         size: width * 0.05,
                    //       )
                    //     : isErro
                    //         ? Icon(
                    //             Icons.error,
                    //             color: Colors.red,
                    //             size: width * 0.05,
                    //           )
                    //         : null,
                    // prefixIcon: Icon(
                    //   Icons.email_outlined,
                    //   color: isIconColorEmail ? Colors.amber : Colors.grey,
                    // ),
                    filled: true,
                    fillColor: Color(0xFFF6F6FF),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xff29166F)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Your name'),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              //-----------------------------------------------------------
              Text('Date of birth',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              SizedBox(
                height: height * 0.02,
              ),
              TextField(
                onTap: () {
                  setState(() {
                    focus = true;
                  });
                },
                onChanged: (date) {
                  if (date.isNotEmpty) {
                    setState(() {});
                  } else {
                    setState(() {});
                  }
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: height * 0.03),
                    // suffixIcon: isEmail
                    //     ? Icon(
                    //         Icons.check_circle,
                    //         color: Colors.green,
                    //         size: width * 0.05,
                    //       )
                    //     : isErro
                    //         ? Icon(
                    //             Icons.error,
                    //             color: Colors.red,
                    //             size: width * 0.05,
                    //           )
                    //         : null,
                    // prefixIcon: Icon(
                    //   Icons.email_outlined,
                    //   color: isIconColorEmail ? Colors.amber : Colors.grey,
                    // ),
                    filled: true,
                    fillColor: Color(0xFFF6F6FF),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xff29166F)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'select day'),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              //-----------------------------------------------------------
              Text('Email',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              SizedBox(
                height: height * 0.02,
              ),
              TextField(
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
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: height * 0.03),
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
                      color: isIconColorEmail ? Colors.amber : Colors.grey,
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6FF),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xff29166F)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'msv@st.utc2.edu.vn'),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              //-----------------------------------------------------------
              Text('Phone number',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              SizedBox(
                height: height * 0.02,
              ),
              TextField(
                onTap: () {
                  setState(() {
                    focus = true;
                  });
                },
                onChanged: (email) {
                  setState(() {});
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
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: height * 0.03),
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
                      color: isIconColorEmail ? Colors.amber : Colors.grey,
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6FF),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xff29166F)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Your phone number'),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              RaisedButton(
                color: Color(0xff29166F),
                onPressed: () {},
                child: Container(
                  width: width,
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  decoration: BoxDecoration(
                    color: Color(0xff29166F),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Center(
                    child: Text(
                      'Update',
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
            ],
          ),
        ),
      ),
    );
  }
}
