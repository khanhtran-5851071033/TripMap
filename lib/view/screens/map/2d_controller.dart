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
  var animateValue = 0.0.obs;

  Animation animation;

  Path path;

  var diemDau = 0.obs, diemCuoi = 0.obs;
  RxList<int> listDiem = <int>[].obs;
  var isFirst = true;
  var isShowSearch = false.obs;

  void init(dynamic arg) {
    if (arg != null) {
      //clear data before add endpoint
      clearFindPath();

      //add diemDau from pano screen
      diemDau.value = arg;
      PositionedWidgetState.diem.add(arg);
      isFirst = false;

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

  onTapTextField(bool isFi) {
    isShowSearch.value = true;
    isFirst = isFi;
    listSearch.value = listBuilding;
    listSearch.refresh();
  }

  findPath(List<int> diem) {
    if (diem.length != 0) {
      path = drawPath();

      animateController.reset();
      animateController.repeat();
    } else {
      clearFindPath();
    }
  }

  onTapPositioned(int itemId, BuildContext context) {
    unfocus(context);

    isShowSearch.value = false;

    print(isFirst);

    if (!listDiem.contains(itemId)) {
      if (listDiem.length < 2) {
        listDiem.add(itemId);
        listDiem.refresh();
        PositionedWidgetState.diem.add(itemId);
      } else {
        clearFindPath();

        PositionedWidgetState.diem.add(itemId);
        listDiem.add(itemId);
      }
      if (isFirst) {
        //Diem dau
        diemDau.value = itemId;
        diemDauController.text = listBuilding[itemId - 1].name;
      } else {
        //Diem Cuoi
        diemCuoi.value = itemId;
        diemCuoiController.text = listBuilding[itemId - 1].name;
      }
      findPath(listDiem);

      isFirst = !isFirst;
    }
  }

  onTapItem(int id, BuildContext context) {
    unfocus(context);

    if (PositionedWidgetState.diem.length == 2) {
      for (var item in PositionedWidgetState.diem) {
        if (item == (isFirst ? diemDau.value : diemCuoi.value)) {
          PositionedWidgetState.diem.remove(item);
          PositionedWidgetState.diem.add(id);
        }
      }
    }
    if (isFirst) {
      //Diem dau
      diemDau.value = id;
      diemDauController.text = listBuilding[id - 1].name;
    } else {
      //Diem Cuoi
      diemCuoi.value = id;
      diemCuoiController.text = listBuilding[id - 1].name;
    }

    path = drawPath();

    animateController.reset();
    animateController.repeat();
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
    isFirst = true;
    diemDauController.clear();
    diemCuoiController.clear();
    diemDau.value = 0;
    diemCuoi.value = 0;

    path = drawPath();
    if (animateController != null) animateController.reset();
    listDiem.clear();
    PositionedWidgetState.diem.clear();
  }
}
