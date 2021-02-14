import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'ImageObj.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:http/http.dart';
import 'dart:convert';


AutoCompleteTextField searchTextFieldLabel;

GlobalKey<AutoCompleteTextFieldState<String>> keyProduct = new GlobalKey();
List <String> _labelList=[];


class ImageItem extends StatefulWidget {
  //Product _product;
  ImageObj _image;

  ImageItem(this._image);

  @override
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {

  CreatAlertDialog(BuildContext context)
  {
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        backgroundColor: Colors.grey[900],
        shape:new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.orange[400], width: 1.0),
            borderRadius: BorderRadius.circular(15.0)) ,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Text(

              "Select a Label",
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: "Vazir",color: Colors.white70),
            ),


          ],
        ),

        actions: <Widget>[



          SizedBox(
            width:100 ,
            child: Column(
              children: [
                searchTextFieldLabel=  AutoCompleteTextField<String> (

                  key: keyProduct,
                  clearOnSubmit: false,
                  suggestions: _labelList,

                  style: TextStyle(color: Colors.white,fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                    hintText: "Label",
                    hintStyle: TextStyle(color: Colors.white30),

                  ),
                  itemFilter: (item,query){
                    return item.startsWith((query));

                  },
                  itemSorter: (a,b){
                    return a.compareTo(b);
                  },
                  itemSubmitted: (item){
                    setState(() {
                      searchTextFieldLabel.textField.controller.text= item;
                    });
                  },
                  itemBuilder: (context,item){
                    //ui for autocomplete

                    return rowLabel(item);
                  },
                ),
               MaterialButton(

                color: Colors.orange,
                elevation: 5.0,
                child: Text("Set"
                  ,style: TextStyle(color: Colors.white70),),
                onPressed: (){
                  Navigator.of(context).pop();
                  print("//////////////////");
                  String label=searchTextFieldLabel.textField.controller.text.toString();

                  post(widget._image.id,label);



                },
              ),
              ],
            ),
          )
        ],
      );
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    //print("1234");
    super.initState();
    fetchItems();
    //  fetchItems();
  }

  Widget rowLabel(String Label)
  {
    return Container(
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,

        children: <Widget>[

          Text(Label,
            style: TextStyle(color: Colors.white,fontSize: 16),),
          SizedBox(width: 30,
            height: 10,),
        ],

      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        CreatAlertDialog(context);
      },
      child: Card(

        color: Colors.black54,
        elevation: 3,
        child: Container(
          height: 350,
          width: 320,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                 Image.network(
                      widget._image.url,
                      width: 350.0,
                      height: 280.0,
                    ),
                  Text(widget._image.label
                  ,style: TextStyle(fontSize: 30),),
                  SizedBox(
                    height: 10,
                  )



                ],
              ),

            ],
          ),
        ),
      ),
    );
  }


  void post(String imageId,String label) async {

    print("test");
    print(imageId + "  "+ label);
    var result = await http.post(
        "https://www.husseincopol.com/SmileSymbolAPI/ImageManger/UpdateLabel.php",
        body: {
          "imageId": imageId,
          "label": label,


        }
    );

  }


  void fetchItems() async
  {

    _labelList.clear();
    //for the order list

    //for the total order
    String url2 ="https://www.husseincopol.com/SmileSymbolAPI/ImageManger/SelectLabels.php";
    http.Response response2 =await http.get(url2);
    setState(() {
      var orderTotalJson=json.decode(utf8.decode(response2.bodyBytes));

      for (var i in orderTotalJson)
      {
        var label=i["name"];
        // print(customer.customerId + "  " + customer.customerName);
        _labelList.add(label);


      }
      print(_labelList);
    });
    //print(_customerList);
  }



}
