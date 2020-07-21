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
      body: _loading? Center(
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
                height: 70,
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
                    return  BlogTile(
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
        margin: EdgeInsets.only(right: 16),
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



class BlogTile extends StatefulWidget {

  String imageUrl, title, desc, url;
  BlogTile({@required this.imageUrl, @required this.title, @required this.desc, @required this.url});

  @override
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){

       // SharedPrefs.saveIsReadInSharedPrefs( );
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>ArticleView(
          blogUrl: widget.url,
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom:16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.network(widget.imageUrl)),
            Text(widget.title, style:getTextStyle()),
            SizedBox(height: 8,),
            Text(widget.desc, style: TextStyle(
              color: Colors.grey
            ),)
          ],
        ),
      ),
    );
  }

  getLoggedInState() async {
    await SharedPrefs.getIsReadSharedPrefs().then((value) {
      setState(() {
        //widget._getIsRead = value;
      });
    });
  }

  TextStyle getTextStyle()
  {
    getLoggedInState();
    if(true){
      return TextStyle(
        fontSize: 17,
        color: Colors.black87,
        fontWeight: FontWeight.w100,
      );
    }
    else{
      return TextStyle(
        fontSize: 17,
        color: Colors.black87,
        fontWeight: FontWeight.w700,
      );
    }
  }
}
