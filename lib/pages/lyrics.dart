import 'package:flutter/material.dart';

class lyricsPage extends StatelessWidget {
  String lyrics;
  lyricsPage({Key? key,required this.lyrics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Text(
              'Lyrics',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      )
    );
  }
}
