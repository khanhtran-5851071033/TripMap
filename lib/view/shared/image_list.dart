List<String> panoImages = [
  'cong',
  'c2',
  'ngababaixe',
  'nga3sangtao',
  'saue2',
  'nhaxe',
  'trcnhaxe',
  'e2',
  'e7',
  'e10',
  'giuae10',
  'truocc2',
  'c1c2',
];

const double frontLong = 0.0;
const double rightLong = 90.0;
const double leftLong = -90.0;
const double behideLong = 180.0;

List<List<MyHotspot>> hotSpot = [
  //////Cong 0
  [
    MyHotspot(1, name: 'C2', long: rightLong),
    MyHotspot(2, name: 'Ngã ba', long: frontLong),
    //Building
    MyHotspot(1, name: 'C2', long: 75.0, lat: 15.0, type: HotspotType.image),
  ],
  //////C2 1
  [
    MyHotspot(0, name: 'Cổng', long: leftLong),
    MyHotspot(11, name: 'C2', long: rightLong),
  ],
  //////Nga ba bai xe 2
  [
    MyHotspot(0, name: 'Cổng', long: behideLong),
    MyHotspot(7, name: 'E2', long: rightLong),
    MyHotspot(3, name: '', long: frontLong),
  ],
  // ///////Nga ba sang tao 3
  // [
  //   {
  //     "lat": lat,
  //     "long": behideLong,
  //     "id": 2,
  //     "name": 'Nga ba',
  //     'type': arrow
  //   },
  //   {"lat": lat, "long": rightLong, "id": 4, "name": 'sau E2', 'type': arrow},
  //   {"lat": lat, "long": frontLong, "id": 8, "name": 'E7', 'type': arrow},
  // ],
  // ////Sau e2 4
  // [
  //   {"lat": lat, "long": rightLong, "id": 5, "name": 'Nha xe', 'type': arrow},
  //   {
  //     "lat": lat,
  //     "long": leftLong,
  //     "id": 3,
  //     "name": 'nga3 sang tao',
  //     'type': arrow
  //   },
  // ],
  // ////////Nha xe 5
  // [
  //   {
  //     "lat": lat,
  //     "long": behideLong,
  //     "id": 6,
  //     "name": 'Truoc nha xe',
  //     'type': arrow
  //   },
  //   {"lat": lat, "long": leftLong, "id": 4, "name": 'sau e2', 'type': arrow},
  // ],
  // ///////truoc nha xe 6
  // [
  //   {"lat": lat, "long": leftLong, "id": 7, "name": 'E2', 'type': arrow},
  //   {"lat": lat, "long": frontLong, "id": 5, "name": 'Nha xe', 'type': arrow},
  // ],
  // ////////E2 7
  // [
  //   {"lat": lat, "long": leftLong, "id": 2, "name": 'Nga ba', 'type': arrow},
  //   {
  //     "lat": lat,
  //     "long": rightLong,
  //     "id": 6,
  //     "name": 'Truoc nha xe',
  //     'type': arrow
  //   },
  // ],
  // /////E7 8
  // [
  //   {
  //     "lat": lat,
  //     "long": behideLong,
  //     "id": 3,
  //     "name": 'Nga ba',
  //     'type': arrow
  //   },
  //   {"lat": lat, "long": frontLong, "id": 9, "name": 'E10', 'type': arrow},
  // ],
  // //////E10 9
  // [
  //   {"lat": lat, "long": behideLong, "id": 8, "name": 'E7', 'type': arrow},
  //   {"lat": lat, "long": rightLong, "id": 10, "name": '', 'type': arrow},
  // ],
  // //////giua E10 10
  // [
  //   {"lat": lat, "long": leftLong, "id": 9, "name": 'E10', 'type': arrow},
  //   // {"lat": lat, "long": rightLong, "id": 10, "name": '', 'type': arrow},
  // ],
  // //////truoc C2 11
  // [
  //   {"lat": lat, "long": leftLong, "id": 1, "name": 'C2', 'type': arrow},
  //   {"lat": lat, "long": rightLong, "id": 12, "name": 'C1', 'type': arrow},
  // ],
  // //////C1 C2 12
  // [
  //   {"lat": lat, "long": leftLong, "id": 11, "name": 'C2', 'type': arrow},
  //   // {"lat": lat, "long": rightLong, "id": 10, "name": 'C1', 'type': arrow},
  // ],
];

class MyHotspot {
  int id;
  double lat, long;
  String name;
  HotspotType type;

  MyHotspot(this.id,
      {this.lat = -10.0,
      this.long = 0.0,
      this.name = '',
      this.type = HotspotType.arrow});
}

enum HotspotType { arrow, image }
