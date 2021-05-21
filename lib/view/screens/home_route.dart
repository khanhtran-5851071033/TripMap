import 'package:example/model/sinh_vien.dart';
import 'package:example/view/screens/home/home_screen.dart';
import 'package:example/view/screens/profile/profile.dart';
import 'package:example/view/screens/share.dart';
import 'package:example/view/screens/member/thanhvien.dart';
import 'package:example/view/screens/tintuc/tintuc.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {
  final SinhVien sinhvien;
  HomeRoute({this.sinhvien});
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  int curIndex = 0;
  PageController _controller;
  List buttonList = [
    {'title': 'Bản đồ', 'icon': Icons.location_pin},
    {'title': 'Tin tức', 'icon': Icons.notifications},
    {'title': 'Chia sẻ', 'icon': Icons.share},
    {'title': 'Thành viên', 'icon': Icons.people},
    {'title': 'Tài khoản', 'icon': Icons.person},
  ];
  void naviPage(int index, bool isJump) {
    if (isJump) _controller.jumpToPage(index);
    setState(() {
      curIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          naviPage(index, false);
        },
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(sinhvien: widget.sinhvien),
          News(),
          ShareFriend(),
          Person(),
          ProFile(sinhvien: widget.sinhvien),
        ],
      ),
      // IndexedStack(
      //   // physics: NeverScrollableScrollPhysics(),
      //   // controller: _controller,
      //   index: curIndex,
      //   children: <Widget>[
      //     FloorPlanScreen(),
      //     LoginScreen(),
      //     LoginScreen(),
      //     LoginScreen(),
      //     LoginScreen(),
      //   ],
      //   // onPageChanged: (index) {
      //   //   toggleNaviButton(index);
      //   // },
      // ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.075,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(buttonList.length, (index) {
                  return NaviButton(
                    icon: buttonList[index]['icon'],
                    navi: () {
                      naviPage(index, true);
                    },
                    title: buttonList[index]['title'],
                    iconColor:
                        index == curIndex ? Colors.purple[900] : Colors.grey,
                  );
                }),
              ))),
    );
  }
}

class NaviButton extends StatefulWidget {
  final VoidCallback navi;
  final String title;
  final IconData icon;
  final Color iconColor;
  NaviButton({this.navi, this.title, this.icon, this.iconColor});

  @override
  _NaviButtonState createState() => _NaviButtonState();
}

class _NaviButtonState extends State<NaviButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.navi,
      child: Container(
        width: width / 5 - 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: widget.iconColor,
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 10, color: widget.iconColor),
            ),
          ],
        ),
      ),
    );
  }
}
