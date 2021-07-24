import 'dart:async';
import 'dart:io';

import 'package:aforo_app/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:aforo_app/models/store.dart';
import 'package:aforo_app/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;

  final firestoreService = FirestoreService();


  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  Future register(String email, String password) async {
    try {
      setLoading(true);
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = authResult.user;
      saveUsuario(email);
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage("Sin internet, por favor conéctese a internet.");
    } catch (e) {
      String errorMessage;
      switch (e.code) {
        case "email-already-in-use":
          errorMessage =
              "La dirección de correo electrónico ya está registrada.";
          break;
        case "invalid-email":
          errorMessage = "El formato del correo electrónico es incorrecto.";
          break;
        default:
          errorMessage = "Se produjo un error indefinido.";
      }
      setLoading(false);
      setMessage(errorMessage);
    }
    notifyListeners();
  }


  Future login(String email, String password) async {
    try {
      setLoading(true);
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage("Sin internet, por favor conéctese a internet.");
    } catch (e) {
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
          errorMessage =
              "La cuenta de usuario ha sido inhabilitada por un administrador.";
          break;
        default:
          errorMessage = "Se produjo un error indefinido.";
      }
      setLoading(false);
      setMessage(errorMessage);
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User> get user => firebaseAuth.authStateChanges();

// Providers Stores (Tiendas) ----------------------------------------------------



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

  final StreamController<Store> _storeController = StreamController<Store>();

  Stream<List<Store>> get stores => firestoreService.getStores();

  Stream<Store> get appStore => _storeController.stream;

  //Setters
  set changeNombre(String nombre) {
    _nombre = nombre;
    notifyListeners();
  }

  set changeActual(int actual) {
    _actual = actual;
    notifyListeners();
  }

  set changeCapacidad(int capacidad) {
    _capacidad = capacidad;
    notifyListeners();
  }

  set changeHoraInicio(String horaInicio) {
    _horaInicio = horaInicio;
    notifyListeners();
  }

  set changeHoraCierre(String horaCierre) {
    _horaCierre = horaCierre;
    notifyListeners();
  }

  set changeDireccion(String direccion) {
    _direccion = direccion;
    notifyListeners();
  }

  //Functions
  loadAll(Store store) {
    if (store != null) {
      _storeId = store.storeId;
      _nombre = store.nombre;
      _actual = store.actual;
      _capacidad = store.capacidad;
      _horaInicio = store.horaInicio;
      _horaCierre = store.horaCierre;
      _direccion = store.direccion;
    } else {
      _storeId = null;
      _nombre = null;
      _actual = null;
      _capacidad = null;
      _horaInicio = null;
      _horaCierre = null;
      _direccion = null;
    }
  }

  saveStore() {
    if (_storeId == null) {
      //Add
      var newStore = Store(
          storeId: uuid.v1(),
          nombre: _nombre,
          actual: _actual.hashCode,
          capacidad: _capacidad.hashCode,
          direccion: _direccion,
          horaInicio: _horaInicio,
          horaCierre: _horaCierre);
      firestoreService.setStore(newStore);
    } else {
      //Edit
      var updatedStore = Store(
          storeId: _storeId,
          nombre: _nombre,
          actual: _actual.hashCode,
          capacidad: _capacidad.hashCode,
          direccion: _direccion,
          horaInicio: _horaInicio,
          horaCierre: _horaCierre);
      firestoreService.setStore(updatedStore);
    }
  }

  updateStore2(int cant) {
    var updateStore = Store(
        storeId: _storeId,
        nombre: _nombre,
        actual: cant,
        capacidad: _capacidad.hashCode,
        direccion: _direccion,
        horaInicio: _horaInicio,
        horaCierre: _horaCierre);
    firestoreService.setStore(updateStore);
  }

  removeStore(String storeId) {
    firestoreService.removeStore(storeId);
  }

// Providers Users (Usuarios con rol) ----------------------------------------------------

  String _id;
  String _email;
  String _rol;
  String _tienda;

//Getters
  String get id => id;
  String get email => _email;
  String get rol => _rol;
  String get tienda => _tienda;

  //final StreamController<Usuario> _usuarioController = StreamController<Usuario>();

  //Stream<List<Usuario>> get usuarios => firestoreService.getUsuarios();

  //Stream<Usuario> get appUsuario => _usuarioController.stream;



//Setters
  set changeEmail(String email) {
    _email = email;
    notifyListeners();
  }

  set changeRol(String rol) {
    _rol = rol;
    notifyListeners();
  }

  set changeTienda(String tienda) {
    _tienda = tienda;
    notifyListeners();
  }

//Functions
  loadAllUsuario(Usuario usuario) {
    if (usuario != null) {
      _id = usuario.id;
      _email = usuario.email;
      _rol = usuario.rol;
      _tienda = usuario.tienda;
    } else {
      _id = null;
      _email = null;
      _rol = null;
      _tienda = null;
    }
  }

  saveUsuario(String email) async{
    //if (id == null) {
      //Add
      var newUsuario = await Usuario(
          id: uuid.v1(), email: email, rol: 'normal', tienda: 'ninguna');
      firestoreService.setUsuario(newUsuario);
    /*} else {
      //Edit
      var updateUsuario =
          Usuario(id: _id, email: _email, rol: _rol, tienda: _tienda);
      firestoreService.setUsuario(updateUsuario);
    }*/
  }

  removeUsurio(String id) {
    firestoreService.removeUsuario(id);
  }


  getRol() async{
    String email = await FirebaseAuth.instance.currentUser.email;
    var rol = await firestoreService.getRol(email);
    return rol.toString();
  }



  getTienda()async{
    String email = await FirebaseAuth.instance.currentUser.email;
    var tienda = List<dynamic>();
    tienda = await firestoreService.getTienda(email);
    return tienda.toString();
  }



}
