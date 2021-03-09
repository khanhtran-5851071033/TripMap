import 'dart:io';

import 'package:countup/countup.dart';
import 'package:example/view/screens/editProFile.dart';
import 'package:example/view/screens/login_screen.dart';
import 'package:example/view/screens/point_table_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProFile extends StatefulWidget {
  @override
  _ProFileState createState() => _ProFileState();
}

class _ProFileState extends State<ProFile> {
  List buttonList = [
    {'title': 'Thông tin cá nhân', 'icon': Icons.person_pin},
    {'title': 'Bảng điểm học tập', 'icon': Icons.poll_outlined},
    {'title': 'Trợ giúp', 'icon': Icons.help_outline_outlined},
    {'title': 'Chia sẻ Trip Map với bạn bè', 'icon': Icons.share},
    {'title': 'Đánh giá ứng dụng', 'icon': Icons.star},
    {'title': 'Cài đặt', 'icon': Icons.settings},
    {'title': 'Đăng xuất', 'icon': Icons.exit_to_app},
  ];
  List<Widget> screen = [
    EditProFile(),
    PointTableScreen(),
    EditProFile(),
    EditProFile(),
    EditProFile(),
    EditProFile(),
    LoginScreen(),
  ];
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff29166F),
      appBar: AppBar(
        backgroundColor: Color(0xff29166F),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Tài khoản',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          // color: Colors.white,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Center(child: _avatar(_image, size, linkImage)),
                SizedBox(
                  height: size.height * 0.02,
                ),
                _name('Khánh Trần', size),
                SizedBox(
                  height: size.height * 0.035,
                ),
                _calculatorPoint(size, 16, 243, 61),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.025,
                  color: Colors.grey[200],
                ),
                Container(
                    height: size.height * 0.7,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: buttonList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                screen[index]));
                                  },
                                  leading: Icon(
                                    buttonList[index]['icon'],
                                    color: Color(0xff29166F),
                                  ),
                                  title: Text(
                                    buttonList[index]['title'],
                                  ),
                                  trailing: index == buttonList.length - 1
                                      ? null
                                      : Icon(
                                          Icons.arrow_forward_ios,
                                          size: size.width * 0.04,
                                        ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.15),
                                child: index == buttonList.length - 1
                                    ? null
                                    : Divider(
                                        height: 15,
                                        thickness: 0.2,
                                        color: Colors.black54,
                                      ),
                              ),
                            ],
                          );
                        })),
              ]),
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

Widget _name(String name, Size size) {
  return Text(name,
      style: TextStyle(
          color: Color(0xff29166F),
          fontSize: size.width * 0.05,
          fontWeight: FontWeight.w600));
}

Widget _level(String level, Size size) {
  return Row(
    children: [
      Icon(Icons.emoji_events,
          color: Colors.amber[600], size: size.width * 0.04),
      Text(level,
          style:
              TextStyle(color: Colors.amber[600], fontSize: size.width * 0.04)),
    ],
  );
}

_textValue(int value, Size size) {
  return Countup(
      begin: 0,
      end: value.toDouble(),
      duration: Duration(seconds: 2),
      separator: ',',
      style: TextStyle(
        color: Color(0xffF3D400),
        fontSize: size.width * 0.05,
        fontWeight: FontWeight.bold,
      ));
}

_textWhite(String value, Size size) {
  return Text(value,
      style: TextStyle(
        color: Color(0xff00104F),
        fontSize: size.width * 0.035,
      ));
}

Widget _calculatorPoint(Size size, int value1, int value2, int value3) {
  return Container(
    width: size.width,
    padding: EdgeInsets.symmetric(
      horizontal: size.width * 0.02,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * 0.9 / 3,
          child: Column(
            children: [
              _textValue(value1, size),
              SizedBox(
                height: size.height * 0.01,
              ),
              _textWhite('Bài viết', size),
            ],
          ),
        ),
        Container(
          width: size.width * 0.9 / 3,
          decoration: BoxDecoration(
            border: Border.symmetric(
                vertical: BorderSide(
              width: 0.2,
            )),
          ),
          child: Column(
            children: [
              _textValue(value2, size),
              SizedBox(
                height: size.height * 0.01,
              ),
              _textWhite('Lượt thích', size),
            ],
          ),
        ),
        Container(
          width: size.width * 0.9 / 3,
          child: Column(
            children: [
              _textValue(value3, size),
              SizedBox(
                height: size.height * 0.01,
              ),
              _textWhite('Bình luận', size),
            ],
          ),
        ),
      ],
    ),
  );
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 3);
    path.arcToPoint(Offset(size.width, size.height),
        radius: Radius.elliptical(30, 10));
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
