import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/saveAndFetchSharedPrefs.dart';
import 'package:news_app/helper/widgetStyle.dart';
import 'package:news_app/models/ArticleModel.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/blog_tile.dart';

import 'category_view.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flutter"),
            Text("News", style: TextStyle(color: Colors.blue),)
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  child:DrawerButton(settingText: 'Notification', icon : Icons.notifications),
                ),
                Container(
                  child:DrawerButton(settingText: 'Dark Mode', icon: Icons.desktop_mac),
                ),
                Container(
                  child:DrawerButton(settingText: 'Bookmarks', icon: Icons.bookmark,),
                ),
                Container(
                  child:DrawerButton(settingText: 'Priority', icon : Icons.priority_high),
                ),
                Container(
                  child:DrawerButton(settingText: 'Calender', icon:Icons.calendar_today),
                ),
              ],
            )
          ],
        ),
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      )
          :SingleChildScrollView(
            child: Container(
            child: Column(
            children: <Widget>[
              /// Categories
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 80,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName:  categories[index].categoryName,
                    );
                  },
                ),
              ),
              /// Blogs
              Container(
                padding: EdgeInsets.only(top:16),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index){
                    return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url:articles[index].url,
                    );
                  },
                ),
              )
            ],
        ),
      ),
      ),
    );
  }
}

class DrawerButton extends StatefulWidget {
  final String settingText;
  final IconData icon;
  DrawerButton({@required this.settingText, @required this.icon});
  @override
  _DrawerButtonState createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  bool _lights = false;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title:  Text(widget.settingText),
      value: _lights,
      onChanged: (bool value) {
        setState(() {
          _lights = value;
        });
      },
      secondary: Icon(widget.icon),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>CategoryNews(
            category: categoryName.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 16,right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl, width: 120, height: 60, fit: BoxFit.cover,)
            ),
            Container(
              alignment: Alignment.center,
              width: 120, height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),

              child: Text(categoryName, style: TextStyle(
                  color: Colors.white,
                 fontSize: 14,
                fontWeight: FontWeight.w100,
              ),),
            )
          ],
        ),
      ),
    );
  }
}

