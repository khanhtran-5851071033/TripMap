List<String> panoImages = [
  'cong', //0
  'c2',
  'ngababaixe',
  'nga3sangtao',
  'saue2',
  'nhaxe', //5
  'trcnhaxe',
  'e2',
  'e7',
  'e10',
  'giuae10', //10
  'truocc2',
  'c1c2',
  'sauc2',
  'phongkhaothi',
  'e4nhaxe', //15
  'e5nhaxe',
  'e9',
  'giuae6e9',
];

List<AreHere> youAreHere = [
  AreHere(top: 73, left: 12), //cổng->x
  AreHere(top: 73, left: 20), //C2->x
  AreHere(top: 52, left: 12), //ngã 3 bãi xe->x
  AreHere(top: 40, left: 12), //ngã 3 sáng tạo->x
  AreHere(top: 40, left: 36), //sau E2->x
  AreHere(top: 40, left: 58), //nhà xe->x
  AreHere(top: 52, left: 58), //trc nhà xe-> x
  AreHere(top: 52, left: 40), //E2->x
  AreHere(top: 26, left: 12), //E7->x
  AreHere(top: 12, left: 12), //E10->x
  AreHere(top: 12, left: 23), //Giữa E10->x
  AreHere(top: 73, left: 32), //truovws C2->x
  AreHere(top: 73, left: 43), //C1->x
  ///Sua lai position
  AreHere(top: 73, left: 43), //C1->x
  AreHere(top: 73, left: 43), //C1->x
  AreHere(top: 73, left: 43), //C1->x
  AreHere(top: 73, left: 43), //C1->x
  AreHere(top: 73, left: 43), //C1->x
];

const double frontLong = 0.0;
const double rightLong = 90.0;
const double leftLong = -90.0;
const double behideLong = 180.0;

