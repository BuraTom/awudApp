import 'package:awud_application/API/podcast_api.dart';
import 'package:awud_application/class/infoPage.dart';
import 'package:awud_application/model/podcastModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate{
  List<String> searchResults = [];

  BooksApi _userList = BooksApi();

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    onPressed: ()=>close(context, null),
    icon: const Icon(Icons.arrow_back),
  );

  @override
  List<Widget> ? buildActions(BuildContext context) => [
    IconButton(
      onPressed: (){
        if(query.isEmpty){
          close(context, null);
        }else{
          query = '';
        }
      },
      icon: const Icon(Icons.clear),
    )
  ];

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<FetchedPodcast>>(
        future: _userList.getuserList(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // print('No Data');
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(248, 135, 88, 1),
              ),
            );
          }
          List<FetchedPodcast>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      SizedBox(height: 70),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset('${data?[index].image}')
                          ),
                          // child: Image.asset(
                          //     '${data?[index].image}',
                          // ),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => infoPage(id: (data?[index].id).toString(),name: (data?[index].podcast_title).toString()),
                          ));
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data?[index].podcast_title}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${data?[index].artist_name}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ]),
                      )
                    ],
                  ),
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context){
    return Center(
      child: Text('Search Podcast'),
    );
  }
}