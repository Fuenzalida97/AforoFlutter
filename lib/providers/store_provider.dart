import 'package:aforo_app/models/store.dart';
import 'package:aforo_app/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

/*
class StoreProvider with ChangeNotifier{
  final firestoreService = FirestoreService();
  String _storeId;
  String _nombre;
  int _actual;
  int _capacidad;
  String _direccion;
  String _horaInicio;
  String _horaCierre;

  var uuid = Uuid();

  //Getters
  String get nombre => _nombre;
  int get actual => _actual;
  int get capacidad => _capacidad;
  String get direccion => _direccion;
  String get horaInicio => _horaInicio;
  String get horaCierre => _horaCierre;

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
  set changeDireccion(String direccion){
    _direccion = direccion;
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

  //Functions
  loadAll(Store store){
    if(store != null){
      _storeId = store.storeId;
      _nombre = store.nombre;
      _actual = store.actual;
      _capacidad = store.capacidad;
      _direccion = store.direccion;
      _horaInicio = store.horaInicio;
      _horaCierre = store.horaCierre;
    }else{
      _storeId = null;
      _nombre = null;
      _actual = null;
      _capacidad = null;
      _direccion = null;
      _horaInicio = null;
      _horaCierre = null;
    }
  }

  saveEntry(){
    if(_storeId == null){
      //Add
      var newStore = Store(storeId: uuid.v1(), nombre: _nombre, actual: _actual, capacidad: _capacidad, direccion: _direccion, horaInicio: _horaInicio, horaCierre: _horaCierre);
      firestoreService.setStore(newStore);
    }else{
      //Edit
      var updatedStore = Store (storeId: _storeId, nombre: _nombre, actual: _actual, capacidad: _capacidad, direccion: _direccion, horaInicio: _horaInicio, horaCierre: _horaCierre);
      firestoreService.setStore(updatedStore);
    }
  }

  removeStore(String storeId){
    firestoreService.removeStore(storeId);
  }
}
*/