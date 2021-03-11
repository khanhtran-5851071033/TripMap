import 'package:example/model/hoc_ky.dart';
import 'package:example/view/shared/util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_scraper/web_scraper.dart';

class DiemScraper {
  final _streamDiemTong = PublishSubject<List<String>>();
  Stream<List<String>> get streamDiemTong => _streamDiemTong.stream;

  final webScraper = WebScraper(url);
  void getDiemTong() async {
    if (await webScraper.loadFullURL(
        'http://xemdiem.utc2.edu.vn/svxemdiem.aspx?ID=5851071044&istinchi=1')) {
      List<String> diem = webScraper.getElementTitle(
          'div#thongtinsinhvien > p> font > table > tbody > tr> td > font > strong');
      // print(diem[1]);
      String diemHe4 = diem[1].split('|')[0].replaceAll('(Hệ 4)', ''),
          diemHe10 = diem[1].split('|')[1].replaceAll('(Hệ 10)', '');
      _streamDiemTong.sink.add([diemHe4, diemHe10]);
    }
  }

  void getDiem() async {
    if (await webScraper.loadFullURL(
        'http://xemdiem.utc2.edu.vn/svxemdiem.aspx?ID=5851071023&istinchi=1')) {
      List<Map<String, dynamic>> noidung = webScraper.getElement(
          'div#thongtinsinhvien > p > table > tbody > tr > td > table > tbody > tr>td',
          ['']);
      String namhoc = '';
      List<String> ds_noidung = [];
      List<HocKi> ds_HocKi = [];
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
      ds_HocKi.removeAt(0);
      print(ds_HocKi[0].ds_NoiDung);
    }
  }

  void dispose() {
    _streamDiemTong.close();
  }
}
