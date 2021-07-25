import 'dart:async';

import 'package:example/view/shared/image_list.dart';
import 'package:get/get.dart';

class PanoController extends GetxController {
  var isShow = false.obs;
  var imageSize = 1.obs;
  var animSpeed = 0.01.obs;
  var panoId = 0.obs;
  var listHot = hotSpot.obs;
  Timer timer;

  void onShow(int index) {
    var hotName = listHot[panoId.value][index].name;
    content.forEach((e) {
      if (e.name == hotName) {
        listHot[panoId.value][index].name = e.content;
      } else if (e.content == hotName) {
        listHot[panoId.value][index].name = e.name;
      }
    });
    this.listHot.refresh();
  }

  void onPanoTap() {
    if (animSpeed.value == 2) {
      animSpeed.value = 0.01;
    } else {
      animSpeed.value = 2;
    }
    print(animSpeed.value);
  }

  void onHotspotTap(MyHotspot hotspot) {
    try {
      if (timer.isActive) timer.cancel();
    } catch (e) {}
    startTimer();
    animSpeed.value = 0.01;
    imageSize.value = 0;
    panoId.value = hotspot.id;
  }

  void startTimer() {
    timer = new Timer(Duration(seconds: 2), () {
      imageSize.value = 1;
    });
  }

  @override
  void dispose() {
    this.dispose();
    super.dispose();
  }
}
