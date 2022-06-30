import 'dart:io';

import 'package:amazon/Widgets/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'adminShiftOrders.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  bool get wantKeepAlive => true;
  File file;

  TextEditingController _descriptionTextEditingController = TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _shortTextEditingController = TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return file == null ? displayAdminHomeScreen() : displayAdminUploadFormScreen();

  }

  displayAdminHomeScreen()
  {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.pink, Colors.lightGreenAccent],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),

         leading: IconButton(icon: Icon(Icons.border_color, color: Colors.white, ), onPressed: (){
           Route route = MaterialPageRoute(builder: (c) => AdminShiftOrders());
           Navigator.pushReplacement(context, route);
         },
         ),


      ),

      body: getAdminHomeScreenBody()
    );
  }

  getAdminHomeScreenBody() {
   return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.pink, Colors.lightGreenAccent],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )
      ),
     child: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Icon(Icons.shop_two, color: Colors.white, size: 200.0,),
         Padding(
          padding: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
             child: Text("add new items", style: TextStyle(fontSize: 20.0, color: Colors.white),),
             color: Colors.green,
              onPressed: () => takeImage(context),
           ),
           ),
         ],
       ),
     )
    );
  }

  takeImage(mContext) {
    return showDialog(context: mContext,
    builder: (con)
    {
      return SimpleDialog(
        title: Text("item Image", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
        children: [
        SimpleDialogOption(
          child: Text("camera", style: TextStyle(color: Colors.green)  ),
          onPressed: capturePhotoWithCamera,
      ),

          SimpleDialogOption(
            child: Text("gallery", style: TextStyle(color: Colors.green)  ),
            onPressed: pickPhotoFromGallery,
          ),

          SimpleDialogOption(
            child: Text("Item Image", style: TextStyle(color: Colors.green)  ),
            onPressed:  ()
            {
              Navigator.pop(context);
            }
          ),
      ],
    );
  }
  );
}

capturePhotoWithCamera() async
{
  Navigator.pop(context);
  File imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);

  setState(() {
    file = imageFile ;
  });
}

pickPhotoFromGallery() async {
  Navigator.pop(context);
  File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,);

  setState(() {
    file = imageFile;
  });
  }

  displayAdminUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
       flexibleSpace: Container(
       decoration: new BoxDecoration(
       gradient: new LinearGradient(
       colors: [Colors.pink, Colors.lightGreenAccent],
       begin: const FractionalOffset(0.0, 0.0),
       end: const FractionalOffset(1.0, 0.0),
       stops: [0.0, 1.0],
       tileMode: TileMode.clamp,
            )
          ),
        ),
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: clearFormInfo),
          title: Text("New Product", style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold,)),
          actions: [
            FlatButton(
              onPressed: () => print("clicked"),
              child: Text("add", style: TextStyle(
                color: Colors.pink, fontSize: 16.0, fontWeight: FontWeight.bold,
              ),),
            ),
          ],

             ),
      body: ListView(
        children: [
          uploading ? linearProgress() : Text(""),
          Container(height:  230.0,
           width: MediaQuery.of(context).size.width * 0.8,
           child: Center(
            child: AspectRatio(aspectRatio: 16/9,
             child: Container(
             decoration: BoxDecoration(
             image: DecorationImage(image: FileImage(file), fit: BoxFit.cover)
                   ),
                 ),
               ),
             ),
           ),
          Padding(padding: EdgeInsets.only(top: 12.0)),

          ListTile(
            leading: Icon(Icons.book, color: Colors.pink),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepOrangeAccent),
                controller: _descriptionTextEditingController,
                decoration: InputDecoration(
                  hintText: "description",
                  hintStyle: TextStyle(color: Colors.deepOrangeAccent),
                    border: InputBorder.none
                )
              ),
            )
          ),
          Divider(
            color: Colors.pink,
          ),

          ListTile(
              leading: Icon(Icons.book, color: Colors.pink),
              title: Container(
                width: 250.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.deepOrangeAccent),
                    controller: _priceTextEditingController,
                    decoration: InputDecoration(
                        hintText: "price",
                        hintStyle: TextStyle(color: Colors.deepOrangeAccent),
                        border: InputBorder.none
                    )
                ),
              )
          ),

          Divider(
            color: Colors.pink,
          ),

          ListTile(
              leading: Icon(Icons.book, color: Colors.pink),
              title: Container(
                width: 250.0,
                child: TextField(
                    style: TextStyle(color: Colors.deepOrangeAccent),
                    controller: _titleTextEditingController,
                    decoration: InputDecoration(
                        hintText: "title",
                        hintStyle: TextStyle(color: Colors.deepOrangeAccent),
                        border: InputBorder.none
                    )
                ),
              )
          ),

          Divider(
            color: Colors.pink,
          ),

          ListTile(
              leading: Icon(Icons.book, color: Colors.pink),
              title: Container(
                width: 250.0,
                child: TextField(
                    style: TextStyle(color: Colors.deepOrangeAccent),
                    controller: _shortTextEditingController,
                    decoration: InputDecoration(
                        hintText: "short",
                        hintStyle: TextStyle(color: Colors.deepOrangeAccent),
                        border: InputBorder.none
                    )
                ),
              )
          ),
         ],
        ),
      );

  }


  clearFormInfo() {
    setState(() {
      file = null ;
      _descriptionTextEditingController.clear();
      _priceTextEditingController.clear();
      _shortTextEditingController.clear();
      _titleTextEditingController.clear();
    });
  }
}




