// // import 'dart:async';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:just_audio/just_audio.dart';
// //
// // class Player extends StatefulWidget {
// //   final String path;
// //   // final AudioPlayer advancedPlayer;
// //
// //   const Player({Key? key,required this.path}) : super(key: key);
// //
// //   @override
// //   _PlayerState createState() => _PlayerState();
// // }
// //
// // class _PlayerState extends State<Player> {
// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     throw UnimplementedError();
// //   }
// // }
//
// import 'package:audio_service/audio_service.dart';
// import 'package:flutter/foundation.dart';
// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'global.dart';
// // void main() => runApp(MyApp());
//
// late AudioPlayer _audioPlayer;
//
// class MyAp extends StatefulWidget {
//   final String path;
//   final List? playlist;
//
//   const MyAp({Key? key, required this.path, required this.playlist}) : super(key: key);
//
//   @override
//   _MyApState createState() => _MyApState();
// }
//
// // use GetIt or Provider rather than a global variable in a real project
// PageManager? _pageManager;
//
// class _MyApState extends State<MyAp> {
//   @override
//   void initState() {
//     super.initState();
//     _pageManager = PageManager(widget.playlist);
//   }
//
//   @override
//   void dispose() {
//     _pageManager!.dispose();
//     super.dispose();
//   }
//
//   void previous(){
//     setState(() {
//       globalVar().index - 1;
//     });
//   }
//
//   void next(){
//     setState(() {
//       globalVar().index + 1;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // String dropdownValue = '1.0x';
//     return  Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//
//             //  CurrentSongTitle(),
//             //  Playlist(),
//              // AddRemoveSongButtons(),
//               AudioProgressBar(),
//               AudioControlButtons(),
//             ],
//           ),
//     );
//   }
// }
//
// // class CurrentSongTitle extends StatelessWidget {
// //   const CurrentSongTitle({Key? key}) : super(key: key);
// //   @override
// //   Widget build(BuildContext context) {
// //     return ValueListenableBuilder<String>(
// //       valueListenable: _pageManager.currentSongTitleNotifier,
// //       builder: (_, title, __) {
// //         return Padding(
// //           padding: const EdgeInsets.only(top: 8.0),
// //           child: Text(title, style: TextStyle(fontSize: 40)),
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // class Playlist extends StatelessWidget {
// //   const Playlist({Key? key}) : super(key: key);
// //   @override
// //   Widget build(BuildContext context) {
// //     return Expanded(
// //       child: ValueListenableBuilder<List<String>>(
// //         valueListenable: _pageManager.playlistNotifier,
// //         builder: (context, playlistTitles, _) {
// //           return ListView.builder(
// //             itemCount: playlistTitles.length,
// //             itemBuilder: (context, index) {
// //               return ListTile(
// //                 title: Text('${playlistTitles[index]}'),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// //
// // class AddRemoveSongButtons extends StatelessWidget {
// //   const AddRemoveSongButtons({Key? key}) : super(key: key);
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 20.0),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //         children: [
// //           FloatingActionButton(
// //             onPressed: _pageManager.addSong,
// //             child: Icon(Icons.add),
// //           ),
// //           FloatingActionButton(
// //             onPressed: _pageManager.removeSong,
// //             child: Icon(Icons.remove),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// class AudioProgressBar extends StatelessWidget {
//   const AudioProgressBar({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ProgressBarState>(
//       valueListenable: _pageManager!.progressNotifier,
//       builder: (_, value, __) {
//         return ProgressBar(
//           progress: value.current,
//           buffered: value.buffered,
//           total: value.total,
//           onSeek: _pageManager!.seek,
//         );
//       },
//     );
//   }
// }
//
// class AudioControlButtons extends StatelessWidget {
//   const AudioControlButtons({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           RepeatButton(),
//           PreviousSongButton(),
//           PlayButton(),
//           NextSongButton(),
//           ShuffleButton(),
//         ],
//       ),
//     );
//   }
// }
//
// // Widget _repeatButton(BuildContext context, LoopMode loopMode) {
// //   final icons = [
// //     Icon(Icons.repeat),
// //     Icon(Icons.repeat, color: Theme.of(context).accentColor),
// //     Icon(Icons.repeat_one, color: Theme.of(context).accentColor),
// //   ];
// //   const cycleModes = [
// //     LoopMode.off,
// //     LoopMode.all,
// //     LoopMode.one,
// //   ];
// //   final index = cycleModes.indexOf(loopMode);
// //   return IconButton(
// //     icon: icons[index],
// //     onPressed: () {
// //       _audioPlayer.setLoopMode(
// //           cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
// //     },
// //   );
// // }
//
// class RepeatButton extends StatelessWidget {
//   const RepeatButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<RepeatState>(
//       valueListenable: _pageManager!.repeatButtonNotifier,
//       builder: (context, value, child) {
//         Icon icon;
//         switch (value) {
//           case RepeatState.off:
//             icon = Icon(Icons.repeat, color: Colors.grey);
//             break;
//           case RepeatState.repeatSong:
//             icon = Icon(Icons.repeat_one);
//             break;
//           case RepeatState.repeatPlaylist:
//             icon = Icon(Icons.repeat);
//             break;
//         }
//         return IconButton(
//           icon: icon,
//           onPressed: _pageManager!.onRepeatButtonPressed,
//         );
//       },
//     );
//   }
// }
//
//
// // Widget _previousButton() {
// //   return IconButton(
// //     icon: Icon(Icons.skip_previous),
// //     onPressed: _audioPlayer.hasPrevious ? _audioPlayer.seekToPrevious : null,
// //   );
// // }
// class PreviousSongButton extends StatelessWidget {
//   const PreviousSongButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: _pageManager!.isFirstSongNotifier,
//       builder: (_, isFirst, __) {
//         return IconButton(
//           icon: Icon(Icons.skip_previous),
//           onPressed: _pageManager!.onPreviousSongButtonPressed,
//         );
//       },
//     );
//   }
// }
//
// class PlayButton extends StatelessWidget {
//   const PlayButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ButtonState>(
//       valueListenable: _pageManager!.playButtonNotifier,
//       builder: (_, value, __) {
//         switch (value) {
//           case ButtonState.loading:
//             return Container(
//               margin: EdgeInsets.all(8.0),
//               width: 32.0,
//               height: 32.0,
//               child: CircularProgressIndicator(),
//             );
//           case ButtonState.paused:
//             return IconButton(
//               icon: Icon(Icons.play_arrow),
//               iconSize: 32.0,
//               onPressed: _pageManager!.play,
//             );
//           case ButtonState.playing:
//             return IconButton(
//               icon: Icon(Icons.pause),
//               iconSize: 32.0,
//               onPressed: _pageManager!.pause,
//             );
//         }
//       },
//     );
//   }
// }
//
// Widget _nextButton() {
//   return IconButton(
//     icon: Icon(Icons.skip_next),
//     onPressed: _audioPlayer.hasNext ? _audioPlayer.seekToNext : null,
//   );
// }
//
// class NextSongButton extends StatelessWidget {
//   const NextSongButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: _pageManager!.isLastSongNotifier,
//       builder: (_, isLast, __) {
//         return IconButton(
//           icon: Icon(Icons.skip_next),
//           onPressed: (isLast) ? null : _pageManager!.onNextSongButtonPressed,
//         );
//       },
//     );
//   }
// }
//
// class ShuffleButton extends StatelessWidget {
//   const ShuffleButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: _pageManager!.isShuffleModeEnabledNotifier,
//       builder: (context, isEnabled, child) {
//         return IconButton(
//           icon: (isEnabled)
//               ? Icon(Icons.shuffle)
//               : Icon(Icons.shuffle, color: Colors.grey),
//           onPressed: _pageManager!.onShuffleButtonPressed,
//         );
//       },
//     );
//   }
// }
//
// class PlayButtonNotifier extends ValueNotifier<ButtonState> {
//   PlayButtonNotifier() : super(_initialValue);
//   static const _initialValue = ButtonState.paused;
// }
//
// enum ButtonState { playing, paused, loading}
//
//
// class ProgressNotifier extends ValueNotifier<ProgressBarState> {
//   ProgressNotifier() : super(_initialValue);
//   static const _initialValue = ProgressBarState(
//     current: Duration.zero,
//     buffered: Duration.zero,
//     total: Duration.zero,
//   );
//
// }
//
// class ProgressBarState {
//   const ProgressBarState({
//     required this.current,
//     required this.buffered,
//     required this.total,
//   });
//   final Duration current;
//   final Duration buffered;
//   final Duration total;
// }
//
//
//
// class RepeatButtonNotifier extends ValueNotifier<RepeatState> {
//   RepeatButtonNotifier() : super(_initialValue);
//   static const _initialValue = RepeatState.off;
//
//   void nextState() {
//     final next = (value.index + 1) % RepeatState.values.length;
//     value = RepeatState.values[next];
//   }
// }
//
// enum RepeatState {
//   off,
//   repeatSong,
//   repeatPlaylist,
// }
//
// class PageManager{
//
//   final currentSongTitleNotifier = ValueNotifier<String>('');
//   final playlistNotifier = ValueNotifier<List<String>>([]);
//   final progressNotifier = ProgressNotifier();
//   final repeatButtonNotifier = RepeatButtonNotifier();
//   final isFirstSongNotifier = ValueNotifier<bool>(true);
//   final playButtonNotifier = PlayButtonNotifier();
//   final isLastSongNotifier = ValueNotifier<bool>(true);
//   final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);
//
//   PageManager(path) {
//     _init(path);
//   }
//
//   void _init(List pt) async {
//     _audioPlayer = AudioPlayer();
//     _setInitialPlaylist(pt);
//     _listenForChangesInPlayerState();
//     _listenForChangesInPlayerPosition();
//     _listenForChangesInBufferedPosition();
//     _listenForChangesInTotalDuration();
//     _listenForChangesInSequenceState();
//   }
//
//   // TODO: set playlist
//   void _setInitialPlaylist(List url) async {
//     await _audioPlayer.setAsset(url.elementAt(globalVar().index));
//   }
//
//   void _listenForChangesInPlayerState() {
//     _audioPlayer.playerStateStream.listen((playerState) {
//       final isPlaying = playerState.playing;
//       final processingState = playerState.processingState;
//       if (processingState == ProcessingState.loading ||
//           processingState == ProcessingState.buffering) {
//         playButtonNotifier.value = ButtonState.loading;
//       } else if (!isPlaying) {
//         playButtonNotifier.value = ButtonState.paused;
//       } else if (processingState != ProcessingState.completed) {
//         playButtonNotifier.value = ButtonState.playing;
//       } else {
//         _audioPlayer.seek(Duration.zero);
//         _audioPlayer.pause();
//       }
//     });
//   }
//
//   void _listenForChangesInPlayerPosition() {
//     _audioPlayer.positionStream.listen((position) {
//       final oldState = progressNotifier.value;
//       progressNotifier.value = ProgressBarState(
//         current: position,
//         buffered: oldState.buffered,
//         total: oldState.total,
//       );
//     });
//   }
//
//   void _listenForChangesInBufferedPosition() {
//     _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
//       final oldState = progressNotifier.value;
//       progressNotifier.value = ProgressBarState(
//         current: oldState.current,
//         buffered: bufferedPosition,
//         total: oldState.total,
//       );
//     });
//   }
//
//   void _listenForChangesInTotalDuration() {
//     _audioPlayer.durationStream.listen((totalDuration) {
//       final oldState = progressNotifier.value;
//       progressNotifier.value = ProgressBarState(
//         current: oldState.current,
//         buffered: oldState.buffered,
//         total: totalDuration ?? Duration.zero,
//       );
//     });
//   }
//
//   void _listenForChangesInSequenceState() {
//     // TODO
//   }
//
//   void play() async {
//     _audioPlayer.play();
//   }
//
//   void pause() {
//     _audioPlayer.pause();
//   }
//
//   void seek(Duration position) {
//     _audioPlayer.seek(position);
//   }
//
//   void dispose() {
//     _audioPlayer.dispose();
//   }
//
//   void onRepeatButtonPressed() {
//     repeatButtonNotifier.nextState();
//     switch (repeatButtonNotifier.value) {
//       case RepeatState.off:
//         _audioPlayer.setLoopMode(LoopMode.off);
//         break;
//       case RepeatState.repeatSong:
//         _audioPlayer.setLoopMode(LoopMode.one);
//         break;
//       case RepeatState.repeatPlaylist:
//         _audioPlayer.setLoopMode(LoopMode.all);
//     }
//
//     // _audioPlayer.setLoopMode();
//     //_audioPlayer.loopMode;
//     // const cycleModes = [
//     //   LoopMode.off,
//     //   LoopMode.all,
//     //   LoopMode.one,
//     // ];
//     // _audioPlayer.setLoopMode(
//     //     cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
//   }
//
//   void onPreviousSongButtonPressed() {
//     if(globalVar().index != 0){
//      _MyApState().previous();
//     }
//     // _audioPlayer.seekToPrevious();
//     // _audioPlayer.hasPrevious ? _audioPlayer.seekToPrevious : print('no previous');
//   }
//
//   void onNextSongButtonPressed() {
//     _audioPlayer.seekToNext();
//     // _audioPlayer.hasNext ? _audioPlayer.seekToNext : null;
//   }
// // Widget _shuffleButton(BuildContext context, bool isEnabled) {
// //   return IconButton(
// //     icon: isEnabled
// //         ? Icon(Icons.shuffle, color: Theme.of(context).accentColor)
// //         : Icon(Icons.shuffle),
// //     onPressed: () async {
// //       final enable = !isEnabled;
// //       if (enable) {
// //         await _audioPlayer.shuffle();
// //       }
// //       await _audioPlayer.setShuffleModeEnabled(enable);
// //     },
// //   );
// // }
//   void onShuffleButtonPressed() async {
//     final enable = !_audioPlayer.shuffleModeEnabled;
//     if (enable) {
//       await _audioPlayer.shuffle();
//     }
//     await _audioPlayer.setShuffleModeEnabled(enable);
//   }
//
//   void addSong() {
//     // _audioPlayer.speed;
//      AudioPlayer audioPlayers = AudioPlayer();
//     // audioPlayers.setPlaybackRate(playbackRate: 1.0);
//     // TODO
//   }
//
//   void removeSong() {
//     // TODO
//   }
//
// }

