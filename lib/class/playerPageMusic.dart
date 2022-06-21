import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:awud_application/model/musicModel.dart';
import 'package:awud_application/pages/lyrics.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import '../main.dart';
import 'audio_file.dart';
import 'downloadPage.dart';

class playerPage extends StatefulWidget {
  final String id;
  final String name;

  playerPage({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  _playerPageState createState() => _playerPageState();
}

class _playerPageState extends State<playerPage> {
  String textFile = 'Empty';
  late AudioPlayer advancedPlayer;
  List? result;
  var episode;
  String? path;

  var fetchedMusic;

  Future printValue() async {
    var response = await Dio().get('http://${IpAddresse}:5000/music/${widget.id}');
    path = 'http://192.168.1.7:5000/music/${widget.id}';

    if (response.statusCode == 200) {
      fetchedMusic = FetchedMusic.fromJson(response.data);
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
                      itemCount: fetchedMusic == null ? 0 : 1,
                      itemBuilder: (BuildContext context,int index){
                        return Container(
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => lyricsPage(lyrics:""),
                                      ));
                                    });
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset("${fetchedMusic.image}",
                                          height: 250,
                                          width: 250,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   onTap: (){
                                      //     setState(() {
                                      //       Navigator.of(context).push(MaterialPageRoute(
                                      //         builder: (context) => lyricsPage(lyrics:""),
                                      //       ));
                                      //     });
                                      //   },
                                      //   child: Container(
                                      //     margin: EdgeInsets.all(10),
                                      //     width: 70,
                                      //     height: 30,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(5),
                                      //         color: Color.fromRGBO(248, 135, 88, 1)
                                      //     ),
                                      //     child: Center(
                                      //       child: Text(
                                      //         'Lyrics',
                                      //         style: TextStyle(
                                      //           color: Colors.white,
                                      //           fontWeight: FontWeight.bold,
                                      //           fontSize: 16
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                                // SizedBox(height: 80),
                                Container(
                                  margin: EdgeInsets.only(left: 45,top: 25),
                                  child: Row(
                                    children: [
                                      Icon(FeatherIcons.heart,color: Colors.black,),
                                      SizedBox(width: 60),
                                      GestureDetector(
                                        onTap: (){
                                          showDialog(
                                            context: context,
                                            builder: (context) => DownloadingDialog(path:"${path}/${fetchedMusic.title}",file_name:fetchedMusic.title),
                                          );
                                        },
                                          child: Icon(FeatherIcons.download,color: Colors.black,)
                                      ),
                                      SizedBox(width: 60),
                                      GestureDetector(
                                          onTap: (){
                                            Share.share('${fetchedMusic.title}\n${fetchedMusic.music_description}', subject: 'Look what I made!');
                                          },
                                          child: Icon(FeatherIcons.share2,color: Colors.black,
                                          )
                                      ),
                                      SizedBox(width: 60),
                                      GestureDetector(
                                          onTap: (){
                                            openAlert();
                                          },
                                          child: Icon(FeatherIcons.plus,color: Colors.black,
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
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
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: fetchedMusic == null ? 0 : 1,
                                            itemBuilder: (BuildContext context,int index){
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      fetchedMusic.title.toString(),
                                                      style: TextStyle(
                                                          fontSize:30,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black
                                                      ),
                                                    ),
                                                    Text(
                                                      fetchedMusic.artist_name.toString(),
                                                      style: TextStyle(
                                                          fontSize:17,
                                                          color: Colors.grey
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height:30),
                                                    TextButton(onPressed: () async{
                                                      String response;
                                                      response = await rootBundle.loadString('assets/text/text.txt');
                                                      textFile = response;
                                                      showTest();
                                                    }, child: Text('Lyrics',style: TextStyle(fontSize: 20,color: Colors.black))),
                                                   // Container(margin: EdgeInsets.only(top: 30),child: MyAppp(path:"assets/audio/${fetchedMusic.path}",playlist: [])),
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
                          // ),
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

  Future<String?> openAlert() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select a playlist',style: TextStyle(fontSize: 25)),
        content:Column(
          children: [
            Align(alignment: Alignment.centerLeft,child: Text('Cool playlist',style: TextStyle(fontSize: 17))),
            SizedBox(height: 5),
            Align(alignment: Alignment.centerLeft,child: Text('10',style: TextStyle(fontSize: 15,color: Colors.grey)))
          ],
        ),
        actions: [
          TextButton(onPressed: (){
            createPlaylist();
          },
              child: Text('New Playlist',style: TextStyle(fontSize: 18))
          )
        ],
      )
  );

  Future<String?> createPlaylist() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Playlist name'),
        content: TextField(
          // controller: playlistnameController,
          autofocus: true,
          decoration: InputDecoration(
            hintText:'Enter your playlist name',
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            // submit();
          },
              child: Text('CREATE',style: TextStyle(fontSize: 18))
          )
        ],
      )
  );

  Future showTest() => showSlidingBottomSheet(
      context,
      builder: (context) => SlidingSheetDialog(
        snapSpec: SnapSpec(snappings: [0.4, 0.7]),
        builder: buildSheet,
      )
  );

  Widget buildSheet(context, state) => Material(
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Center(
            child: Text(textFile,style: TextStyle(fontSize: 18)),
          ),
        )
      ],
    ),
  );

}