import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_scraper/web_scraper.dart';

void main() => runApp(WebScraperApp());

class WebScraperApp extends StatefulWidget {
  @override
  _WebScraperAppState createState() => _WebScraperAppState();
}

class ThongBao {
  String tieude;
  String thoigian;
  String link;
  int luotxem;
  // ThongBao({this.tieude, this.thoigian, this.link, this.luotxem = 0});
  ThongBao(String tieude, String thoigian, String link, int luotxem) {
    this.tieude = tieude;
    this.thoigian = thoigian;
    this.link = link;
    this.luotxem = luotxem;
  }
  // void setLuotXem(int luotxem) {
  //   this.luotxem = luotxem;
  // }

  @override
  String toString() {
    return 'Tieu de: ${this.tieude}\nThoi gian: ${this.thoigian}\nLink: ${this.link}\nLuot xem: ${this.luotxem}';
  }
}

class _WebScraperAppState extends State<WebScraperApp> {
  // initialize WebScraper by passing base url of website
  final webScraper = WebScraper('https://utc2.edu.vn');

  // Response of getElement is always List<Map<String, dynamic>>
  List<Map<String, dynamic>> tieuDeThongBao;
  List<Map<String, dynamic>> thoiGianThongBao;
  List<ThongBao> dsThongBao;
  List<int> dsLuong;

  void fetchProducts() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage('/thong-bao')) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        tieuDeThongBao = webScraper
            .getElement('div#kuntraict > div.mucdichvu > h3 > a', ['href']);
        thoiGianThongBao = webScraper.getElement(
            'div#kuntraict > div.mucdichvu > p.ngaymucdichvu > span', []);
        ThongBao thongBao;
        dsThongBao = [];
        Map<String, dynamic> attributes;
        for (int i = 0; i < tieuDeThongBao.length; i++) {
          attributes = tieuDeThongBao[i]['attributes'];
          thongBao = new ThongBao(
              tieuDeThongBao[i]['title'],
              thoiGianThongBao[i]['title'],
              webScraper.baseUrl + '/' + attributes['href'],
              0);
          dsThongBao.add(thongBao);
        }
      });
      String luotXem;
      int i = 0;
      dsThongBao.forEach((element) async {
        if (await webScraper.loadFullURL(element.link)) {
          setState(() {
            luotXem = webScraper
                .getElementTitle('div.ngaydangctcon')
                .first
                .toString();
            luotXem = luotXem.substring(
                luotXem.indexOf('Lượt xem:') + 10, luotXem.length - 1);
            dsThongBao[i].luotxem = int.parse(luotXem);
            print(element.toString());
          });
        }
        i++;
      });
      // WebScraper webScraper1 = WebScraper();
      // dsThongBao.forEach((element) async {
      //   if (await webScraper1.loadFullURL(element.link)) {
      //     setState(() {
      //       luotXem = webScraper
      //           .getElementTitle('div.ngaydangctcon')
      //           .first
      //           .toString();
      //       luotXem = luotXem.substring(
      //           luotXem.indexOf('Lượt xem:') + 10, luotXem.length - 1);
      //       dsThongBao[i].luotxem = int.parse(luotXem);
      //     });
      //   }
      // });
      //dsThongBao[1].luotxem = 200;
      // dsThongBao.forEach((element) {
      //   print('\n>' + element.tieude + ', ' + element.luotxem.toString());
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    // Requesting to fetch before UI drawing starts
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Thông báo'),
          ),
          body: SafeArea(
              child: tieuDeThongBao == null
                  ? Center(
                      child:
                          CircularProgressIndicator(), // Loads Circular Loading Animation
                    )
                  : ListView.builder(
                      itemCount: tieuDeThongBao.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Attributes are in the form of List<Map<String, dynamic>>.
                        Map<String, dynamic> attributes =
                            tieuDeThongBao[index]['attributes'];
                        return ExpansionTile(
                          title: Text(tieuDeThongBao[index]['title']),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child:
                                        Text(thoiGianThongBao[index]['title']),
                                    margin: EdgeInsets.only(bottom: 10.0),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // uses UI Launcher to launch in web browser & minor tweaks to generate url
                                      launch(webScraper.baseUrl +
                                          '/' +
                                          attributes['href']);
                                    },
                                    child: Text(
                                      'Xem chi tiết',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      }))),
    );
  }
}
