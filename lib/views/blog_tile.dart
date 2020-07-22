import 'package:flutter/material.dart';
import 'package:news_app/helper/saveAndFetchSharedPrefs.dart';
import 'package:news_app/helper/widgetStyle.dart';

import 'article_view.dart';

class BlogTile extends StatefulWidget {

  final String imageUrl, title, desc, url;

  BlogTile({@required this.imageUrl, @required this.title, @required this.desc, @required this.url});

  @override
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  bool isRead = false;

  @override
  void initState() {
    getReadStatus(widget.url);
    super.initState();
  }

  saveReadStatus(String url){
    SharedPrefs.saveIsReadInSharedPrefs(widget.url, true);
  }

  getReadStatus(String url) async {
    await SharedPrefs.getIsReadSharedPrefs(widget.url).then((val) {
      setState(() {
        isRead = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        saveReadStatus(widget.url);
        getReadStatus(widget.url);
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
            Text(
                widget.title,
                style: readNewsStyle(isRead)
            ),
            SizedBox(height: 8,),
            Text(widget.desc, style: TextStyle(
                color: Colors.grey
            ),)
          ],
        ),
      ),
    );
  }

  TextStyle readNewsStyle(bool readStatus) {
    if(readStatus == true){
      return DarkMode.darkModeHeadlineTextStyle(Colors.blue);
    }
    else{
      return DarkMode.darkModeHeadlineTextStyle(Colors.white);
    }
  }
}