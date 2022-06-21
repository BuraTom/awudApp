import 'dart:convert';

import 'package:awud_application/model/musicModel.dart';
import 'package:awud_application/pages/search.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class infoPage extends StatefulWidget {
  final String id;
  final String name;

  infoPage({Key? key,required this.id, required this.name}) : super(key: key);

  @override
  State<infoPage> createState() => _infoPageState();
}


class _infoPageState extends State<infoPage> {

  var fetchedMusic;

  Future printValue() async {
    var response = await Dio().get('http://${IpAddresse}:5000/music/${widget.id}');

    if (response.statusCode == 200) {
      fetchedMusic = FetchedMusic.fromJson(response.data);

      print(fetchedMusic);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
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
                              "${widget.name}",
                              style: TextStyle(
                                  fontSize: 25,
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
                                                context:context,
                                                delegate: MySearchDelegate(),
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
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 200,
                                    child: FutureBuilder(
                                      future: printValue(),
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
                                              itemCount: fetchedMusic == null ? 0: 1,
                                              itemBuilder: (BuildContext context, int index){
                                               // print(result);
                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius: BorderRadius.circular(5),
                                                          child: Image.asset(
                                                            'assets/images/telahun.jpg',
                                                            height: 100,
                                                            width: 100,
                                                            fit: BoxFit.fill,
                                                          )
                                                      ),
                                                      Text('data')
                                                    ],
                                                  ),
                                                  // ),
                                                );
                                              }
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
    )
    )
                      )
    )
    );
  }

}