import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_flutter/models/base_model.dart';

class BaseProvider<T extends BaseModel>{

  BaseProvider({
    required this.getCollectionReference,
    required this.constructor
  });
  T Function(dynamic id, Map<String, dynamic>) constructor;
  CollectionReference Function(FirebaseFirestore) getCollectionReference;

  Future<bool> addData(T object) async {
    try{
      await getCollectionReference(FirebaseFirestore.instance).add(object.toMap());
      return true;
    } catch(e){
      print(e);
      return false;
    }
  }

  Future<T?> getData(String id) async {
    try{
      final result = await getCollectionReference(FirebaseFirestore.instance).doc(id).get();
      return constructor(result.id, result.data() as Map<String,dynamic>);
    } catch(e){
      print(e);
      return null;
    }
  }

  Stream get collectionStream => getCollectionReference(FirebaseFirestore.instance).snapshots();

  Future<bool> updateData(T object) async {
    try{
      await getCollectionReference(FirebaseFirestore.instance).doc(object.databaseId).update(
        object.toMap(),
      );
      return true;
    } catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> removeData(T object) async {
    try{
      await getCollectionReference(FirebaseFirestore.instance).doc(object.databaseId).delete();
      return true;
    } catch(e){
      print(e);
      return false;
    }
  }
}