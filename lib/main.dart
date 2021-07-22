import 'package:aforo_app/screens/wrapper.dart';
import 'package:aforo_app/services/authentication_services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return MaterialApp(
        home: FutureBuilder(
            future: _init,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ErrorWidget();
              } else if (snapshot.hasData) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider<AuthServices>.value(
                        value: AuthServices()),
                    StreamProvider<User>.value(
                      value: AuthServices().user,
                      initialData: null,
                    )
                  ],
                  child: MaterialApp(
                    theme: ThemeData(
                      primarySwatch: Colors.red,
                    ),
                    debugShowCheckedModeBanner: false,
                    home: Wrapper(),
                  ),
                );
              } else {
                return Loading();
              }
            }));
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
              Column(children: [Icon(Icons.error), Text("Algo salió mal !")])),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

