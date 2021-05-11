import 'dart:async';

import 'package:example/model/hoc_ky.dart';
import 'package:example/model/sinh_vien.dart';
import 'package:example/view/shared/util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_scraper/web_scraper.dart';

class DiemScraper {
  final _streamDiemTong = PublishSubject<List>();
  Stream<List> get streamDiemTong => _streamDiemTong.stream;
  final _streamThongTin = PublishSubject<SinhVien>();
  Stream<SinhVien> get streamThongTin => _streamThongTin.stream;
  final _streamHocKy = PublishSubject<List<HocKi>>();
  Stream<List<HocKi>> get streamHocKy => _streamHocKy.stream;
  StreamController<String> streamController =
      StreamController<String>.broadcast();

  final webScraper = WebScraper(url);
  void getDiemTong() async {
    var msv = await getMsv();
    String diemHe4, diemHe10, soTc;
    if (await webScraper.loadFullURL(
        'http://xemdiem.utc2.edu.vn/svxemdiem.aspx?ID=$msv&istinchi=1')) {
      List<String> diem = webScraper.getElementTitle(
          'div#thongtinsinhvien > p> font > table > tbody > tr> td > font > strong');
      // print(diem[1]);
      diemHe4 = diem[1].split('|')[0].replaceAll('(Hệ 4)', '');
      diemHe10 = diem[1].split('|')[1].replaceAll('(Hệ 10)', '');
      soTc = diem[3];
    }

    _streamDiemTong.sink.add([diemHe4, diemHe10, int.parse(soTc)]);
  }

  Future<SinhVien> getThongTin(String msv) async {
    SinhVien sinhvien;
    if (await webScraper.loadFullURL(
        'http://xemdiem.utc2.edu.vn/svxemdiem.aspx?ID=$msv&istinchi=1')) {
      List<String> thongTinSV = webScraper.getElementTitle(
          'div#thongtinsinhvien > table> tbody > tr > td > font');
      String hoten = thongTinSV[2];
      String masv = thongTinSV[3];
      String ngaysinh = thongTinSV[4];
      String noisinh = thongTinSV[5];
      String hedaotao = thongTinSV[6];
      String lop = thongTinSV[7];
      String khoa = thongTinSV[8];

      sinhvien =
          new SinhVien(hoten, masv, ngaysinh, noisinh, hedaotao, lop, khoa);
      print(sinhvien.hoten);
      _streamThongTin.sink.add(sinhvien);
    }
    return sinhvien;
  }

  void getDiem() async {
    var msv = await getMsv();
    List<String> ds_noidung = [];
    List<HocKi> ds_HocKi = [];
    if (await webScraper.loadFullURL(
        'http://xemdiem.utc2.edu.vn/svxemdiem.aspx?ID=$msv&istinchi=1')) {
      List<Map<String, dynamic>> noidung = webScraper.getElement(
          'div#thongtinsinhvien > p > table > tbody > tr > td > table > tbody > tr>td',
          ['']);
      String namhoc = '';
      bool kt = false;
      for (int i = 7; i < noidung.length; i++) {
        if (noidung[i].toString().contains('Năm học')) {
          ds_HocKi.add(HocKi(namhoc, ds_noidung));
          namhoc = noidung[i]
              .toString()
              .replaceAll('{title:', '')
              .replaceAll(', attributes: {: null}}', '')
              .trim();
          ds_noidung = [];
          kt = true;
        } else {
          kt = false;
        }
        if (!kt) {
          String ndung = noidung[i]
              .toString()
              .replaceAll('{title:', '')
              .replaceAll(', attributes: {: null}}', '')
              .trim();
          ds_noidung.add(ndung);
        }
      }
    }
    ds_HocKi.removeAt(0);
    _streamHocKy.sink.add(ds_HocKi);
  }

  void dispose() {
    _streamDiemTong.close();
    _streamThongTin.close();
    streamController.close();
    _streamHocKy.close();
  }
}
