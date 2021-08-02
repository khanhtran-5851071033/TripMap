import 'package:example/view/screens/tintuc/tintuc.dart';
import 'package:flutter/material.dart';


class Person extends StatefulWidget {
  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff29166F),
        centerTitle: true,
        title: Text(
          'Thành viên',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(horizontal: 8),
              //height: size.width * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue[200].withOpacity(0.5)),
              child: TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: 'Tìm kiếm thành viên'),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 30,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => News()),
                          );
                        },
                        child: Container(
                          // width: size.width,
                          child: _avatar('Khánh Trần', 'Bạn : Helllo friend',
                              '18:30', size),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

Widget _avatar(String name, String content, String time, Size size) {
  return Container(
    width: size.width,
    padding: const EdgeInsets.all(8),
    child: Row(
      children: [
        Stack(
          children: [
            Container(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/logoUTC.png'),
              ),
            ),
            Positioned(
              width: 10,
              height: 10,
              bottom: 0,
              right: 2,
              child: Container(
                padding: EdgeInsets.all(1),
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          width: 7,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _name(name),
              Container(
                width: size.width,
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Text(content),
                    Spacer(),
                    Text(time),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _name(String name) {
  return Text(
    name,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );
}