List<List<MyHotspot>> hotSpot = [
  //////Cong 0
  [
    MyHotspot(1, name: 'C2', long: rightLong),
    MyHotspot(2, name: 'E10-E7-E2', long: frontLong),
    //Building
    MyHotspot(1, name: 'C2', long: 75.0, lat: 25.0, type: HotspotType.image),
    MyHotspot(2,
        name: 'E10', long: 0.0, lat: 5.0, type: HotspotType.image, scale: .4),
    MyHotspot(2,
        name: 'E7', long: 10.0, lat: 5.0, type: HotspotType.image, scale: .4),
    MyHotspot(3,
        name: 'C1', long: 90.0, lat: 7.0, type: HotspotType.image, scale: .6),
    MyHotspot(4,
        name: 'E2', long: 47.0, lat: 12.0, type: HotspotType.image, scale: .5),
    MyHotspot(5,
        name: '450 Lê Văn Việt',
        long: 180.0,
        lat: 15.0,
        type: HotspotType.image,
        scale: .7),
    MyHotspot(5,
        name: 'Cổng chính',
        long: 180.0,
        lat: 5,
        type: HotspotType.image,
        scale: .9),
    MyHotspot(6,
        name: 'Khu đào tạo',
        long: 150.0,
        lat: 25.0,
        type: HotspotType.image,
        scale: .8),
  ],
  //////C2 1//Cổng qua c2
  [
    MyHotspot(13, name: 'Sau C2', long: rightLong - 40),
    MyHotspot(0, name: 'Cổng', long: leftLong),
    MyHotspot(11, name: 'C2', long: rightLong + 10),
    MyHotspot(3, name: 'C1', long: 105.0, type: HotspotType.image, scale: .8),
    MyHotspot(3, name: 'C2', long: 75.0, lat: 20.0, type: HotspotType.image),
    MyHotspot(3,
        name: 'E2', long: 45.0, lat: 20.0, type: HotspotType.image, scale: .7),
    MyHotspot(3, name: 'E10', long: 10.0, type: HotspotType.image, scale: .5),
    MyHotspot(3, name: 'E7', long: 20.0, type: HotspotType.image, scale: .6),
    MyHotspot(6,
        name: 'Khu đào tạo', long: 150.0, lat: 25.0, type: HotspotType.image),
    MyHotspot(5,
        name: 'Cổng chính',
        long: -120.0,
        lat: 20.0,
        scale: .8,
        type: HotspotType.image),
  ],
  //////Nga ba bai xe 2
  [
    MyHotspot(0, name: 'Cổng', long: behideLong),
    MyHotspot(7, name: 'E2', long: rightLong),
    MyHotspot(3, name: 'E10-E7', long: frontLong + 5),
    MyHotspot(5,
        name: 'E2', long: 80, lat: 20.0, type: HotspotType.image, scale: .9),
    MyHotspot(5, name: 'E7', long: 30, type: HotspotType.image, scale: .8),
    MyHotspot(5,
        name: 'E10', long: 5, lat: 5.0, type: HotspotType.image, scale: .6),
    MyHotspot(3,
        name: 'C2', long: 130.0, lat: 14.0, type: HotspotType.image, scale: .6),
    MyHotspot(3,
        name: 'Cổng phụ',
        long: 92,
        lat: 3.0,
        type: HotspotType.image,
        scale: .4),
    MyHotspot(3,
        name: 'Cổng chính',
        long: -177,
        lat: 3.0,
        type: HotspotType.image,
        scale: .4),
  ],
  // ///////Nga ba sang tao 3
  [
    MyHotspot(2, name: 'Cổng-E2', long: behideLong),
    MyHotspot(4, name: 'E3', long: rightLong),
    MyHotspot(8, name: 'E7', long: frontLong + 5),
    MyHotspot(3,
        name: 'E3',
        long: rightLong,
        lat: 7.0,
        type: HotspotType.image,
        scale: .7),
    MyHotspot(3,
        name: 'Cổng', long: -177, lat: 4.0, type: HotspotType.image, scale: .4),
    MyHotspot(3,
        name: 'C2', long: 150, lat: 12.0, type: HotspotType.image, scale: .5),
    MyHotspot(3, name: 'E7', long: 45, type: HotspotType.image, scale: .9),
    MyHotspot(3,
        name: 'E10', long: 10, lat: 5.0, type: HotspotType.image, scale: .6),
    MyHotspot(3, name: 'E2', long: 105, type: HotspotType.image, scale: .9),
  ],
  ////Sau e2 4
  [
    MyHotspot(5, name: 'Nhà xe', long: 100),
    MyHotspot(3, name: 'Ngã ba sáng tạo', long: -80),
    MyHotspot(3,
        name: 'E4', long: 30, lat: 7.0, type: HotspotType.image, scale: .7),
    MyHotspot(3,
        name: 'E3', long: 75, lat: 12.0, type: HotspotType.image, scale: .9),
    MyHotspot(3,
        name: 'E2', long: 180, lat: 5.0, type: HotspotType.image, scale: 1),
    MyHotspot(3,
        name: 'E7', long: -55, lat: 3, type: HotspotType.image, scale: 1),
  ],
  ////////Nha xe 5
  [
    MyHotspot(6, name: 'Trước nhà xe', long: -175),
    MyHotspot(4, name: 'Sau E2', long: -85),
    MyHotspot(3,
        name: 'C3', long: -175, lat: 15.0, type: HotspotType.image, scale: .6),
    MyHotspot(3,
        name: 'C2', long: -145, lat: 15.0, type: HotspotType.image, scale: .4),
    MyHotspot(3,
        name: 'E2', long: -110, lat: 15.0, type: HotspotType.image, scale: .7),
    MyHotspot(3,
        name: 'E4', long: 4, lat: 0.0, type: HotspotType.image, scale: .8),
    MyHotspot(3,
        name: 'E5', long: 6, lat: 5.0, type: HotspotType.image, scale: .6),
    MyHotspot(3,
        name: 'E6', long: 6, lat: 9.0, type: HotspotType.image, scale: .4),
    MyHotspot(3,
        name: 'E9', long: 20, lat: 7.0, type: HotspotType.image, scale: .4),
    MyHotspot(3,
        name: 'Nhà xe',
        long: 170,
        lat: 5.0,
        type: HotspotType.image,
        scale: .9),
    MyHotspot(3,
        name: 'Xưởng cơ khí',
        long: 105,
        lat: 3.0,
        type: HotspotType.image,
        scale: .8),
  ],
  ///////truoc nha xe 6
  [
    MyHotspot(14, name: 'Phòng khảo thí', long: behideLong + 50),
    MyHotspot(7, name: 'E2', long: -80),
    MyHotspot(5, name: 'E3', long: 10),
    MyHotspot(3,
        name: 'C3', long: 180, lat: 20.0, type: HotspotType.image, scale: 1),
    MyHotspot(3,
        name: 'Nhà xe', long: 65, lat: 5.0, type: HotspotType.image, scale: 1),
    MyHotspot(3,
        name: 'Xưởng cơ khí',
        long: 85,
        lat: 8.0,
        type: HotspotType.image,
        scale: .8),
    MyHotspot(3,
        name: 'C2', long: -120, lat: 18.0, type: HotspotType.image, scale: .5),
    MyHotspot(3,
        name: 'Cổng phụ',
        long: 100,
        lat: 5,
        type: HotspotType.image,
        scale: .7),
    MyHotspot(3,
        name: 'E3', long: -5, lat: 7, type: HotspotType.image, scale: .9),
    MyHotspot(3,
        name: 'E9', long: 17, lat: 7, type: HotspotType.image, scale: .4),
    MyHotspot(3,
        name: 'E2', long: -70, lat: 7, type: HotspotType.image, scale: .8),
  ],
  ////////E2 7
  [
    MyHotspot(13, name: 'Sau C2', long: behideLong + 10),
    MyHotspot(2, name: 'Cổng', long: -82),
    MyHotspot(6, name: 'Trước nhà xe', long: 100),
    MyHotspot(3,
        name: 'E2', long: 5, lat: 7.0, type: HotspotType.image, scale: 1),
    MyHotspot(3,
        name: 'C2', long: -170, lat: 15.0, type: HotspotType.image, scale: .8),
    MyHotspot(3,
        name: 'Cổng chính',
        long: -120,
        lat: 17.0,
        type: HotspotType.image,
        scale: .4),
    MyHotspot(3,
        name: 'C3', long: 135, lat: 18.0, type: HotspotType.image, scale: .6),
    MyHotspot(3,
        name: 'Cổng phụ', long: 98, lat: 3, type: HotspotType.image, scale: .5),
    MyHotspot(3,
        name: 'Nhà xe', long: 85, lat: 5, type: HotspotType.image, scale: .7),
    MyHotspot(3,
        name: 'Xưởng cơ khí',
        long: 90,
        lat: 7,
        type: HotspotType.image,
        scale: .6),
  ],
  /////E7 8
  [
    MyHotspot(3, name: 'Ngã ba sáng tạo', long: 175),
    MyHotspot(9, name: 'E10', long: frontLong),
    MyHotspot(3,
        name: 'E10', long: 5, lat: 7.0, type: HotspotType.image, scale: .9),
    MyHotspot(
      3,
      name: 'E7',
      long: 90,
      lat: 7.0,
      type: HotspotType.image,
    ),
    MyHotspot(
      3,
      name: 'Cổng',
      long: 175,
      lat: 5.0,
      scale: .4,
      type: HotspotType.image,
    ),
    MyHotspot(3,
        name: 'E2', long: 125, lat: 12.0, type: HotspotType.image, scale: .6),
    MyHotspot(3,
        name: 'C2', long: 150, lat: 12.0, type: HotspotType.image, scale: .5),
    MyHotspot(
      3,
      name: 'E7',
      long: 90,
      lat: 7.0,
      type: HotspotType.image,
    ),
  ],
  //////E10 9
  [
    MyHotspot(8, name: 'E7', long: behideLong),
    MyHotspot(10, name: 'E6-E5', long: rightLong),
    MyHotspot(3,
        name: 'E10', long: 15, lat: 5.0, type: HotspotType.image, scale: 1),
    MyHotspot(
      3,
      name: 'Cổng',
      long: 180,
      lat: 5.0,
      scale: .4,
      type: HotspotType.image,
    ),
    MyHotspot(3,
        name: 'E2', long: 140, lat: 20.0, type: HotspotType.image, scale: .5),
    MyHotspot(3, name: 'E7', long: 130, type: HotspotType.image, scale: .8),
    MyHotspot(3,
        name: 'E6', long: 70, lat: 12.0, type: HotspotType.image, scale: .7),
    MyHotspot(3,
        name: 'E5', long: 95, lat: 12.0, type: HotspotType.image, scale: .7),
  ],
  //////giua E10 10
  [
    MyHotspot(9, name: 'Cổng', long: leftLong),
    MyHotspot(3,
        name: 'E10', long: 0.0, lat: 5.0, type: HotspotType.image, scale: 1),
    MyHotspot(3, name: 'E7', long: 165, type: HotspotType.image, scale: .8),
    MyHotspot(3,
        name: 'E2', long: 160, lat: 20.0, type: HotspotType.image, scale: .5),
    MyHotspot(3,
        name: 'E6', long: 65, lat: 12.0, type: HotspotType.image, scale: .9),
    MyHotspot(3,
        name: 'E5', long: 95, lat: 12.0, type: HotspotType.image, scale: .9),
  ],
  //////truoc C2 11
  [
    MyHotspot(13, name: 'Sau C2', long: rightLong - 20),
    MyHotspot(1, name: 'Cổng', long: leftLong + 5),
    MyHotspot(12, name: 'C1', long: rightLong + 5),
    MyHotspot(3,
        name: 'C1', long: 95.0, lat: 5.0, type: HotspotType.image, scale: .8),
    MyHotspot(3,
        name: 'Khu đào tạo',
        long: 180.0,
        lat: 10.0,
        type: HotspotType.image,
        scale: .6),
    MyHotspot(3,
        name: 'Cổng',
        long: -110.0,
        lat: 10.0,
        type: HotspotType.image,
        scale: .7),
    MyHotspot(3,
        name: 'C2', long: 80.0, lat: 7.0, type: HotspotType.image, scale: 1),
  ],
  //////C1 C2 12
  [
    MyHotspot(13, name: 'Sau C2', long: leftLong + 30),
    MyHotspot(11, name: 'C2', long: leftLong),
    MyHotspot(3,
        name: 'C1',
        long: rightLong,
        lat: 5.0,
        type: HotspotType.image,
        scale: 1),
    MyHotspot(3,
        name: 'Khu đào tạo',
        long: -170.0,
        lat: 10.0,
        type: HotspotType.image,
        scale: .6),
    MyHotspot(3,
        name: 'Cổng',
        long: -110.0,
        lat: 10.0,
        type: HotspotType.image,
        scale: .5),
    MyHotspot(3,
        name: 'C2', long: -60.0, lat: 7.0, type: HotspotType.image, scale: 1),
  ],
  //////sau C2 13
  [
    MyHotspot(1, name: 'C2', long: leftLong),
    MyHotspot(7, name: 'E2', long: frontLong),
    MyHotspot(14, name: 'Phòng khảo thí', long: rightLong),
    MyHotspot(11, name: 'Trước C2', long: behideLong),
  ],
  //////Phong khao thi 14
  [
    MyHotspot(13, name: 'Sau C2', long: leftLong),
    MyHotspot(6, name: 'Trước nhà xe', long: frontLong),
  ],
  //////E4 nhà xe 15
  [
    MyHotspot(5, name: 'E3 - Nhà xe', long: behideLong),
    MyHotspot(16, name: 'E5 - Nhà xe', long: frontLong),
  ],
  //////E5 nhà xe 16
  [
    MyHotspot(15, name: 'E4 - Nhà xe', long: behideLong),
    MyHotspot(17, name: 'E9', long: frontLong),
  ],
  //////E9 17
  [
    MyHotspot(16, name: 'E5 - Nhà xe', long: behideLong),
    MyHotspot(18, name: 'E6 - E9', long: frontLong),
  ],
];

class MyHotspot {
  int id;
  double lat, long;
  String name;
  HotspotType type;
  double scale;

  MyHotspot(
    this.id, {
    this.lat = -10.0,
    this.long = 0.0,
    this.name = '',
    this.type = HotspotType.arrow,
    this.scale = 1.0,
  });
}

enum HotspotType { arrow, image }

class AreHere {
  double top;
  double left;
  AreHere({this.top, this.left});
}