// This example demonstrates how to play a playlist with a mix of URI and asset
// audio sources, and the ability to add/remove/reorder playlist items.
//
// To run:
//
// flutter run -t lib/example_playlist.dart

import 'dart:convert';

import 'package:audio_session/audio_session.dart';
import 'package:awud_application/class/downloadPage.dart';
import 'package:awud_application/main.dart';
import 'package:awud_application/pages/playlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:awud_application/common.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
// void main() => runApp(const MyApp());

class MyAppp extends StatefulWidget {
  // final String path;
  List? playlist;
  String current;
  var id;
   MyAppp({Key? key,required this.id,required this.current,required this.playlist}) : super(key: key);

  @override
  MyApppState createState() => MyApppState(curr:current,pl:playlist);
}

class MyApppState extends State<MyAppp> with WidgetsBindingObserver {
 // late String p =widget.path;
  // current episode,playlsit,epi_image,

 // late List? newPlaylist =[];
  String textFile = 'Empty';
  var fetchedMusic;
  String? path;

 late List? pl;
late String curr;
  MyApppState({required this.curr,this.pl});
 // MyApppState({this.playlist});
  late AudioPlayer _player;

 //
 // List? result;
 // List? episodes;
 // var num = 0;
 //
 // Future printValue() async{
 //   var response = await http.get(Uri.parse('http://${IpAddresse}:5000/audioBook/6290641e77142808ac143b99'));
 //
 //   if(response.statusCode == 200){
 //
 //     result = json.decode(response.body);
 //
 //     if(num != 1){
 //       for(int i=0;i<result![0]['Chapters'].length;i++){
 //         playlistt!.add("asset:assets/audio/${result![0]['Chapters'][i]['chapter_audio']}");
 //         num = 1;
 //       }
 //     }

