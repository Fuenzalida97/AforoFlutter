import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:aforo_app/models/store.dart';
import 'package:aforo_app/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class AuthServices with ChangeNotifier{
  bool _isLoading = false;
  String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String _selectedRole = 'Select a user role';
  String get selectedRole => _selectedRole;




  void setSelectedRole(String role){
    _selectedRole = role;
    notifyListeners();
  }


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









  final firestoreService = FirestoreService();
  String _storeId;
  String _nombre;
  int _actual;
  int _capacidad;
  String _horaInicio;
  String _horaCierre;
  String _direccion;

  var uuid = Uuid();

  //Getters
  String get nombre => _nombre;
  int get actual => _actual;
  int get capacidad => _capacidad;
  String get horaInicio => _horaInicio;
  String get horaCierre => _horaCierre;
  String get direccion => _direccion;

  Stream<List<Store>> get stores => firestoreService.getStores();

  //Setters
  set changeNombre(String nombre){
    _nombre = nombre;
    notifyListeners();
  }
  set changeActual(int actual){
    _actual = actual;
    notifyListeners();
  }
  set changeCapacidad(int capacidad){
    _capacidad = capacidad;
    notifyListeners();
  }
  set changeHoraInicio(String horaInicio){
    _horaInicio = horaInicio;
    notifyListeners();
  }
  set changeHoraCierre(String horaCierre){
    _horaCierre = horaCierre;
    notifyListeners();
  }
  set changeDireccion(String direccion){
    _direccion = direccion;
    notifyListeners();
  }

  //Functions
  loadAll(Store store){
    if(store != null){
      _storeId = store.storeId;
      _nombre = store.nombre;
      _actual = store.actual;
      _capacidad = store.capacidad;
      _horaInicio = store.horaInicio;
      _horaCierre = store.horaCierre;
      _direccion = store.direccion;
    }else{
      _storeId = null;
      _nombre = null;
      _actual = null;
      _capacidad = null;
      _horaInicio = null;
      _horaCierre = null;
      _direccion = null;
    }
  }

  saveStore(){
    if(_storeId == null){
      //Add
      var newStore = Store(storeId: uuid.v1(), nombre: _nombre, actual: _actual.hashCode, capacidad: _capacidad.hashCode, direccion: _direccion, horaInicio: _horaInicio, horaCierre: _horaCierre);
      firestoreService.setStore(newStore);
    }else{
      //Edit
      var updatedStore = Store (storeId: _storeId, nombre: _nombre, actual: _actual.hashCode, capacidad: _capacidad.hashCode, direccion: _direccion, horaInicio: _horaInicio, horaCierre: _horaCierre);
      firestoreService.setStore(updatedStore);
    }
  }

  removeStore(String storeId){
    firestoreService.removeStore(storeId);
  }
}