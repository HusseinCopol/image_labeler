import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


import 'ImageObj.dart';
import 'ImageItem.dart';

List <ImageObj> _items=[];

class ImageMangerPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Manger',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: ImageMangerMain(title: 'Image Manger'),
    );
  }
}

class ImageMangerMain extends StatefulWidget {
  ImageMangerMain({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ImageMangerMainState createState() => _ImageMangerMainState();
}

class _ImageMangerMainState extends State<ImageMangerMain> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItems();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: ImageListUI())
          ],
        ),
      ),

    );
  }

  void fetchItems() async
  {
    //for the order list
    _items.clear();
    String url ="https://www.husseincopol.com/SmileSymbolAPI/ImageManger/SelectImages.php";
    Response response =await get(url);
    setState(() {
      var productJson=json.decode(utf8.decode(response.bodyBytes));

      for (var i in productJson)
      {
        var Item=ImageObj(i["id"],i["url"],i["label"]);
        _items.add(Item);
      }
    });


  }

}
Widget ImageListUI(){
  return ListView.builder(
    itemCount: _items.length ,
    itemBuilder: (context,position) {
      return GestureDetector(
        child: Padding(
          child: ImageItem(_items[position]),
          padding: EdgeInsets.only(left: 15,right: 15,top: 5),
        ),
      );
    },
  );}

