import 'dart:convert';
import 'package:awud_application/model/musicModel.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class BooksApi {
  var data = [];
  List<FetchedMusic> results = [];
  String urlList = 'http://${IpAddresse}:5000/music';

  Future<List<FetchedMusic>> getuserList({String? query}) async {
    var url = Uri.parse(urlList);

    try {
      print(query);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print(data);
        results = data.map((e) => FetchedMusic.fromJson(e)).toList();
        if (query!= null){
          print('something');
          results = results.where((element) => element.title!.toLowerCase().contains((query.toLowerCase()))).toList();
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