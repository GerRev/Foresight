
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseService{

  //Singleton
  FirebaseService._();
  static final instance= FirebaseService._();


  //Generic methods
  Future<void> write({@required String path, Map<String, dynamic> data}) async {
  final reference = Firestore.instance.document(path);
  await reference.setData(data);
  print('$path  $data');
  }


  // Stream when Id is needed:

  Stream<List<T>> readStreamWithId<T>(
      {@required String path, @required T builder(Map<String, dynamic> data, String documentId)}) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => builder(snapshot.data,snapshot.documentID),
    )
        .toList());
  }



  Stream<List<T>> readStream<T>(
      {@required String path, @required T builder(Map<String, dynamic> data)}) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => builder(snapshot.data),
    )
        .toList());
  }



  Future<void> delete({@required String path}) async {
    final reference= Firestore.instance.document(path);
    print('deleted $path');
    await reference.delete();

  }



}