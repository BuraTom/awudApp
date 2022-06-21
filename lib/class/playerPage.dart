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

  playerPage({Key? key, required this.value, required this.epi}) : super(key: key);

  @override
  _playerPageState createState() => _playerPageState();
}

class _playerPageState extends State<playerPage> {
  late AudioPlayer advancedPlayer;
  List? result;
  var episode;

  Future printValue() async{
    var response = await http.get(Uri.parse('http://${IpAddresse}:5000/podcast/${widget.value}'));

    if(response.statusCode == 200){
      result = json.decode(response.body);
      return result;
    }
  }

  Future printEpisode() async{
    var response = await Dio().get('http://${IpAddresse}:5000/episode/${widget.value}/epsiode/${widget.epi}');

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
          body: SizedBox(
            height: 700,
            child: FutureBuilder(
              future: printValue(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.none && snapshot.hasData == null){
                  return Container(
                    child: Text('No Data'),
                  );
                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(248, 135, 88, 1),
                        ),
                      )
                  );
                }else{
                  return ListView.builder(
                      itemCount: result == null ? 0 : result!.length,
                      itemBuilder: (BuildContext context,int index){
                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("${result![0]['image']}"),
                                fit: BoxFit.cover,
                                // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken)
                              )
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 5,sigmaX: 5),
                            child: Column(
                              children: [
                                SizedBox(height: 100),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset("${result![0]['image']}",
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                // SizedBox(height: 80),
                                Container(
                                  margin: EdgeInsets.only(left: 80,top: 25),
                                  child: Row(
                                    children: [
                                      Icon(FeatherIcons.thumbsUp,color: Colors.white,),
                                      SizedBox(width: 60),
                                      Icon(FeatherIcons.download,color: Colors.white,),
                                      SizedBox(width: 60),
                                      GestureDetector(
                                          onTap: (){
                                            Share.share('${result![0]['podcast_title']}\n${episode['episode_name']}', subject: 'Look what I made!');
                                          },
                                          child: Icon(FeatherIcons.share2,color: Colors.white,
                                          )
                                      ),
                                      SizedBox(width: 60),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  child: FutureBuilder(
                                    future: printEpisode(),
                                    builder: (context,snapshot){
                                      if(snapshot.connectionState == ConnectionState.none && snapshot.hasData == null){
                                        return Container(
                                          child: Text('No Data'),
                                        );
                                      }else if(snapshot.connectionState == ConnectionState.waiting){
                                        return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: Color.fromRGBO(248, 135, 88, 1),
                                              ),
                                            )
                                        );
                                      }else{
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: result == null ? 0 : result!.length,
                                            itemBuilder: (BuildContext context,int index){
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      episode['episode_name'].toString(),
                                                      style: TextStyle(
                                                          fontSize:30,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                    Text(
                                                      result![0]['podcast_title'].toString(),
                                                      style: TextStyle(
                                                          fontSize:17,
                                                          color: Colors.grey
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height:60),
                                                    //MyAppp(path:"assets/audio/${episode['episode_audio']}",playlist: [],)
                                                    // Player(path:"assets/audio}")
                                                  ],
                                                ),
                                              );
                                            }
                                        );
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
              },
            ),
          )
      ),
    );
  }
}