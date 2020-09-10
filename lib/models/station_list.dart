import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import '../utils/favorites_storage.dart';
import 'radio_station.dart';

class StationList {
  final List<String> streemaIslamicURLs = [
    //"https://streema.com/radios/country/Egypt",
    //"https://streema.com/radios/country/Egypt?page=2",

    //"https://streema.com/radios/search/?q=islam",
    //"https://streema.com/radios/search/?q=islam&page=2",

    "https://streema.com/radios/genre/Islamic",
    "https://streema.com/radios/genre/Islamic?page=2",
    "https://streema.com/radios/genre/Islamic?page=3",
    "https://streema.com/radios/genre/Islamic?page=4",
    "https://streema.com/radios/genre/Islamic?page=5",
    //"https://streema.com/radios/genre/Islamic?page=6",
    // "https://streema.com/radios/genre/Islamic?page=7",
    // "https://streema.com/radios/genre/Islamic?page=8",
    // "https://streema.com/radios/genre/Islamic?page=9",
    // "https://streema.com/radios/genre/Islamic?page=10",
  ];

  final String streemaBaseURL = "http://streema.com";

  List<RadioStation> radioList = [];
  List<RadioStation> favoriteList = [];

  StationList() {
    radioList = list;
    initFavoritesList();
  }

  RadioStation findStation(String url) {
    int stationIndex = radioList.indexWhere((station) => station.url == url);
    return this.radioList[stationIndex];
  }

  Future<List> parseStreemaStationsInfo() async {
    var client = http.Client();
    List streemaStationList = [];

    try {
      for (int i = 0; i < streemaIslamicURLs.length; i++) {
        String response = await client.read(this.streemaIslamicURLs[i]);
        Document parsedRes = parse(response);
        var stations =
            parsedRes.body.querySelectorAll(".items-list")[0].children;
        for (int j = 0; j < stations.length; j++) {
          if (stations[j].attributes["title"] != null &&
              stations[j].attributes["data-url"] != null) {
            String stationTitle = stations[j]
                .attributes["title"]
                .replaceAll(new RegExp(r"Play "), '');
            String stationStreemaURL = stations[j].attributes["data-url"];
            streemaStationList.add({
              'title': stationTitle,
              'streema-data-url': stationStreemaURL,
            });
          }
        }
      }
    } finally {
      client.close();
    }
    return streemaStationList;
  }

  Future<bool> parseStreamURLs(List list) async {
    var client = http.Client();
    try {
      for (int i = 0; i < list.length; i++) {
        String url = "$streemaBaseURL${list[i]["streema-data-url"]}";
        String title = list[i]["title"];
        String response = await client.read(url);
        Document parsedRes = parse(response);
        var streamURL = parsedRes.querySelector("audio");
        if (streamURL != null &&
            streamURL.children[0].attributes["src"].isNotEmpty) {
          String url = streamURL.children[0].attributes["src"];
          addNewStation(title, url);
        }
      }
    } finally {
      client.close();
    }

    return true;
  }

  void initFavoritesList() async {
    favoriteList = await FavoritesStorage().readFavorites();
  }

  void addNewStation(String title, String url) {
    radioList.add(RadioStation(title, 0.0, url));
  }

  static Future<List<RadioStation>> getRefreshedStations() async {
    return await FavoritesStorage().readFavorites();
  }

