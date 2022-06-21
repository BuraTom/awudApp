class FetchedMusic{
  var title,artist_name,music_description,image,path,album,rate,id;

  FetchedMusic({required this.title,required this.artist_name,required this.music_description,required this.image,required this.path,required this.album,required this.rate,required this.id});

  factory FetchedMusic.fromJson(Map<String, dynamic> json) => FetchedMusic(
    id: json['_id'],
    title: json['title'],
    artist_name: json['artist_name'],
    music_description: json['music_description'],
    image: json['image'],
    path: json['path'],
    album: json['album'],
    rate: json['rate'],
  );
}