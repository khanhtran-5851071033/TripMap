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
      zoom: 1,
      minZoom: 0.5,
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
                child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.white54,
                    child: Hero(
                        tag: 'mapUtc2', child: Image.asset('assets/1305.png'))),
              ))
        ],
      ),
    );
  }
}
