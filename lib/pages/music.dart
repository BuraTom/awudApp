import 'dart:convert';
import 'package:awud_application/class/infoPageMusic.dart';
import 'package:awud_application/class/playerPageMusic.dart';
import 'package:awud_application/model/skeleton.dart';
import 'package:awud_application/pages/searchMusic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:shimmer/shimmer.dart';
import '../main.dart';
import 'notifications.dart';
import 'settings.dart';
import 'package:http/http.dart' as http;

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  List? music;
  List? album;

  Future getPodcast() async{
    var response = await http.get(Uri.parse('http://${IpAddresse}:5000/music'));

    if(response.statusCode == 200){
      music = json.decode(response.body);
      return music;
    }
  }

  Future getAlbum() async{
    var response = await http.get(Uri.parse('http://${IpAddresse}:5000/album'));

    if(response.statusCode == 200){
      album = json.decode(response.body);
      return album;
    }
  }

  @override
  void initState() {
    getPodcast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          routes: {
            '/notification': (context) => Notifications(),
            '/setting': (context) => HomeScreen()
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light
          ),
          home: Scaffold(
            body: SafeArea(
              child: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) =>[
                  SliverOverlapAbsorber(
                    handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverAppBar(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      title: Text(
                        "Music",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      actions: [
                        Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: Row(
                              children:[
                                Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: GestureDetector(
                                      onTap: (){
                                        showSearch(
                                            context: context,
                                            delegate: MySearchDelegate()
                                        );
                                      },
                                      child: Icon(
                                        FeatherIcons.search,
                                        color: Color.fromRGBO(248, 135, 88, 1),
                                        size: 20,
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, '/notification');
                                    },
                                    child: Icon(
                                      FeatherIcons.bell,
                                      color: Color.fromRGBO(248, 135, 88, 1),
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, '/setting');
                                    },
                                    child: Icon(
                                      FeatherIcons.settings,
                                      color: Color.fromRGBO(248, 135, 88, 1),
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  )
                ],
                body: SafeArea(
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 5,right: 5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20,left: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Recently played',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 153,
                            child: FutureBuilder(
                              future: getPodcast(),
                              builder: (context,snapshot){
                                if(snapshot.connectionState == ConnectionState.none && snapshot.hasData == null){
                                  return Container(
                                    child: Text('No Data'),
                                  );
                                }
                                else if(snapshot.connectionState == ConnectionState.waiting){
                                  return Container(
                                      child: Column(
                                        children: [
                                          Row(
                                           children: [
                                             Column(
                                               children: [
                                                 Skelton(
                                                   height: 100,
                                                   width: 100,
                                                 ),
                                                 SizedBox(width: 110),
                                                 SizedBox(height: 10),
                                                 Skelton(width: 90),
                                                 SizedBox(height: 10),
                                                 Skelton(width: 90),
                                               ],
                                             ),
                                             Column(
                                               children: [
                                                 Skelton(
                                                   height: 100,
                                                   width: 100,
                                                 ),
                                                 SizedBox(width: 110),
                                                 SizedBox(height: 10),
                                                 Skelton(width: 90),
                                                 SizedBox(height: 10),
                                                 Skelton(width: 90),
                                               ],
                                             ),
                                             Column(
                                               children: [
                                                 Skelton(
                                                   height: 100,
                                                   width: 100,
                                                 ),
                                                 SizedBox(width: 110),
                                                 SizedBox(height: 10),
                                                 Skelton(width: 90),
                                                 SizedBox(height: 10),
                                                 Skelton(width: 90),
                                               ],
                                             )
                                           ],
                                          )
                                        ],
                                      ),
                                  );
                                }else{
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: music == null ? 0: music!.length,
                                      itemBuilder: (BuildContext context, int index){
                                        return Container(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => playerPage(id: music![index]['_id'].toString(),name: music![index]['title'].toString()),
                                                      ));
                                                    });
                                                  },
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(5),
                                                      child: Image.asset(
                                                        '${music![index]['image']}',
                                                        height: 100,
                                                        width: 100,
                                                        fit: BoxFit.fill,
                                                      )
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  music![index]['title'],
                                                  style: TextStyle(
                                                      fontSize: 15
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  music![index]['artist_name'],
                                                  style: TextStyle(
                                                      color: Colors.grey
                                                  ),
                                                ),
                                                SizedBox(width: 110)
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20,left: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Album\'s you\'ll love',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10,left: 15),
                            height: 100,
                            child: GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              children: [
                                FutureBuilder(
                                  future: getAlbum(),
                                  builder: (context,snapshot){
                                    if(snapshot.connectionState == ConnectionState.none && snapshot.hasData == null){
                                      return Container(
                                        child: Text('No Data'),
                                      );
                                    }
                                    else if(snapshot.connectionState == ConnectionState.waiting){
                                      return Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Skelton(
                                                        height: 100,
                                                        width: 100,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                      );
                                    }else{
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: album == null ? 0: album!.length,
                                          itemBuilder: (BuildContext context, int index){
                                              return Container(
                                                // child: SingleChildScrollView(
                                                //   scrollDirection: Axis.vertical,
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            print(album![index]['artist_name']);
                                                          });
                                                        },
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(5),
                                                            child: Image.asset(
                                                              '${album![index]['album_image']}',
                                                              height: 100,
                                                              width: 100,
                                                              fit: BoxFit.fill,
                                                            )
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                // ),
                                              );
                                          }
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20,left: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Artist you might like',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(70), // Image radius
                                      child: Image.asset('assets/images/telahun.jpg', fit: BoxFit.cover),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20,left: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('New Release for you',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 153,
                            child: FutureBuilder(
                              future: getPodcast(),
                              builder: (context,snapshot){
                                if(snapshot.connectionState == ConnectionState.none && snapshot.hasData == null){
                                  return Container(
                                    child: Text('No Data'),
                                  );
                                }
                                else if(snapshot.connectionState == ConnectionState.waiting){
                                  return Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Skelton(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                                  SizedBox(width: 110),
                                                  SizedBox(height: 10),
                                                  Skelton(width: 90),
                                                  SizedBox(height: 10),
                                                  Skelton(width: 90),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Skelton(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                                  SizedBox(width: 110),
                                                  SizedBox(height: 10),
                                                  Skelton(width: 90),
                                                  SizedBox(height: 10),
                                                  Skelton(width: 90),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Skelton(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                                  SizedBox(width: 110),
                                                  SizedBox(height: 10),
                                                  Skelton(width: 90),
                                                  SizedBox(height: 10),
                                                  Skelton(width: 90),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                  );
                                }else{
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: music == null ? 0: music!.length,
                                      itemBuilder: (BuildContext context, int index){
                                        return Container(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    // setState(() {
                                                    //   // print((json.decode(jsonData![index])).runtimeType);
                                                    //   Navigator.of(context).push(MaterialPageRoute(
                                                    //     builder: (context) => infoPage(id: jsonData![index]['_id'].toString(),name: jsonData![index]['podcast_title'].toString()),
                                                    //   ));
                                                    // });
                                                  },
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(5),
                                                      child: Image.asset(
                                                        '${music![index]['image']}',
                                                        height: 100,
                                                        width: 100,
                                                        fit: BoxFit.fill,
                                                      )
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  music![index]['title'],
                                                  style: TextStyle(
                                                      fontSize: 15
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  music![index]['artist_name'],
                                                  style: TextStyle(
                                                      color: Colors.grey
                                                  ),
                                                ),
                                                SizedBox(width: 110)
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ),
            ),
          )
      );
  }
}