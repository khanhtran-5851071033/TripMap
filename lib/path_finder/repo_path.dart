import 'dart:ui';

import 'package:example/model/end_point.dart';

var listDiem = [
  [ 0, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //1
  [ 72, 0, 0, 0, 0, 0, 0, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 238, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 108, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 70, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //5
  [ 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 128, 0, 60, 0, 0, 0, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 55, 0, 0, 0, 60, 0, 82, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 55, 0, 0, 0, 82, 0, 0, 0, 0, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 150, 0, 0, 0, 0, 0, 0, 0, 0, 155, 0, 0, 0, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //10
  [ 0, 0, 0, 0, 0, 95, 0, 0, 0, 55, 0, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 95, 0, 0, 0, 128, 0, 142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 95, 0, 0, 142, 0, 198, 0, 0, 0, 116, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 121, 0, 0, 0, 0, 0, 230, 0, 0, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //15
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 230, 0, 20, 0, 0, 0, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 140, 0, 0, 0, 94, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0 ], //17
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 116, 0, 0, 0, 140, 0, 0, 0, 0, 0, 92, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 121, 0, 0, 0, 0, 153, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 153, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //20
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 121, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //21
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 94, 0, 0, 0, 40, 0, 140, 0, 94, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0 ], //22
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 92, 0, 0, 0, 140, 0, 0, 0, 92, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 88, 0, 0, 0, 0, 0, 0 ], //24
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 94, 0, 0, 0, 140, 77, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 92, 0, 140, 0, 0, 0, 0, 92, 0, 0, 0, 0, 70, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 77, 0, 0, 66, 0, 0, 0, 0, 178, 0, 0, 0, 0, 0, 0 ], //27
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0 ], //28
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 70, 0, 0, 0, 0, 0 ], //29
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 92, 0, 0, 55, 0, 87, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 87, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 238, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 88, 0, 0, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //33 e10
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //34 e6
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //35 e5
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //36 e4
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //3
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 86 ], //38 nhà xe
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 86, 0 ],
];
List<EndPoint> listBuilding = [
  EndPoint(1, 'Cổng chính', Offset(75, 360),'assets/image.png'),
  EndPoint(2, '', Offset(75, 317),''),
  EndPoint(3, 'C1', Offset(213, 317),'assets/utc3_17.jpg',),
  EndPoint(4, '', Offset(250, 310),''),
  EndPoint(5, 'C3', Offset(280, 310),'assets/utc3_5.jpg',),
  EndPoint(6, '', Offset(142, 288),''),
  EndPoint(7, '', Offset(184, 288),''),
  EndPoint(8, '', Offset(213, 288),''),
  EndPoint(9, 'Phòng khảo thí', Offset(250, 288),'assets/utc3_6.jpg'),
  EndPoint(10, '', Offset(75, 236),''),
  EndPoint(11, '', Offset(142, 236),''),
  EndPoint(12, 'E2', Offset(184, 236),'assets/utc3_8.jpg'),
  EndPoint(13, '', Offset(256, 236),''),
  EndPoint(14, 'Cổng\nphụ', Offset(350, 236),'assets/image.png'),
  EndPoint(15, '', Offset(75, 185),''),
  EndPoint(16, '', Offset(172, 185),''),
  EndPoint(17, '', Offset(190, 185),''),
  EndPoint(18, '', Offset(256, 185),''),
  EndPoint(19, '', Offset(75, 130),''),
  EndPoint(20, 'E7', Offset(140, 130),'assets/utc3_14.jpg'),
  EndPoint(21, '', Offset(172, 135),''),
  EndPoint(22, '', Offset(190, 135),''),
  EndPoint(23, '', Offset(256, 135),''),
  EndPoint(24, '', Offset(75, 60),''),
  EndPoint(25, '', Offset(190, 90),''),
  EndPoint(26, '', Offset(256, 90),''),
  EndPoint(27, '', Offset(190, 60),''),
  EndPoint(28, '', Offset(190, 30),''),
  EndPoint(29, '', Offset(256, 30),''),
  EndPoint(30, '', Offset(256, 45),''),
  EndPoint(31, 'E9', Offset(290, 45),'assets/utc3_12.jpg'),
  EndPoint(32, 'C2', Offset(180, 310),'assets/image.png',),
  EndPoint(33, 'E10', Offset(120, 55),'assets/utc3_15.jpg',),
  EndPoint(34, 'E6', Offset(220, 30),'assets/utc3_12.jpg'),
  EndPoint(35, 'E5', Offset(220, 90),'assets/utc3_12.jpg'),
  EndPoint(36, 'E4', Offset(220, 135),'assets/utc3_3.jpg'),
  EndPoint(37, 'E3', Offset(220, 185),'assets/utc3_12.jpg'),
  EndPoint(38, 'Nhà xe', Offset(280, 236),'assets/utc3_8.jpg'),
  EndPoint(39, 'Xưởng', Offset(320, 236),'assets/utc3_8.jpg'),
  EndPoint(40, 'Đường Lê Văn Việt', Offset(180, 390),'assets/utc3_7.jpg'),
  EndPoint(41, 'Đường 455', Offset(364, 345),'assets/utc3_7.jpg'),
];
