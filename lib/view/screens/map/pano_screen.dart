import 'package:avatar_glow/avatar_glow.dart';
import 'package:example/view/screens/map/pano_controller.dart';
import 'package:example/view/shared/image_list.dart';
import 'package:example/view/widgets/hotspot_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:panorama/panorama.dart';

class PanoScreen extends StatefulWidget {
  @override
  _PanoScreenState createState() => _PanoScreenState();
}

class _PanoScreenState extends State<PanoScreen> {
  var controller;

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => PanoController(), fenix: true);
    controller = Get.find<PanoController>();
  }
  // void newMethod() => controller.onShow(isShow);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<PanoController>();
        return true;
      },
      child: Obx(
        () => Scaffold(
          body: Stack(
            children: [
              PanoWidget(),
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
                                  top: youAreHere[controller.panoId.value].top,
                                  left:
                                      youAreHere[controller.panoId.value].left,
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
        ),
      ),
    );
  }
}

class PanoWidget extends StatelessWidget {
  final controller = Get.find<PanoController>();

  @override
  Widget build(BuildContext context) {
    int id = controller.panoId.value;
    return Obx(
      () => Panorama(
        animSpeed: controller.animSpeed.value,
        zoom: 0.7,
        minZoom: 0.5,
        maxZoom: 5.0,
        sensitivity: 1.8,
        interactive: true,
        sensorControl: SensorControl.Orientation,
        // onViewChanged: onViewChanged,
        onTap: (longitude, latitude, tilt) {
          controller.onPanoTap();
        },

        ///////////////////////////IMAGE////////////////////////////////////////
        child: Image.asset(
          'assets/image_360/' +
              panoImages[id] +
              (controller.imageSize.value == 1 ? '.jpg' : '-min.jpg'),
        ),

        latitude: 0,
        longitude: 0,
        hotspots: controller.listHot.length - 1 < id
            ? []
            : List.generate(controller.listHot[id].length, (index) {
                return Hotspot(
                  latitude: controller.listHot[id][index].lat,
                  longitude: controller.listHot[id][index].long,
                  width: 150,
                  height: 100,
                  widget: HotspotButton(
                    controller.listHot[id][index],
                    onTap: () {
                      controller.onHotspotTap(controller.listHot[id][index]);
                    },
                    onShow: () {
                      controller.onShow(index);
                    },
                  ),
                );
              }),
      ),
    );
  }
}
