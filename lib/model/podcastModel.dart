class FetchedPodcast{
  var artist_name,podcast_title,podcast_description,image,category,rate,id;

  FetchedPodcast({required this.artist_name,required this.podcast_title,required this.podcast_description,required this.image,required this.category,required this.rate,required this.id});

  factory FetchedPodcast.fromJson(Map<String, dynamic> json) => FetchedPodcast(
    id: json['_id'],
    artist_name: json['artist_name'],
    podcast_title: json['podcast_title'],
    podcast_description: json['podcast_description'],
    image: json['image'],
    category: json['category'],
    rate: json['rate'],
  );
}