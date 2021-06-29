import 'dart:convert';

import 'package:Armas/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Armas/screen/film.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  ProgressDialog pr;

  bool _isLoggedIn = false;


  // For CircularProgressIndicator.
  bool visible = false ;
  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  getCredential() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("UserId") != null) {
        _isLoggedIn = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => new NewsListPage('Layar.site','XX')),
        );
      } else {
        _isLoggedIn = false;
      }
    });
  }

    Future userLogin() async{

    pr.show();
    // Showing CircularProgressIndicator.
    setState(() {
      visible = false ;
    });

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;

    // SERVER LOGIN API URL
    var url = 'http://206.189.148.197/login-hp.php';

    // Store all data with Param Name.
    var data = {'email': email, 'password' : password};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    if(message == 'Login Matched')
    {
      //emailController.clear();
      //passwordController.clear();

      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      pr.hide();

      // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsListPage('Layar.site','XX'))
        //MaterialPageRoute(builder: (context) => NewsListPage()),
    );
    }else{
      pr.hide();
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );}

  }




  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Waiting...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );


    final logo = Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final loginid = TextFormField(
      autofocus: false,
      obscureText: false,
      controller: emailController,
      style: TextStyle(fontSize: 18.0, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: 'Nomor Pegawai',
        contentPadding:
        const EdgeInsets.only(left: 14.0, bottom: 20.0, top: 20.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      style: TextStyle(fontSize: 18.0, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: 'Password',
        contentPadding:
        const EdgeInsets.only(left: 14.0, bottom: 20.0, top: 20.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: FlatButton(
        shape: StadiumBorder(),
        color: Colors.red,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(13.0),
        splashColor: Colors.redAccent,
        onPressed: () {
          userLogin();
        },
        child: Text(
          "Login",
          style: TextStyle(fontSize: 20.0),
        ),
      )
    );



    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            loginid,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 15.0),
            loginButton,
          ],
        ),
      ),
    );
  }
}