import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class playlist extends StatefulWidget {
  const playlist({Key? key}) : super(key: key);

  @override
  _playlistState createState() => _playlistState();
}

class _playlistState extends State<playlist> {

  late TextEditingController playlistnameController;
  String name = '';

  @override
  void initState(){
    super.initState();

    playlistnameController = TextEditingController();
  }

  @override
  void dispose(){
    playlistnameController.dispose();

    super.dispose();
  }

  // List? playlist;
  //
  // Future getPodcast() async{
  //   var response = await http.get(Uri.parse('http://192.168.43.127:5000/music'));
  //
  //   if(response.statusCode == 200){
  //     playlist = json.decode(response.body);
  //     return playlist;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                "Playlist",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),
          )
        ],
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async{
                  final playlistName = await createPlaylist();
                  print(playlistName);
                  if(playlistName == null || playlistName.isEmpty) return;
                  setState(() {
                    this.name = playlistName;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20,left: 15),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black54,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Icon(Icons.add),
                      ),
                      SizedBox(width: 10),
                      Text('Create a playlist',style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30,left: 15),
                child: Align(alignment: Alignment.centerLeft,child: Text('Your playlist',style: TextStyle(color: Colors.grey,fontSize: 20))),
              ),
              Container(
                margin: EdgeInsets.only(top: 30,left: 15),
                child: Column(
                  children: [
                    Align(alignment: Alignment.centerLeft,child: Text('Cool playlist',style: TextStyle(fontSize: 17))),
                    SizedBox(height: 5),
                    Align(alignment: Alignment.centerLeft,child: Text('10',style: TextStyle(fontSize: 15,color: Colors.grey)))
                  ],
                )
              ),
            ],
          ),
        ),
      ),
      ),
    ),
    )
    );
  }

  Future<String?> createPlaylist() => showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Playlist name'),
      content: TextField(
        controller: playlistnameController,
        autofocus: true,
        decoration: InputDecoration(
          hintText:'Enter your playlist name',
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          submit();
        },
            child: Text('CREATE',style: TextStyle(fontSize: 18))
        )
      ],
    )
  );

  void submit() {
    Navigator.of(context).pop(playlistnameController.text);
  }
}
