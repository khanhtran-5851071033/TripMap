import 'dart:ui';

import 'package:example/model/end_point.dart';
import 'package:example/path_finder/dijsktra.dart';
import 'package:example/path_finder/repo_path.dart';
import 'package:example/view/shared/util.dart';
import 'package:example/view/widgets/positioned_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Map2dController extends GetxController {
  AnimationController animateController;
  TextEditingController diemDauController = TextEditingController();
  TextEditingController diemCuoiController = TextEditingController();
  RxList<EndPoint> listSearch = listBuilding.obs;

  Animation animation;

  Path path;

  var diemDau = 0.obs, diemCuoi = 0.obs;
  RxList<int> listDiem = <int>[].obs;

  void init(dynamic arg) {
    path = drawPath();
    if (arg != null) {
      diemDau.value = arg;
      PositionedWidgetState.diem.add(arg);
      var name = listBuilding[diemDau.value - 1].name;
      if (name != '')
        diemDauController.text = name;
      else
        diemDauController.text = 'Vị trí của bạn';
    } else
      diemDau.value = 0;
  }

  onSearch(String input) {
    listSearch.value = listBuilding
        .where((e) => e.name.toLowerCase().contains(input.toLowerCase()))
        .toList();
  }

  void findPath(List<int> diem, BuildContext context) {
    unfocus(context);
    if (diem.length == 2) {
      // diemDau = diem[0];
      diemCuoi.value = diem[1];
      diemCuoiController.text = listBuilding[diemCuoi.value - 1].name;

      path = drawPath();

      animateController.reset();
      animateController.repeat();
    } else if (diem.length == 1) {
      diemDau.value = diem[0];
      diemCuoiController.clear();
      diemDauController.text = listBuilding[diemDau.value - 1].name;

      diemCuoi.value = 0;
      path = drawPath();

      animateController.repeat();
    } else {
      clearFindPath();
    }
  }

  Path drawPath() {
    Path path = Path();

    if (diemDau.value != 0 && diemCuoi.value != 0) {
      List<int> diem = Dijsktra.findPath(diemDau.value, diemCuoi.value);
      double prevX = 0;
      double prevY = 0;
      for (int i = 0; i < diem.length; i++) {
        for (int j = 0; j < listBuilding.length; j++) {
          if ((listBuilding[j].id) == diem[i]) {
            if (prevX == 0 && prevY == 0) {
              path.moveTo(
                  listBuilding[j].location.dx, listBuilding[j].location.dy);
              prevX = listBuilding[j].location.dx;
              prevY = listBuilding[j].location.dy;
            } else {
              path.quadraticBezierTo(prevX, prevY, listBuilding[j].location.dx,
                  listBuilding[j].location.dy);
              prevX = listBuilding[j].location.dx;
              prevY = listBuilding[j].location.dy;
            }
          }
        }
      }
    } else if (diemDau.value == 0 || diemCuoi.value == 0) {
      path.moveTo(0, 0);
    }
    return path;
  }

  Offset calculate(value) {
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.position;
  }

  void clearFindPath() {
    diemDauController.clear();
    diemCuoiController.clear();
    diemDau.value = 0;
    diemCuoi.value = 0;

    path = drawPath();

    animateController.reset();
    PositionedWidgetState.diem.clear();
  }
}
