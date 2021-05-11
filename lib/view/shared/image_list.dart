import 'package:flutter/material.dart';

List panoImages = [
  [
    Image.asset('assets/cong.jpg'),
    Image.asset('assets/congx2.jpg'),
  ],
  [
    Image.asset('assets/c2.jpg'),
    Image.asset('assets/c2x2.jpg'),
  ],
  [
    Image.asset('assets/ngababaixe.jpg'),
    Image.asset('assets/ngababaixex2.jpg'),
  ],
  [
    Image.asset('assets/nga3sangtao.jpg'),
    Image.asset('assets/nga3sangtaox2.jpg'),
  ],
  [
    Image.asset('assets/saue2.jpg'),
    Image.asset('assets/saue2x2.jpg'),
  ],
  [
    Image.asset('assets/nhaxe.jpg'),
    Image.asset('assets/nhaxex2.jpg'),
  ],
  [
    Image.asset('assets/trcnhaxe.jpg'),
    Image.asset('assets/trcnhaxex2.jpg'),
  ],
  [
    Image.asset('assets/e2.jpg'),
    Image.asset('assets/e2x2.jpg'),
  ],
  [
    Image.asset('assets/e7.jpg'),
    Image.asset('assets/e7x2.jpg'),
  ],
  [
    Image.asset('assets/e10.jpg'),
    Image.asset('assets/e10x2.jpg'),
  ],
  [
    Image.asset('assets/giuae10.jpg'),
    Image.asset('assets/giuae10x2.jpg'),
  ],
  [
    Image.asset('assets/truocc2.jpg'),
    Image.asset('assets/truocc2x2.jpg'),
  ],
  [
    Image.asset('assets/c1c2.jpg'),
    Image.asset('assets/c1c2x2.jpg'),
  ],
];
List hotSpot = [
  //////Cong 0
  [
    {"lat": -10.0, "long": 90.0, "id": 1, "name": 'C2', 'type': 'arrow'},
    {"lat": -10.0, "long": 0.0, "id": 2, "name": 'Nga ba', 'type': 'arrow'},
    //Building
    {"lat": 15.0, "long": 75.0, "id": 1, "name": 'C2', 'type': 'image'},
  ],
  //////C2 1
  [
    {"lat": -10.0, "long": -90.0, "id": 0, "name": 'Cong', 'type': 'arrow'},
    {"lat": -10.0, "long": 90.0, "id": 11, "name": 'C2', 'type': 'arrow'},
  ],
  //////Nga ba bai xe 2
  [
    // {"lat": -0.0, "long": 0.0, "id": 0, "name": 'Cong'},
    {"lat": -10.0, "long": 180.0, "id": 0, "name": 'Cong', 'type': 'arrow'},
    {"lat": -10.0, "long": 90.0, "id": 7, "name": 'E2', 'type': 'arrow'},
    {"lat": -10.0, "long": 0.0, "id": 3, "name": '', 'type': 'arrow'},
  ],
  ///////Nga ba sang tao 3
  [
    {"lat": -10.0, "long": 180.0, "id": 2, "name": 'Nga ba', 'type': 'arrow'},
    {"lat": -10.0, "long": 90.0, "id": 4, "name": 'sau E2', 'type': 'arrow'},
    {"lat": -10.0, "long": 0.0, "id": 8, "name": 'E7', 'type': 'arrow'},
  ],
  ////Sau e2 4
  [
    {"lat": -10.0, "long": 90.0, "id": 5, "name": 'Nha xe', 'type': 'arrow'},
    {
      "lat": -10.0,
      "long": -90.0,
      "id": 3,
      "name": 'nga3 sang tao',
      'type': 'arrow'
    },
  ],
  ////////Nha xe 5
  [
    {
      "lat": -10.0,
      "long": 180.0,
      "id": 6,
      "name": 'Truoc nha xe',
      'type': 'arrow'
    },
    {"lat": -10.0, "long": -90.0, "id": 4, "name": 'sau e2', 'type': 'arrow'},
  ],
  ///////truoc nha xe 6
  [
    {"lat": -10.0, "long": -90.0, "id": 7, "name": 'E2', 'type': 'arrow'},
    {"lat": -10.0, "long": 0.0, "id": 5, "name": 'Nha xe', 'type': 'arrow'},
  ],
  ////////E2 7
  [
    {"lat": -10.0, "long": -90.0, "id": 2, "name": 'Nga ba', 'type': 'arrow'},
    {
      "lat": -10.0,
      "long": 90.0,
      "id": 6,
      "name": 'Truoc nha xe',
      'type': 'arrow'
    },
  ],
  /////E7 8
  [
    {"lat": -10.0, "long": 180.0, "id": 3, "name": 'Nga ba', 'type': 'arrow'},
    {"lat": -10.0, "long": 0.0, "id": 9, "name": 'E10', 'type': 'arrow'},
  ],
  //////E10 9
  [
    {"lat": -10.0, "long": 180.0, "id": 8, "name": 'E7', 'type': 'arrow'},
    {"lat": -10.0, "long": 90.0, "id": 10, "name": '', 'type': 'arrow'},
  ],
  //////giua E10 10
  [
    {"lat": -10.0, "long": -90.0, "id": 9, "name": 'E10', 'type': 'arrow'},
    // {"lat": -10.0, "long": 90.0, "id": 10, "name": '', 'type': 'arrow'},
  ],
  //////truoc C2 11
  [
    {"lat": -10.0, "long": -90.0, "id": 1, "name": 'C2', 'type': 'arrow'},
    {"lat": -10.0, "long": 90.0, "id": 12, "name": 'C1', 'type': 'arrow'},
  ],
  //////C1 C2 12
  [
    {"lat": -10.0, "long": -90.0, "id": 11, "name": 'C2', 'type': 'arrow'},
    // {"lat": -10.0, "long": 90.0, "id": 10, "name": 'C1', 'type': 'arrow'},
  ],
];
