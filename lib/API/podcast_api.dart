import 'dart:convert';
import 'package:awud_application/model/podcastModel.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class BooksApi {
  var data = [];
  List<FetchedPodcast> results = [];
  String urlList = 'http://${IpAddresse}:5000/podcast';

  Future<List<FetchedPodcast>> getuserList({String? query}) async {
    var url = Uri.parse(urlList);

    try {
      // print(query);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => FetchedPodcast.fromJson(e)).toList();
        if (query!= null){
          results = results.where((element) => element.podcast_title!.toLowerCase().contains((query.toLowerCase()))).toList();
          print(results);
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}