  static List<RadioStation> list = [
    RadioStation(
      'إذاعة القرآن الكريم - القاهرة',
      98.20,
      'https://livestreaming5.onlinehorizons.net/hls-live/Qurankareem/_definst_/liveevent/livestream.m3u8',
    ),
    RadioStation(
      "إذاعة القرآن الكريم - السعودية",
      100.60,
      "http://m.live.net.sa:1935/live/quransa/playlist.m3u8",
    ),
    RadioStation(
      'إذاعة القران الكريم - مكة المكرمة',
      89.80,
      'https://5b18be6964c2f.streamlock.net/live/_definst_/quran/playlist.m3u8',
    ),
    RadioStation(
      'إذاعة السنة النبوية - المدينة المنورة',
      88.00,
      'https://5b18be6964c2f.streamlock.net/live/_definst_/sunnah/playlist.m3u8',
    ),
    RadioStation(
      'إذاعة القران الكريم - الشارقة',
      102.70,
      'https://svs.itworkscdn.net/smcquranlive/quranradiolive/playlist.m3u8',
    ),
    RadioStation(
      "إذاعة القران الكريم - أبوظبي",
      88.60,
      "http://admdn7ta.cdn.mangomolo.com/quranrdo/quranrdo.stream_aac/master.m3u8",
    ),
    RadioStation(
      'إذاعة دبي للقران الكريم',
      91.40,
      'http://uk5.internet-radio.com:8079/stream',
    ),
    RadioStation(
      "إذاعة زايد للقران الكريم - الفجيرة",
      98.70,
      "http://ccfz.dyndns.org:4427/zfm",
    ),
    RadioStation(
      "إذاعة القران الكريم - البحرين",
      106.10,
      "https://5c7b683162943.streamlock.net:443/live/ngrp:radio-106-1_all/playlist.m3u8",
    ),
    RadioStation(
      "إذاعة القران الكريم - الكويت",
      94.50,
      "https://live.hibridcdn.net/kwmedia/kwholyquran/playlist.m3u8",
    ),
    RadioStation(
      "إذاعة القران الكريم - الدوحة",
      103.40,
      "http://52.178.28.223:1935/QURAN/myStream/Playlist.m3u8",
    ),
    RadioStation(
      "إذاعة القران الكريم - نابلس",
      88.40,
      "http://www.quran-radio.org:8080/;stream.mp3",
    ),
    // RadioStation(
    //   "إذاعة القران الكريم - غزة",
    //   0.0,
    //   "http://62.210.106.9:8010/;stream.mp3",
    // ),
    RadioStation(
      'إذاعة حياة اف ام للقران الكريم - الأردن',
      104.7,
      'http://213.239.218.99:7172/live/;',
    ),
    RadioStation(
      'إذاعة القران الكريم - لبنان',
      93.90,
      'http://162.244.81.30:8224/;stream.mp3',
    ),
    RadioStation(
      'إذاعة نداء المعرفة - بيروت',
      91.50,
      'https://nidaa.fm:8443/stream.mp3',
    ),
    // RadioStation(
    //   "إذاعة القران الكريم - سلطنة عمان",
    //   0.0,
    //   "http://38.96.148.35:1935/live/quran01/playlist.m3u8",
    // ),
    RadioStation(
      'إذاعة القران الكريم - السودان',
      102.00,
      'http://tijaniyyah.asuscomm.com:8000/stream/2/;',
    ),
    RadioStation(
      "إذاعة محمد السادس للقران الكريم",
      98.60,
      "https://cdnamd-hls-globecast.akamaized.net/live/ramdisk/radio_mohammed_6/hls_snrt_radio/index.m3u8",
    ),
    RadioStation(
      "إذاعة القران الكريم - الجزائر",
      93.60,
      "http://coran.ice.infomaniak.ch/coran.aac",
    ),
    RadioStation(
      "إذاعة القران الكريم - تونس",
      102.90,
      "http://5.135.194.225:8000/live",
    ),
    RadioStation(
      'إذاعة طريق السلف - ليبيا',
      100.30,
      'http://salafwayfm.ly:8000/fm',
    ),
    RadioStation(
      "إذاعة الكتاب والسنة - ليبيا",
      89.60,
      "http://162.244.80.118:5678/stream",
    ),
    RadioStation(
      'إذاعة القران الكريم - بنجلادش',
      92.30,
      'http://66.45.232.131:9994/;stream/1/;',
    ),
    RadioStation(
      'إذاعة القران الكريم - اندونسيا',
      90.60,
      'http://live2.radiorodja.com/;stream.mp3',
    ),
    RadioStation(
      "إذاعة صوت القران - باكستان",
      104.60,
      "http://www.quran-radio.org:8002/;",
    ),
    RadioStation(
      'إذاعة القران الكريم - أفغانستان',
      88.40,
      'http://aradio.aryanict.com:9332/;',
    ),
    RadioStation(
      'إذاعة القران الكريم - الولايات المتحدة الأمريكية',
      102.30,
      'http://206.72.199.179:9992/;stream.nsv',
    ),
    RadioStation(
      'إذاعة الله أكبر - الولايات المتحدة الأمريكية',
      88.70,
      'http://66.45.232.134:9996/;',
    ),
    RadioStation(
      "إذاعة القرآن الكريم والإسلام",
      91.20,
      "http://206.72.199.180:9990/;",
    ),
    RadioStation(
      "إذاعة القران الكريم - استراليا",
      92.90,
      "http://listen.qkradio.com.au:8382/listen.mp3",
    ),
    RadioStation(
      "إذاعة الصوت الإسلامي - ملبورن",
      87.60,
      "http://69.16.197.132:9755/stream/;",
    ),
    RadioStation(
      "إذاعة سيدني الإسلامية - استراليا",
      92.10,
      "http://www.2mfm.org.au:8000/live",
    ),
    RadioStation(
      "إذاعة القران الكريم 1 - الصين",
      98.70,
      "http://66.45.232.131:9994/;",
    ),
    RadioStation(
      "إذاعة القران الكريم 2 - الصين",
      87.20,
      "http://206.72.199.178:9302/;",
    ),
    // RadioStation(
    //   "",
    //   0.0,
    //   "",
    // ),
    // RadioStation(
    //   "",
    //   0.0,
    //   "",
    // ),
  ];
}
