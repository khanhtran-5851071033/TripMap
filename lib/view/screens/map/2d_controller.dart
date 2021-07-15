import 'package:example/model/end_point.dart';
import 'package:example/path_finder/repo_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Map2dController extends GetxController {
  TextEditingController diemDauController = TextEditingController();
  TextEditingController diemCuoiController = TextEditingController();
  RxList<EndPoint> listSearch = listBuilding.obs;

  onSearch(String input) {
    listSearch.value = listBuilding
        .where((e) => e.name.toLowerCase().contains(input.toLowerCase()))
        .toList();
  }
}
