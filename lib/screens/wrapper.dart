import 'package:aforo_app/models/usuario.dart';
import 'package:aforo_app/screens/Authentication/authentication.dart';
import 'package:aforo_app/screens/homeScreens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatefulWidget {

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    //print(widget.user.email);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user != null){
      return HomeScreen();
    }else{
      return Authentication();
    }
  }
}
