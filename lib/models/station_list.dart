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
      0.0,
      'https://livestreaming5.onlinehorizons.net/hls-live/Qurankareem/_definst_/liveevent/livestream.m3u8',
    ),
    RadioStation(
      "إذاعة القرآن الكريم - السعودية",
      100.6,
      "http://m.live.net.sa:1935/live/quransa/playlist.m3u8",
    ),
    RadioStation(
      'إذاعة القران الكريم - مكة المكرمة',
      0.0,
      'https://5b18be6964c2f.streamlock.net/live/_definst_/quran/playlist.m3u8',
    ),
    RadioStation(
      'إذاعة السنة النبوية - المدينة المنورة',
      88.0,
      'https://5b18be6964c2f.streamlock.net/live/_definst_/sunnah/playlist.m3u8',
    ),
    RadioStation(
      'إذاعة القران الكريم - الشارقة',
      0.0,
      'https://svs.itworkscdn.net/smcquranlive/quranradiolive/playlist.m3u8',
    ),
    RadioStation(
      "إذاعة القران الكريم - أبوظبي",
      100,
      "http://admdn7ta.cdn.mangomolo.com/quranrdo/quranrdo.stream_aac/master.m3u8",
    ),
    RadioStation(
      'إذاعة دبي للقران الكريم',
      0.0,
      'http://uk5.internet-radio.com:8079/stream',
    ),
    RadioStation(
      "إذاعة زايد للقران الكريم - الفجيرة",
      0.0,
      "http://ccfz.dyndns.org:4427/zfm",
    ),
    RadioStation(
      "إذاعة القران الكريم - البحرين",
      0.0,
      "https://5c7b683162943.streamlock.net:443/live/ngrp:radio-106-1_all/playlist.m3u8",
    ),
    RadioStation(
      "إذاعة القران الكريم - الكويت",
      0.0,
      "https://live.hibridcdn.net/kwmedia/kwholyquran/playlist.m3u8",
    ),
    RadioStation(
      "إذاعة القران الكريم - الدوحة",
      0.0,
      "http://52.178.28.223:1935/QURAN/myStream/Playlist.m3u8",
    ),
    RadioStation(
      "إذاعة القران الكريم - نابلس",
      0.0,
      "http://www.quran-radio.org:8080/;stream.mp3",
    ),
    RadioStation(
      "إذاعة القران الكريم - غزة",
      0.0,
      "http://62.210.106.9:8010/;stream.mp3",
    ),
    RadioStation(
      'إذاعة حياة اف ام للقران الكريم - الأردن',
      0.0,
      'http://213.239.218.99:7172/live/;',
    ),
    RadioStation(
      'إذاعة القران الكريم - لبنان',
      0.0,
      'http://162.244.81.30:8224/;stream.mp3',
    ),
    RadioStation(
      'إذاعة نداء المعرفة - بيروت',
      0.0,
      'https://nidaa.fm:8443/stream.mp3',
    ),
    RadioStation(
      "إذاعة القران الكريم - سلطنة عمان",
      0.0,
      "http://38.96.148.35:1935/live/quran01/playlist.m3u8",
    ),
    RadioStation(
      'إذاعة القران الكريم - السودان',
      0.0,
      'http://tijaniyyah.asuscomm.com:8000/stream/2/;',
    ),
    RadioStation(
      "إذاعة محمد السادس للقران الكريم",
      0.0,
      "https://cdnamd-hls-globecast.akamaized.net/live/ramdisk/radio_mohammed_6/hls_snrt_radio/index.m3u8",
    ),
    RadioStation(
      "إذاعة القران الكريم - الجزائر",
      0.0,
      "http://coran.ice.infomaniak.ch/coran.aac",
    ),
    RadioStation(
      "إذاعة القران الكريم - تونس",
      0.0,
      "http://5.135.194.225:8000/live",
    ),
    RadioStation(
      'إذاعة طريق السلف - ليبيا',
      0.0,
      'http://salafwayfm.ly:8000/fm',
    ),
    RadioStation(
      "إذاعة الكتاب والسنة - ليبيا",
      0.0,
      "http://162.244.80.118:5678/stream",
    ),
    RadioStation(
      'إذاعة القران الكريم - بنجلادش',
      0.0,
      'http://66.45.232.131:9994/;stream/1/;',
    ),
    RadioStation(
      'إذاعة القران الكريم - اندونسيا',
      0.0,
      'http://live2.radiorodja.com/;stream.mp3',
    ),
    RadioStation(
      "إذاعة صوت القران - باكستان",
      0.0,
      "http://www.quran-radio.org:8002/;",
    ),
    RadioStation(
      'إذاعة القران الكريم - أفغانستان',
      0.0,
      'http://aradio.aryanict.com:9332/;',
    ),
    RadioStation(
      'إذاعة القران الكريم - الولايات المتحدة الأمريكية',
      0.0,
      'http://206.72.199.179:9992/;stream.nsv',
    ),
    RadioStation(
      'إذاعة الله أكبر - الولايات المتحدة الأمريكية',
      0.0,
      'http://66.45.232.134:9996/;',
    ),
    RadioStation(
      "إذاعة القرآن الكريم والإسلام",
      0.0,
      "http://206.72.199.180:9990/;",
    ),
    RadioStation(
      "إذاعة القران الكريم - استراليا",
      0.0,
      "http://listen.qkradio.com.au:8382/listen.mp3",
    ),
    RadioStation(
      "إذاعة الصوت الإسلامي - ملبورن",
      0.0,
      "http://69.16.197.132:9755/stream/;",
    ),
    RadioStation(
      "إذاعة سيدني الإسلامية - استراليا",
      0.0,
      "http://www.2mfm.org.au:8000/live",
    ),
    RadioStation(
      "إذاعة القران الكريم - الصين 1",
      0.0,
      "http://66.45.232.131:9994/;",
    ),
    RadioStation(
      "إذاعة القران الكريم - الصين 2",
      0.0,
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
