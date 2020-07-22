import 'package:news_app/models/ArticleModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{

  static Future<bool> saveIsReadInSharedPrefs(String url, bool status) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.setBool(url, status);
  }

  static Future<bool> getIsReadSharedPrefs(String url) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.getBool(url);
  }

}
