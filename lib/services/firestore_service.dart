import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aforo_app/models/store.dart';

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
}