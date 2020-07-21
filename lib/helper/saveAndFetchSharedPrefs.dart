import 'package:news_app/models/ArticleModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefs{
  static String isTapOnNewsTile = "isTap";
  /// saving data in shared prefs.
  static Future<bool> saveIsReadInSharedPrefs(ArticleModel model) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.setBool(isTapOnNewsTile, true);
  }
  /// Getting data from shared prefs.
  static Future<bool> getIsReadSharedPrefs() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.getBool(isTapOnNewsTile);
  }

}
