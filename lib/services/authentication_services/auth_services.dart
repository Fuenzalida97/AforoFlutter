import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthServices with ChangeNotifier{
  bool _isLoading = false;
  String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register(String email, String password) async{
    try {
      setLoading(true);
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException{
      setLoading(false);
      setMessage("Sin internet, por favor conéctese a internet.");
    } catch (e){
      String errorMessage;
      switch (e.code) {
        case "email-already-in-use":
          errorMessage = "La dirección de correo electrónico ya está registrada.";
          break;
        case "invalid-email":
          errorMessage = "El formato del correo electrónico es incorrecto.";
          break;
        default:
          errorMessage = "Se produjo un error indefinido.";
      }
      setLoading(false);
      print(e);
      setMessage(errorMessage);
      /*setLoading(false);
      print(e);
      setMessage(e.message);
      print(e.code);*/
    }
    notifyListeners();
  }

  Future login(String email, String password) async{
    try {
      setLoading(true);
      UserCredential authResult = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException{
      setLoading(false);
      setMessage("Sin internet, por favor conéctese a internet.");
    } catch (e){
      String errorMessage;
      switch (e.code) {
        case "wrong-password":
          errorMessage = "Contraseña incorrecta o usuario no registrado.";
          break;
        case "invalid-email":
          errorMessage = "El formato del correo electrónico es incorrecto.";
          break;
        case "user-not-found":
          errorMessage = "Contraseña incorrecta o usuario no registrado.";
          break;
        case "user-disabled":
          errorMessage = "La cuenta de usuario ha sido inhabilitada por un administrador.";
          break;
        default:
          errorMessage = "Se produjo un error indefinido.";
      }
      setLoading(false);
      print(e);
      setMessage(errorMessage);
    }
    notifyListeners();
  }

  Future logout() async{
    await firebaseAuth.signOut();
  }

  void setLoading(val){
    _isLoading = val;
    notifyListeners();
  }
  void setMessage(message){
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User> get user => firebaseAuth.authStateChanges();
}