 //     // playlist=
 //     return result;
 //   }
 // }

  // MyApppState(String path){
  //   p = path;
  // }


 List<AudioSource> plls(){
  var list=<AudioSource>[];
  list.add(AudioSource.uri(Uri.parse("http://${IpAddresse}:8000/${widget.current}"), tag: AudioMetadata(
    album: "Abrish p",
    title: "abel",
    artwork:
    "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
  ))
  );
  for (int t=0;t<widget.playlist!.length;t++)
  {
    //var mi=widget.playlist![t];
    var url = "http://${IpAddresse}:8000/${widget.playlist![0]}";
    list.add(AudioSource.uri(Uri.parse(url), tag: AudioMetadata(
      album: "Abrish p",
      title: "abel ${t}",
      artwork:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),));
  }
  return list;
}




 late var _playlist = ConcatenatingAudioSource(children:plls());

  //    children: [
  //   // Remove this audio source from the Windows and Linux version because it's not supported yet
  //   if (kIsWeb ||
  //       ![TargetPlatform.windows, TargetPlatform.linux]
  //           .contains(defaultTargetPlatform))
  //     plls();
  //  // AudioSource.uri(
  //  //   Uri.parse(
  //  //    // "asset:/${pl!.elementAt(0)}"),
  //  //       "http://${IpAddresse}:8000/${widget.current}"),
  //  //   tag: AudioMetadata(
  //  //     album: "Abrish p",
  //  //     title: "abel akjbds",
  //  //     artwork:
  //  //     "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
  //  //   ),
  //  // ),
  //
  //
  //  // AudioSource.uri(
  //  //   Uri.parse(
  //  //     // "asset:/${pl!.elementAt(0)}"),
  //  //       "http://${IpAddresse}:8000/${widget.playlist![0]}"),
  //  //   tag: AudioMetadata(
  //  //     album: "Abrish p",
  //  //     title: "abel 0",
  //  //     artwork:
  //  //     "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
  //  //   ),
  //  // ),
  //  //
  //  // AudioSource.uri(
  //  //   Uri.parse(
  //  //     // "asset:/${pl!.elementAt(0)}"),
  //  //       "http://${IpAddresse}:8000/${widget.playlist![1]}"),
  //  //   tag: AudioMetadata(
  //  //     album: "Abrish p",
  //  //     title: "abel 1",
  //  //     artwork:
  //  //     "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
  //  //   ),
  //  // ),
  //  // AudioSource.uri(
  //  //   Uri.parse(
  //  //     // "asset:/${pl!.elementAt(0)}"),
  //  //       "http://${IpAddresse}:8000/${widget.playlist![2]}"),
  //  //   tag: AudioMetadata(
  //  //     album: "Abrish p",
  //  //     title: "abel 2",
  //  //     artwork:
  //  //     "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
  //  //   ),
  //  // ),
  // ]
  // );
  int _addedCount = 0;

