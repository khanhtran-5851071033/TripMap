import 'package:example/model/event.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_scraper/web_scraper.dart';

String url = 'https://utc2.edu.vn';

class EventScraper {
  final _stream = PublishSubject<List<Event>>();
  Stream<List<Event>> get stream => _stream.stream;

  final webScraper = WebScraper(url);

  fetchEvent() async {
    List<Event> ds_TinTuc = [], ds_TinTuc1 = [];
    List<String> ds_Tittle;
    List<Map<String, dynamic>> ds_IMG, ds_Link;
    if (await webScraper.loadWebPage('/tin-tuc/p=1')) {
      ds_Tittle =
          webScraper.getElementTitle('div#kuntraict>div.mucdichvu>h3>a');
      ds_IMG =
          webScraper.getElement('div#kuntraict>div.mucdichvu>a>img', ['src']);
      ds_Link =
          webScraper.getElement('div#kuntraict>div.mucdichvu>a', ['href']);
    }
    String tittle, img, link;

    for (int i = 0; i < ds_Tittle.length; i++) {
      tittle = ds_Tittle[i].trim();
      img = url +
          '/' +
          ds_IMG[i]
              .toString()
              .trim()
              .substring(28, ds_IMG[i].toString().trim().length - 2);
      link = url +
          '/' +
          ds_Link[i]
              .toString()
              .trim()
              .substring(55, ds_Link[i].toString().trim().length - 2);
      if (await webScraper.loadWebPage(link.substring(url.length))) {
        String thoigian = webScraper
            .getElementTitle('div#kuntraict>div.ngaydangctcon')
            .first
            .toString()
            .trim();
        thoigian = thoigian.substring(10, thoigian.length);
        List<String> time = thoigian.split('-');
        // print(time[0].trim());
        List<String> ngay = time[0].split(' ');

        String year = ngay[3].split('/')[2];
        String month = ngay[3].split('/')[1];
        String day = ngay[3].split('/')[0];
        String hour = time[1].trim().substring(0, 2);
        String minute = time[1].trim().substring(3, 5);
        DateTime date = DateTime.parse('$year-$month-$day $hour:$minute:00');
        DateTime dateNow = DateTime.now();
        var daydiff = dateNow.difference(date).inDays;
        var hourdiff = dateNow.difference(date).inHours;
        var timediff;
        if (daydiff > 7)
          timediff = ngay[3];
        else if (daydiff > 0)
          timediff = daydiff.toString() + ' ngày';
        else if (hourdiff > 0)
          timediff = hourdiff.toString() + ' giờ';
        else
          timediff = dateNow.difference(date).inMinutes.toString() + ' phút';
        //event model
        Event td = Event(tittle, img, link, ngay[3].trim(), timediff.toString(),
            time[2].trim().substring(10, time[2].trim().length));
        ds_TinTuc.add(td);
      }
      if (i % 3 == 0 && i != 0)
        _stream.sink.add(ds_TinTuc);
      else if (i == 10) _stream.sink.add(ds_TinTuc);
    }
  }

  void dispose() {
    _stream.close();
  }
}
