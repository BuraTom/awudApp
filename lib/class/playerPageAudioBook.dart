import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import '../main.dart';
import 'audio_file.dart';

class playerPage extends StatefulWidget {
  final String value;
  final String epi;
  final List? pl;

  playerPage({Key? key, required this.value, required this.epi, required this.pl}) : super(key: key);

  @override
  _playerPageState createState() => _playerPageState();
}

class _playerPageState extends State<playerPage> {
  late AudioPlayer advancedPlayer;
  List? result;
  var episode;

  Future printValue() async{
    var response = await http.get(Uri.parse('http://${IpAddresse}:5000/audioBook/${widget.value}'));

    if(response.statusCode == 200){
      result = json.decode(response.body);
      return result;
    }
  }

  Future printEpisode() async{
    var response = await Dio().get('http://192.168.43.196:8000/routes/music/01%20Minew.mp3');
    // var response = await Dio().get('http://${IpAddresse}:5000/chapter/${widget.value}/chapter/${widget.epi}');
 // http://192.168.43.196:8000/routes/music/01%20Minew.mp3
    if(response.statusCode == 200){
      episode = response.data;
      return episode;
    }else{
      print('Wong input');
    }
  }

  @override
  void initState(){
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('sfsdj'),
        // ),
        //   body:Center(child: Column(
        //     children: [
        //       Text('data'),
        //      Text("assets/audio/${episode['chapter_audio']}"),
        //       Text("${widget.pl}"),
        //     ],
        //   ))
          body: MyAppp(id:widget.value,current:widget.epi,playlist:widget.pl)
      )
    );
  }
}