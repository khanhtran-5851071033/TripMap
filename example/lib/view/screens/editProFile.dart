import 'dart:io';

import 'package:example/model/sinh_vien.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProFile extends StatefulWidget {
  final SinhVien sinhvien;
  EditProFile({this.sinhvien});
  @override
  _EditProFileState createState() => _EditProFileState();
}

class _EditProFileState extends State<EditProFile> {
  bool focus,
      isEmail = false,
      isPhone = false,
      isErro = false,
      isErroPhone = false,
      isIconColorName = false,
      isIconColorEmail = false,
      isIconColorDate = false,
      isIconColorPhone = false;
  File _image;
  String linkImage;
  final picker = ImagePicker();
  Future getImage(bool isCamere, int id) async {
    final pickedFile = await picker.getImage(
        source: isCamere ? ImageSource.gallery : ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Thông tin tài khoản',
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
              Center(child: _avatar(_image, size, linkImage)),
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
                    setState(() {
                      isIconColorName = true;
                    });
                  } else {
                    setState(() {
                      isIconColorName = false;
                    });
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
                    prefixIcon: Icon(
                      Icons.person,
                      color: isIconColorName ? Colors.amber : Colors.grey,
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6FF),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xff29166F)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: widget.sinhvien.hoten),
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
                    setState(() {
                      isIconColorDate = true;
                    });
                  } else {
                    setState(() {
                      isIconColorDate = false;
                    });
                  }
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: height * 0.03),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                      size: width * 0.07,
                    ),
                    //     : isErro
                    //         ? Icon(
                    //             Icons.error,
                    //             color: Colors.red,
                    //             size: width * 0.05,
                    //           )
                    //         : null,
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: isIconColorDate ? Colors.amber : Colors.grey,
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6FF),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xff29166F)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: widget.sinhvien.ngaysinh +
                        ' / ' +
                        widget.sinhvien.noisinh),
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
                    hintText: widget.sinhvien.msv + '@st.utc2.edu.vn'),
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
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number,
                onTap: () {
                  setState(() {
                    focus = true;
                  });
                },
                onChanged: (number) {
                  setState(() {});
                  if (number.isNotEmpty) {
                    setState(() {
                      isErroPhone = true;
                      isIconColorPhone = true;
                    });
                  } else {
                    setState(() {
                      isErroPhone = false;
                      isIconColorPhone = false;
                    });
                  }
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(
                      0,
                      height * 0.03,
                      0,
                      height * 0.03,
                    ),
                    suffixIcon: isPhone
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: width * 0.05,
                          )
                        : isErroPhone
                            ? Icon(
                                Icons.error,
                                color: Colors.red,
                                size: width * 0.05,
                              )
                            : null,
                    // prefixIcon: Icon(
                    //   Icons.phone,
                    //   color: isIconColorPhone ? Colors.amber : Colors.grey,
                    // ),

                    prefixIcon: Container(
                      height: 25,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/flagvn.jpg'),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              '+84',
                              style: TextStyle(
                                color: isIconColorPhone
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF6F6FF),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xff29166F)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText:
                        widget.sinhvien.lop + ' / ' + widget.sinhvien.hedaotao),
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

Widget _avatar(File path, Size size, String imageLink) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: size.width * 0.26,
        height: size.width * 0.26,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                width: 1, color: Colors.greenAccent, style: BorderStyle.solid),
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],

          // border: Border.all(
          //     width: 3, color: Colors.green, style: BorderStyle.solid),
          image: (imageLink != null)
              ? DecorationImage(
                  image: NetworkImage(
                    imageLink,
                    // placeholder: (context, url) =>
                    //     CupertinoActivityIndicator(),
                  ),
                  fit: BoxFit.cover,
                )
              : (path == null)
                  ? DecorationImage(
                      image: AssetImage('assets/logoUTC.png'),
                      fit: BoxFit.cover)
                  : DecorationImage(
                      image: Image.file(path).image, fit: BoxFit.cover),

          //  (path == null)
          //     ? imageLink == null
          //         ? DecorationImage(
          //             image: AssetImage('assets/images/level/zalo.png'),
          //             fit: BoxFit.cover)
          //         : DecorationImage(
          //             image: NetworkImage(
          //               myImageEndPoint + '/upload/Customer/2021-1/2212021141355455052129427.jpg',
          //               // placeholder: (context, url) =>
          //               //     CupertinoActivityIndicator(),
          //             ),
          //             fit: BoxFit.cover,
          //           )
          //     : DecorationImage(
          //         image: Image.file(path).image, fit: BoxFit.cover),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {},
          child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.add_a_photo,
                color: Colors.grey,
                size: 16,
              )),
        ),
      )
    ],
  );
}
