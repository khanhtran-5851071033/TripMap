import 'package:example/view/shared/image_list.dart';
import 'package:example/view/shared/util.dart';
import 'package:example/view/widgets/hotspot_button.dart';
import 'package:flutter/material.dart';

import 'package:panorama/panorama.dart';
import 'package:avatar_glow/avatar_glow.dart';

class PanoScreen extends StatefulWidget {
  PanoScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PanoScreenState createState() => _PanoScreenState();
}

class _PanoScreenState extends State<PanoScreen> {
  // double _lon = 0;
  // double _lat = 0;
  // double _tilt = 0;
  double _zoom = 1.0, animSpeed = 0.01;
  int _panoId = 0, imageSize = 0;
  int curId = 0;

  // void onViewChanged(longitude, latitude, tilt) {
  //   setState(() {
  //     _lon = longitude;
  //     _lat = latitude;
  //     _tilt = tilt;
  //   });
  // }
  void onHotspotTap(MyHotspot hotspot) {
    setState(() {
      // animSpeed = 0.01;
      imageSize = 0;
      _panoId = hotspot.id;
      _zoom = 1;
      curId = hotspot.id;
    });
    Future.delayed(Duration(milliseconds: 500), () {
      if (hotspot.id == curId) {
        setState(() {
          imageSize = 1;
        });
      }
    });
  }

  Widget panoramaWidget(int id) {
    var pano = Panorama(
      animSpeed: animSpeed,
      zoom: 1,
      minZoom: 0,
      maxZoom: 5,
      sensitivity: 1.5,
      interactive: true,
      sensorControl: SensorControl.Orientation,
      // onViewChanged: onViewChanged,
      onTap: (longitude, latitude, tilt) {
        if (animSpeed == 1) {
          setState(() {
            animSpeed = 0.01;
          });
        } else {
          setState(() {
            animSpeed = 1;
          });
        }
      },

      ///////////////////////////IMAGE////////////////////////////////////////
      child: Image.asset(
        'assets/image_360/' +
            panoImages[id] +
            (imageSize == 0 ? '' : 'x2') +
            '.jpg',
      ),

      latitude: 0,
      longitude: 0,
      hotspots: hotSpot.length - 1 < id
          ? []
          : List.generate(hotSpot[id].length, (index) {
              return Hotspot(
                latitude: hotSpot[id][index].lat,
                longitude: hotSpot[id][index].long,
                width: 120,
                height: 100,
                widget: hotspotButton(hotSpot[id][index], () {
                  onHotspotTap(hotSpot[id][index]);
                }),
              );
            }),
    );
    return pano;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          imageSize = 1;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget panorama;

    // switch (_panoId % panoImages.length) {
    //   case 0:
    //     panorama = panoramaWidget(1);
    //     break;
    //   case 2:
    //     panorama = panoramaWidget(2);
    //     break;
    //   default:
    //     panorama = panoramaWidget(0);
    // }
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Stack(
        children: [
          panoramaWidget(_panoId),
          Positioned(
              left: 0,
              bottom: 30,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.white54,
                    child: Hero(
                        tag: 'mapUtc2', child: Image.asset('assets/1305.png'))),
              ))
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   mini: true,
      //   onPressed: () {
      //     ImagePicker.pickImage(source: ImageSource.gallery).then((value) {
      //       setState(() {
      //         panoImages.add(Image.file(value));
      //         _panoId = panoImages.length - 1;
      //       });
      //     });
      //   },
      //   child: Icon(Icons.panorama),
      // ),
    );
  }
}
