import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:awud_application/class/infoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../main.dart';
import 'settings.dart';
import 'notifications.dart';
import 'search.dart';
import 'package:http/http.dart' as http;

class Podcast extends StatefulWidget {
  const Podcast({Key? key}) : super(key: key);

  @override
  State<Podcast> createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> {
  List? jsonData;
  List? episodes;
  // String value = '';
  Future getPodcast() async{
    var response = await http.get(Uri.parse('http://${IpAddresse}:5000/podcast'));

    if(response.statusCode == 200){
      jsonData = json.decode(response.body);
      return jsonData;
    }
  }

  @override
  void initState() {
    getPodcast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getPodcast();
    return MaterialApp(
        routes: {
          '/notification': (context) => Notifications(),
          '/setting': (context) => HomeScreen()
        },
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
                      title: const Text(
                        "Podcast",
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
                              child: Text('Recent',
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
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Color.fromRGBO(248, 135, 88, 1),
                                        ),
                                      )
                                  );
                                }else{
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: jsonData == null ? 0: jsonData!.length,
                                      itemBuilder: (BuildContext context, int index){
                                        return Container(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      // print((json.decode(jsonData![index])).runtimeType);
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => infoPage(id: jsonData![index]['_id'].toString(),name: jsonData![index]['podcast_title'].toString()),
                                                      ));
                                                    });
                                                  },
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(5),
                                                      child: Image.asset(
                                                        '${jsonData![index]['image']}',
                                                        height: 100,
                                                        width: 100,
                                                        fit: BoxFit.fill,
                                                      )
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  jsonData![index]['podcast_title'],
                                                  style: TextStyle(
                                                      fontSize: 15
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  jsonData![index]['artist_name'],
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
                              child: Text('Technology',
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
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Color.fromRGBO(248, 135, 88, 1),
                                        ),
                                      )
                                  );
                                }else{
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: jsonData == null ? 0: jsonData!.length,
                                      itemBuilder: (BuildContext context, int index){
                                        if((jsonData![index]['category']).contains('Technology')){
                                          return Container(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        // print((json.decode(jsonData![index])).runtimeType);
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => infoPage(id: jsonData![index]['_id'].toString(),name: jsonData![index]['podcast_title'].toString()),
                                                        ));
                                                      });
                                                    },
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(5),
                                                        child: Image.asset(
                                                          '${jsonData![index]['image']}',
                                                          height: 100,
                                                          width: 100,
                                                          fit: BoxFit.fill,
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    jsonData![index]['podcast_title'],
                                                    style: TextStyle(
                                                        fontSize: 15
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    jsonData![index]['artist_name'],
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                    ),
                                                  ),
                                                  SizedBox(width: 110)
                                                ],
                                              ),
                                            ),
                                          );
                                        }else{
                                          return Container();
                                        }
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
                              child: Text('Entertainment',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 150,
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
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Color.fromRGBO(248, 135, 88, 1),
                                        ),
                                      )
                                  );
                                }else{
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: jsonData == null ? 0: jsonData!.length,
                                      itemBuilder: (BuildContext context, int index){
                                        if((jsonData![index]['category']).contains('Entertainment')){
                                          return Container(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        print(jsonData![index]['podcast_title']);
                                                      });
                                                    },
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(5),
                                                        child: Image.asset(
                                                          '${jsonData![index]['image']}',
                                                          height: 100,
                                                          width: 100,
                                                          fit: BoxFit.fill,
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    jsonData![index]['podcast_title'],
                                                    style: TextStyle(
                                                        fontSize: 15
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    jsonData![index]['artist_name'],
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                    ),
                                                  ),
                                                  SizedBox(width: 110)
                                                ],
                                              ),
                                            ),
                                          );
                                        }else{
                                          return Container();
                                        }
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