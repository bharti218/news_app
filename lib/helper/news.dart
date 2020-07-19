import 'dart:convert';

import 'package:news_app/models/ArticleModel.dart';
import 'package:http/http.dart' as http;
class News{
  List<ArticleModel> news = [];
  Future<void> getNews() async{
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=0a6a5a7e6b8f418889a45ef90a4cd90f";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      print(jsonData["articles"].length);
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element["description"]!=null){
          ArticleModel articleModel = new ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
            content: element["content"],
          );
          news.add(articleModel);
        }

      });

    }
  }
}
class CategoryNewsClass{
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async{
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=0a6a5a7e6b8f418889a45ef90a4cd90f";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      print(jsonData["articles"].length);
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element["description"]!=null){
          ArticleModel articleModel = new ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
            content: element["content"],
          );
          news.add(articleModel);
        }

      });

    }
  }
}