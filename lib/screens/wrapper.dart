import 'package:aforo_app/screens/Authentication/authentication.dart';
import 'package:aforo_app/screens/homeScreens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
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
