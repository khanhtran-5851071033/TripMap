import 'package:example/view/shared/image_list.dart';
import 'package:example/view/shared/util.dart';
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

  Widget hotspotButton(int id, String text, String type) {
    return Transform(
      transform: type == 'arrow'
          ? (Matrix4.identity()..rotateX(150))
          : (Matrix4.identity()..rotateX(0)),
      child: AvatarGlow(
        glowColor:
            type == 'arrow' ? Colors.amber.withOpacity(0.8) : Color(0xff29166F),
        endRadius: 50.0,
        duration: Duration(milliseconds: 1500),
        repeat: true,
        // showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        child: InkWell(
          child: type == 'arrow'
              ? Container(
                  padding: EdgeInsets.all(2),
                  width: 80,
                  height: 70,
                  decoration: BoxDecoration(
                    color: type == 'arrow'
                        ? Colors.amber.withOpacity(0.5)
                        : Color(0xff29166F),
                    shape:
                        type == 'arrow' ? BoxShape.circle : BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Icon(
                            Icons.double_arrow,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 100,
                    color: Color(0xff29166F),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          text,
                          style: TextStyle(color: Colors.white),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Image.asset(
                          'assets/utc.png',
                          fit: BoxFit.fitWidth,
                          // height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
          onTap: () {
            setState(() {
              // animSpeed = 0.01;
              imageSize = 0;
              _panoId = id;
              _zoom = 1;
              curId = id;
            });
            Future.delayed(Duration(milliseconds: 800), () {
              if (id == curId) {
                setState(() {
                  imageSize = 1;
                });
              }
            });
          },
        ),
      ),
    );
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
      hotspots: List.generate(hotSpot[id].length, (index) {
        return Hotspot(
          latitude: hotSpot[id][index]['lat'],
          longitude: hotSpot[id][index]['long'],
          width: 120,
          height: 100,
          widget: hotspotButton(hotSpot[id][index]['id'],
              hotSpot[id][index]['name'], hotSpot[id][index]['type']),
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