 // List? pp;
   @override
   void initState() {
     //playlistt=widget.playlist;
     // print( playlistt!.elementAt(0));
     // p = widget.path;
     //print(widget.id);
     int i;
     //
     for(i = 0; i < widget.playlist!.length; i++){
       if((widget.playlist!.contains(widget.current))){
         widget.playlist!.remove(widget.current);
       }
     }

     super.initState();
     ambiguate(WidgetsBinding.instance)!.addObserver(this);
     _player = AudioPlayer();
     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
       statusBarColor: Colors.black,
     ));
     _init();
   }

  Future<void> _init() async {
    print(widget.playlist);
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    try {
      // Preloading audio is not currently supported on Linux.
      await _player.setAudioSource( _playlist,
          preload: kIsWeb || defaultTargetPlatform != TargetPlatform.linux);
    } catch (e) {
      // Catch load errors: 404, invalid url...
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
     // _player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
   // List? pl= widget.playlist;
   // print(pl);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder<SequenceState?>(
                  stream: _player.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence.isEmpty ?? true) {
                      return const SizedBox();
                    }
                    final metadata = state!.currentSource!.tag as AudioMetadata;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Center(child: Image.network(metadata.artwork)),
                          ),
                        ),
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
                                      builder: (context) => DownloadingDialog(path:"${path}/${fetchedMusic.path}",file_name:fetchedMusic.path),
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
                        SizedBox(height: 10),
                        TextButton(onPressed: () async{
                          String response;
                          response = await rootBundle.loadString('assets/text/text.txt');
                          textFile = response;
                          showTest();
                        }, child: Text('Lyrics',style: TextStyle(fontSize: 20,color: Colors.black))),
                        SizedBox(height: 5),
                        Text(metadata.album,
                            style: Theme.of(context).textTheme.headline6),
                        Text(metadata.title),
                      ],
                    );
                  },
                ),
              ),
              ControlButtons(_player),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                    positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: (newPosition) {
                      _player.seek(newPosition);
                    },
                  );
                },
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  StreamBuilder<LoopMode>(
                    stream: _player.loopModeStream,
                    builder: (context, snapshot) {
                      final loopMode = snapshot.data ?? LoopMode.off;
                      const icons = [
                        Icon(Icons.repeat, color: Colors.grey),
                        Icon(Icons.repeat, color: Colors.orange),
                        Icon(Icons.repeat_one, color: Colors.orange),
                      ];
                      const cycleModes = [
                        LoopMode.off,
                        LoopMode.all,
                        LoopMode.one,
                      ];
                      final index = cycleModes.indexOf(loopMode);
                      return IconButton(
                        icon: icons[index],
                        onPressed: () {
                          _player.setLoopMode(cycleModes[
                          (cycleModes.indexOf(loopMode) + 1) %
                              cycleModes.length]);
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Playlist",
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: _player.shuffleModeEnabledStream,
                    builder: (context, snapshot) {
                      final shuffleModeEnabled = snapshot.data ?? false;
                      return IconButton(
                        icon: shuffleModeEnabled
                            ? const Icon(Icons.shuffle, color: Colors.orange)
                            : const Icon(Icons.shuffle, color: Colors.grey),
                        onPressed: () async {
                          final enable = !shuffleModeEnabled;
                          if (enable) {
                            await _player.shuffle();
                          }
                          await _player.setShuffleModeEnabled(enable);
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 240.0,
                child: StreamBuilder<SequenceState?>(
                  stream: _player.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    final sequence = state?.sequence ?? [];
                    return ReorderableListView(
                      onReorder: (int oldIndex, int newIndex) {
                        if (oldIndex < newIndex) newIndex--;
                        _playlist.move(oldIndex, newIndex);
                      },
                      children: [
                        for (var i = 0; i < sequence.length; i++)
                          Dismissible(
                            key: ValueKey(sequence[i]),
                            background: Container(
                              color: Colors.redAccent,
                              alignment: Alignment.centerRight,
                              child: const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                            onDismissed: (dismissDirection) {
                              _playlist.removeAt(i);
                            },
                            child: Material(
                              color: i == state!.currentIndex
                                  ? Colors.grey.shade300
                                  : null,
                              child: ListTile(
                                title: Text(sequence[i].tag.title as String),
                                onTap: () {
                                  _player.seek(Duration.zero, index: i);
                                },
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.add),
        //   onPressed: () {
        //     _playlist.add(AudioSource.uri(
        //       Uri.parse("asset:///audio/nature.mp3"),
        //       tag: AudioMetadata(
        //         album: "Public Domain",
        //         title: "Nature Sounds ${++_addedCount}",
        //         artwork:
        //         "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
        //       ),
        //     ));
        //   },
        // ),
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

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: const Icon(Icons.skip_previous),
            onPressed: player.hasPrevious ? player.seekToPrevious : null,
          ),
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero,
                    index: player.effectiveIndices!.first),
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: player.hasNext ? player.seekToNext : null,
          ),
        ),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }

}

class AudioMetadata {
  final String album;
  final String title;
  final String artwork;

  AudioMetadata({
    required this.album,
    required this.title,
    required this.artwork,
  });
}


// class playl{
//   List? playls;
//   playl(this.playls);
// }
