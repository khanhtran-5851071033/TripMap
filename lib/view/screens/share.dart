import 'package:example/view/screens/member/thanhvien.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShareFriend extends StatefulWidget {
  @override
  _ShareFriendState createState() => _ShareFriendState();
}

class _ShareFriendState extends State<ShareFriend> {
  bool isLike = false;
  bool isComment = false;
  int numberLike = 30;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff29166F),
          leading: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Person()),
              );
            },
            child: Icon(
              Icons.photo_camera,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Chia sẻ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
            physics: BouncingScrollPhysics(),

            // padding: const EdgeInsets.all(8),
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                // margin: EdgeInsets.only(bottom: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _avatar('Khánh Trần', '5 giờ'),
                      _image(size, context),
                      _status('Xin chào Utc2'),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            _numberlike(numberLike.toString()),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isLike ? isLike = false : isLike = true;
                                  isLike ? numberLike++ : numberLike--;
                                });
                              },
                              child: isLike
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_outline,
                                      color: Colors.black,
                                    ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            _numbercommnent('1'),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isComment
                                      ? isComment = false
                                      : isComment = true;
                                });
                              },
                              child: isComment
                                  ? Icon(
                                      Icons.comment,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.comment,
                                      color: Colors.blue,
                                    ),
                            )
                          ],
                        ),
                      ),
                      isComment
                          ? Container()
                          : Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/logoUTC.png'),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.blue[50]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _name('Phan Nên'),
                                              Text('Hello friend'),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('2 giờ'),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text('Thích'),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text('Trả lời'),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      Container(
                        height: 15,
                        color: Colors.grey[200],
                        width: size.width,
                      ),
                    ]),
              );
            }));
  }
}

Widget _avatar(String name, String time) {
  return Container(
    padding: const EdgeInsets.all(8),
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/logoUTC.png'),
        ),
        SizedBox(
          width: 7,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _name(name),
            Text(time),
          ],
        )
      ],
    ),
  );
}

Widget _status(String status) {
  return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        status,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ));
}

Widget _image(Size size, BuildContext context) {
  return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: PhotoView(
              imageProvider: AssetImage('assets/utc3_15.jpg'),
            ),
          );
        }));
      },
      child:
          Container(width: size.width, child: Image.asset('assets/utc3_15.jpg')));
}

Widget _name(String name) {
  return Text(
    name,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );
}

Widget _numberlike(String status) {
  return Text(
    status,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
  );
}

Widget _numbercommnent(String status) {
  return Text(
    status,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
  );
}
