import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
// Creating String Var to Hold sent Email.
  final String email;

// Receiving Email using Constructor.
  HomePage({Key key, @required this.email}) : super(key: key);

// User Logout Function.
  logout(BuildContext context){

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Profile Screen'),
                automaticallyImplyLeading: false),
            body: Center(
                child: Column(children: <Widget>[

                  Container(
                      width: 280,
                      alignment: AlignmentDirectional(0.0, 0.0),
                      padding: EdgeInsets.only(top: 150.0),
                      child: Text('Email = ' + email,
                          style: TextStyle(fontSize: 20,))
                  ),


                  RaisedButton(
                    onPressed: () {
                      logout(context);
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Click Here To Logout'),
                  ),

                ],)
            )
        )
    );
  }
}