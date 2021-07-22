import 'package:aforo_app/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aforo_app/models/store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get Stores
  Stream<List<Store>> getStores(){
    return _db
        .collection('stores')
        .snapshots()
        .map((snapshot)=> snapshot.docs
        .map((doc)=> Store.fromJson(doc.data()))
        .toList());
  }



  //Upsert
Future<void> setStore(Store store){
    var options = SetOptions(merge: true);

    return _db
        .collection('stores')
        .doc(store.storeId)
        .set(store.toMap(),options);
}

  //Delete
  Future<void> removeStore(String storeId){
    return _db
        .collection('stores')
        .doc(storeId)
        .delete();
  }

  // Usuarios-----------------------------------------------------------

  Stream<List<Usuario>> getUsuarios(){
    return _db
        .collection('usuarios')
        .snapshots()
        .map((snapshot)=> snapshot.docs
        .map((doc)=> Usuario.fromJson(doc.data()))
        .toList());
  }


  getTienda (String email) async{
    var items = List<dynamic>();
    await _db
        .collection("usuarios")
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach(
        // add data to your list
            (f) => items.add(f['tienda']),
      );
    });
    return items;
  }
  getRol(email) async {
    var items = List<dynamic>();
    await _db
        .collection("usuarios")
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach(
        // add data to your list
            (f) => items.add(f['rol']),
      );
    });
    return items;
  }


  //Upsert
  Future<void> setUsuario(Usuario usuario){
    var options = SetOptions(merge: true);

    return _db
        .collection('usuarios')
        .doc(usuario.id)
        .set(usuario.toMap(),options);
  }

  Future<void> removeUsuario(String userId){
    return _db
        .collection('usuarios')
        .doc(userId)
        .delete();
  }



}




