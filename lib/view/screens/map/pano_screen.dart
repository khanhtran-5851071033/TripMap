import 'package:avatar_glow/avatar_glow.dart';
import 'package:example/view/shared/image_list.dart';
import 'package:example/view/widgets/hotspot_button.dart';
import 'package:flutter/material.dart';

import 'package:panorama/panorama.dart';

class PanoScreen extends StatefulWidget {
  @override
  _PanoScreenState createState() => _PanoScreenState();
}

class _PanoScreenState extends State<PanoScreen> {
  // double _lon = 0;
  // double _lat = 0;
  // double _tilt = 0;
  double animSpeed = 0.01;
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
      zoom: 0.7,
      minZoom: 0.5,
      maxZoom: 5.0,
      sensitivity: 1.8,
      interactive: true,
      sensorControl: SensorControl.Orientation,
      // onViewChanged: onViewChanged,
      onTap: (longitude, latitude, tilt) {
        if (animSpeed == 2) {
          setState(() {
            animSpeed = 0.01;
          });
        } else {
          setState(() {
            animSpeed = 2;
          });
        }
      },

      ///////////////////////////IMAGE////////////////////////////////////////
      child: Image.asset(
        'assets/image_360/' + panoImages[id] + '.jpg',
      ),
      // child: Image.network(
      //   'https://firebasestorage.googleapis.com/v0/b/utc2-ea569.appspot.com/o/360%2Fcong.jpg?alt=media&token=8ded6d8f-c28d-41b3-981b-9c08e6ceee57',
      //   cacheHeight: 2000,
      //   cacheWidth: 4000,
      // ),

      latitude: 0,
      longitude: 0,
      hotspots: hotSpot.length - 1 < id
          ? []
          : List.generate(hotSpot[id].length, (index) {
              return Hotspot(
                latitude: hotSpot[id][index].lat,
                longitude: hotSpot[id][index].long,
                width: 150,
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
    return Scaffold(
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
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      color: Colors.white.withOpacity(.5),
                      child: Row(
                        children: [
                          AvatarGlow(
                            glowColor: Colors.red,
                            endRadius: 3,
                            duration: Duration(milliseconds: 300),
                            repeat: true,
                            // showTwoGlows: true,
                            repeatPauseDuration: Duration(milliseconds: 500),
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: .5),
                                  color: Colors.red,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Vị trí của bạn',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        width: 100,
                        height: 100,
                        color: Colors.white54,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Hero(
                                tag: 'mapUtc2',
                                child: Image.asset('assets/1305.png')),
                            Positioned(
                              top: youAreHere[_panoId].top,
                              left: youAreHere[_panoId].left,
                              child: AvatarGlow(
                                glowColor: Colors.red,
                                endRadius: 5,
                                duration: Duration(milliseconds: 300),
                                repeat: true,
                                // showTwoGlows: true,
                                repeatPauseDuration:
                                    Duration(milliseconds: 500),
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: .5),
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
