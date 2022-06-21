import 'package:awud_application/class/infoPageAudiobook.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'settings.dart';
import 'notifications.dart';
import 'searchAudiobook.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
//import 'package:cached_network_image/cached_network_image.dart';

class Audiobook extends StatefulWidget {
  const Audiobook({Key? key}) : super(key: key);

  @override
  State<Audiobook> createState() => _AudiobookState();
}

class _AudiobookState extends State<Audiobook> {

  List? jsonData;
  List? episodes;

  // String value = '';
  Future getPodcast() async {
    var response = await http.get(
        Uri.parse('http://${IpAddresse}:8000/audioBook'));

    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      return jsonData;
    }
  }

  @override
  void initState() {
//print(jsonData![0]['image']) ;
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
        home: Scaffold(
          body: SafeArea(
            child: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) =>
                [
                  SliverOverlapAbsorber(
                    handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverAppBar(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      title: const Text(
                        "Audiobook",
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
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: GestureDetector(
                                      onTap: () {
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
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/notification');
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
                                    onTap: () {
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
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 5),
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
                            height: 200,
                            child: FutureBuilder(
                              future: getPodcast(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.none &&
                                    snapshot.hasData == null) {
                                  return Container(
                                    child: Text('No Data'),
                                  );
                                }
                                else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Color.fromRGBO(
                                              248, 135, 88, 1),
                                        ),
                                      )
                                  );
                                } else {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: jsonData == null
                                          ? 0
                                          : jsonData!.length,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return Container(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {

                                                      Navigator.of(context)
                                                          .push(
                                                          MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                infoPageAudiobook(
                                                                    id: jsonData![index]['_id']
                                                                        .toString(),
                                                                    name: jsonData![index]['title']
                                                                        .toString()),
                                                          ));
                                                    });
                                                  },
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(5),
                                                      child: Image.network(
                                                       // jsonData![index]['image'],
                                                        'http://192.168.43.196:8000/${jsonData![index]['image']}',
                                                        height: 150,
                                                        width: 100,
                                                        fit: BoxFit.fill,
                                                      )
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  jsonData![index]['title'],
                                                  style: TextStyle(
                                                      fontSize: 15
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  jsonData![index]['author_name'],
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
                            margin: EdgeInsets.only(top: 20, left: 5),
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
                            height: 200,
                            child: FutureBuilder(
                              future: getPodcast(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.none &&
                                    snapshot.hasData == null) {
                                  return Container(
                                    child: Text('No Data'),
                                  );
                                }
                                else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Color.fromRGBO(
                                              248, 135, 88, 1),
                                        ),
                                      )
                                  );
                                } else {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: jsonData == null
                                          ? 0
                                          : jsonData!.length,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        if ((jsonData![index]['category'])
                                            .contains('Technology')) {
                                          return Container(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        // print((json.decode(jsonData![index])).runtimeType);
                                                        Navigator.of(context)
                                                            .push(
                                                            MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  infoPageAudiobook(
                                                                      id: jsonData![index]['_id']
                                                                          .toString(),
                                                                      name: jsonData![index]['audiobook_title']
                                                                          .toString()),
                                                            ));
                                                      });
                                                    },
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius
                                                            .circular(5),
                                                        child:
                                                        // CachedNetworkImage(
                                                        //   height: 150,
                                                        //   width: 100,
                                                        //   fit: BoxFit.fill,
                                                        //   imageUrl: "http://192.168.43.196:8000/routes/audiobook/photo/aasstu.png",
                                                        //   placeholder: (context, url) => CircularProgressIndicator(),
                                                        //   errorWidget: (context, url, error) => Icon(Icons.error),
                                                        // ),
                                                      // CachedNetworkImage(
                                                      //   imageUrl: "http://192.168.43.196:8000/routes/audiobook/photo/aasstu.png",
                                                      //   imageBuilder: (context, imageProvider) => Container(
                                                      //     decoration: BoxDecoration(
                                                      //       image: DecorationImage(
                                                      //           image: imageProvider,
                                                      //           fit: BoxFit.cover,
                                                      //           colorFilter:
                                                      //           ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                                                      //     ),
                                                      //   ),
                                                      //   placeholder: (context, url) => CircularProgressIndicator(),
                                                      //   errorWidget: (context, url, error) => Icon(Icons.error),
                                                      // ),

                                                        Image.network(

                                                       jsonData![index]['image'],
                                                       //   'http://192.168.43.196:8000/routes/audiobook/photo/aasstu.png',
                                                          height: 150,
                                                          width: 100,
                                                          fit: BoxFit.fill,
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    jsonData![index]['title'],
                                                    style: TextStyle(
                                                        fontSize: 15
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    jsonData![index]['author_name'],
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                    ),
                                                  ),
                                                  SizedBox(width: 110)
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 5),
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
                            height: 200,
                            child: FutureBuilder(
                              future: getPodcast(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.none &&
                                    snapshot.hasData == null) {
                                  return Container(
                                    child: Text('No Data'),
                                  );
                                }
                                else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Color.fromRGBO(
                                              248, 135, 88, 1),
                                        ),
                                      )
                                  );
                                } else {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: jsonData == null
                                          ? 0
                                          : jsonData!.length,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        if ((jsonData![index]['category'])
                                            .contains('Entertainment')) {
                                          return Container(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        // print((json.decode(jsonData![index])).runtimeType);
                                                        Navigator.of(context)
                                                            .push(
                                                            MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  infoPageAudiobook(
                                                                      id: jsonData![index]['_id']
                                                                          .toString(),
                                                                      name: jsonData![index]['title']
                                                                          .toString()),
                                                            ));
                                                      });
                                                    },
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius
                                                            .circular(5),
                                                        child: Image.asset(
                                                          '',
                                                          height: 150,
                                                          width: 100,
                                                          fit: BoxFit.fill,
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    jsonData![index]['title'],
                                                    style: TextStyle(
                                                        fontSize: 15
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    jsonData![index]['author_name'],
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                    ),
                                                  ),
                                                  SizedBox(width: 110)
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
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