import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: Size.zero,
        child: Container(
          // color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Container(
            //color: Colors.white,
            height: 35,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    color: Color(0xffF6F6FF),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Tìm kiếm',
                    suffixIcon: Container(
                      width: 10,
                      height: 10,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.directions,
                        color: Color(0xff29166F),
                      ),
                    ),
                    fillColor: Color(0xffF6F6FF),
                    filled: true,
                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none,
                  ),
                )),
          ),
        ),
      ),
      backgroundColor: Colors.yellow[800],
    );
  }
}
