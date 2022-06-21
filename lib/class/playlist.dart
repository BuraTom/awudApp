import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';

List? result;
Future printValues(String id) async{
  var response = await http.get(Uri.parse('http://${IpAddresse}:5000/audioBook/${id}'));

  if(response.statusCode == 200){
    result = json.decode(response.body);
    // print()
    return result;
  }else{
    print('here');
  }
}