import 'package:example/model/noti.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_scraper/web_scraper.dart';

class NotiScraper {
  final _stream = PublishSubject<List<Noti>>();
  Stream<List<Noti>> get stream => _stream.stream;
  final webScraper = WebScraper('https://utc2.edu.vn');

  // Response of getElement is always List<Map<String, dynamic>>
  List<Map<String, dynamic>> tieuDeNoti;
  List<Map<String, dynamic>> thoiGianNoti;
  List<Noti> dsNoti;

   fetchProducts() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage('/thong-bao')) {
      tieuDeNoti = webScraper
          .getElement('div#kuntraict > div.mucdichvu > h3 > a', ['href']);
      thoiGianNoti = webScraper.getElement(
          'div#kuntraict > div.mucdichvu > p.ngaymucdichvu > span', []);
      Noti thongBao;
      dsNoti = [];
      Map<String, dynamic> attributes;
      for (int i = 0; i < tieuDeNoti.length; i++) {
        attributes = tieuDeNoti[i]['attributes'];
        thongBao = new Noti(tieuDeNoti[i]['title'], thoiGianNoti[i]['title'],
            webScraper.baseUrl + '/' + attributes['href'], 0);
        dsNoti.add(thongBao);
      }
      _stream.sink.add(dsNoti);

      // String luotXem;
      // int i = 0;
      // dsNoti.forEach((element) async {
      //   if (await webScraper.loadFullURL(element.link)) {
      //     luotXem =
      //         webScraper.getElementTitle('div.ngaydangctcon').first.toString();
      //     luotXem = luotXem.substring(
      //         luotXem.indexOf('Lượt xem:') + 10, luotXem.length - 1);
      //     dsNoti[i].luotxem = int.parse(luotXem);
      //     print(element.toString());
      //   }
      //   i++;
      // });
    }
  }

  void dispose() {
    _stream.close();
  }
}
