import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isProtected = false, isNotify = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Cài đặt',
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
      body: Container(
          width: size.width,
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.01, horizontal: size.width * 0.03),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chế độ bảo vệ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.05),
                ),
                Switch(
                  value: isProtected,
                  onChanged: (value) {
                    setState(() {
                      isProtected = value;
                    });
                  },
                  activeColor: Color(0xff29166F),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
                'TripMap sẽ bảo vệ an toàn cho bạn khi gặp sự cố hay vấn đề sức khỏe không đảm bảo và tránh bị thất lạc thiết bị. Bạn có thể thiết lập thời gian cho việc gửi thông tin vị trí của bạn để TripMap có thể tìm được bạn một cách nhanh và an toàn nhất !'),
            SizedBox(
              height: size.height * 0.1,
            ),
            Row(
              children: [
                Text('Thời gian'),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue[200].withOpacity(0.2)),
                  //color: Colors.blue[200].withOpacity(0.5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timelapse,
                        color: Color(0xff29166F),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '17:00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Color(0xff29166F)),
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Color(0xff29166F),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: size.height * 0.04,
              thickness: 0.2,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bật thông báo',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.04),
                ),
                Switch(
                  value: isNotify,
                  onChanged: (value) {
                    setState(() {
                      isNotify = value;
                    });
                  },
                  activeColor: Color(0xff29166F),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
                'Nhận thông báo từ TripMap để cập nhật thông tin một cách hiệu quả.'),
          ])),
    );
  }
}
