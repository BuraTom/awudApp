class FetchedAudiobook{
  var author_name,audiobook_title,audiobook_description,image,category,rate,Chapters,id;

  FetchedAudiobook({this.author_name, this.audiobook_title, this.audiobook_description, this.image, this.category, this.rate, this.Chapters, this.id});

  factory FetchedAudiobook.fromJson(Map<String, dynamic> json) => FetchedAudiobook(
    id: json['_id'],
    author_name: json['author_name'],
    audiobook_title: json['title'],
    audiobook_description: json['audiobook_description'],
    image: json['image'],
    category: json['category'],
    rate: json['rate'],
    Chapters: json['Chapters'],
  );
}