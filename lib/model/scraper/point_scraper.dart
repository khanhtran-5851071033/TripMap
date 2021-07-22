import 'dart:async';

import 'package:example/model/point.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_scraper/web_scraper.dart';

class PointScraper {
  final webScraper = WebScraper('https://diemthi.tuyensinh247.com');
  // List<Point> ds_Nganh = [];
  List<String> thongtin;
  List<String> thongtinHB;

  final _stream = PublishSubject<List<Point>>();
  Stream<List<Point>> get stream => _stream.stream;

  final _streamHB = PublishSubject<List<Point>>();
  Stream<List<Point>> get streamHB => _streamHB.stream;

  fetchTHPT(String year) async {
    List<Point> dsNganh = [];
    if (await webScraper.loadWebPage(
        '/diem-chuan/dai-hoc-giao-thong-van-tai-co-so-phia-nam-GSA.html?y=$year')) {
      thongtin = webScraper.getElementTitle('div#one>table>tbody>tr>td');
    }
    String stt;
    String manganh;
    String tennganh;
    String tohopmon;
    String diemchuan;
    String ghichu;
    for (int i = 6; i < thongtin.length; i++) {
      if (i % 6 == 0) {
        stt = thongtin[i];
      }
      if (i % 6 == 1) {
        manganh = thongtin[i];
      }
      if (i % 6 == 2) {
        tennganh = thongtin[i];
      }
      if (i % 6 == 3) {
        tohopmon = thongtin[i];
      }
      if (i % 6 == 4) {
        diemchuan = thongtin[i];
      }
      if (i % 6 == 5) {
        ghichu = thongtin[i];

        Point dc = Point(stt, manganh, tennganh, tohopmon, diemchuan, ghichu);
        dsNganh.add(dc);
      }
    }
    _stream.sink.add(dsNganh);
  }

  fetchHB(String year) async {
    List<Point> dsNganh = [];
    List<String> thongtin2 = [];
    if (await webScraper.loadWebPage(
        '/diem-chuan/dai-hoc-giao-thong-van-tai-co-so-phia-nam-GSA.html?y=$year')) {
      thongtinHB = webScraper.getElementTitle('div#two>table>tbody>tr>td');
    }
    String stt;
    String manganh;
    String tennganh;
    String diemchuan;
    for (int i = 0; i < thongtinHB.length; i++) {
      if (i > 5) {
        thongtin2.add(thongtinHB[i]);
      }
    }
    for (int i = 0; i < thongtin2.length; i++) {
      if (i % 4 == 0) {
        stt = thongtin2[i];
      }
      if (i % 4 == 1) {
        manganh = thongtin2[i];
      }
      if (i % 4 == 2) {
        tennganh = thongtin2[i];
      }
      if (i % 4 == 3) {
        diemchuan = thongtin2[i];
        Point dc = Point(stt, manganh, tennganh, '', diemchuan, '');
        dsNganh.add(dc);
      }
    }
    _streamHB.sink.add(dsNganh);
  }

  void dispose() {
    _stream.close();
    _streamHB.close();
  }
}
