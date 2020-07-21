class ArticleModel{
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  String publishedAt;
  bool isRead;

  ArticleModel({this.title, this.author, this.description,this.url,this.urlToImage,this.content, this.publishedAt, this.isRead});

}