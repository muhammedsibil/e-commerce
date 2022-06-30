import 'package:amazon/Authentication/authentication.dart';
import 'package:amazon/DialogBox/errorDialog.dart';
import 'package:amazon/Widgets/customTextField.dart';
import 'package:amazon/admin/uploadItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        title: Text("e-shope", style: TextStyle(fontSize: 35.0, color: Colors.white, fontFamily:"Signatra"),),
        centerTitle: true,
      ),

      body: AdminSignInScreen()
    );
  }
}

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

final TextEditingController _adminIDTextEditingController = TextEditingController();
final TextEditingController _passwordTextEditingController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height;


    return SingleChildScrollView(
        child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset("images/login.png",height: 240.0,
                    width: 240.0,
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0),

                  child: Text("Login to your account",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _adminIDTextEditingController,
                        data: Icons.person,
                        hintText:"Id",
                        isObsecure: false,
                      ),
                      CustomTextField(
                        controller: _passwordTextEditingController,
                        data: Icons.person,
                        hintText:"Password",
                        isObsecure: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                RaisedButton(onPressed:()
                {
                  _adminIDTextEditingController.text.isNotEmpty &&
                      _passwordTextEditingController.text.isNotEmpty
                      ? loginAdmin() : showDialog(context: context,
                      builder: (c){
                        return ErrorAlertDialog(message: "please write email and password",);});
                },
                  color: Colors.pink,
                  child: Text("Login", style: TextStyle(color: Colors.white),),),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 4.0,
                  width: _screenWidth * 0.8,
                  color: Colors.pink,
                ),
                SizedBox(
                  height: 4.0,
                ),
                FlatButton.icon(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthenticScreen())),
                  icon: (Icon(Icons.nature_people, color: Colors.pink,)),
                  label: Text("i'm admin", style: TextStyle(color:Colors.pink, fontWeight: FontWeight.bold),),),

                SizedBox(
                  height: 4.0,
                ),
              ],
            )

        )
    );
  }


  loginAdmin() {

    FirebaseFirestore.instance.collection("admins").get().then((snapshot){
      snapshot.docs.forEach((result){
        if (result.data()["id"] != _adminIDTextEditingController.text.trim())
          {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("your id is not correct"),));
          }
        else if(result.data()["password"] != _passwordTextEditingController.text.trim())
        {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("your password is not correct"),));
        }
        else
        {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("your password is not correct"),));

          setState(() {
            _adminIDTextEditingController.text = "";
            _passwordTextEditingController.text = "";
          });
          Route route = MaterialPageRoute(builder: (c) => UploadPage());
          Navigator.pushReplacement(context, route);
        }
    });
    });
  }
}



