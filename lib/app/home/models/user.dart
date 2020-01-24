import 'package:flutter/material.dart';

class User{

  User({@required this.photoUrl, @required this.name});

  final String photoUrl;
  final String name;


  /*factory User.fromFire(Map<String, dynamic> data){
    if(data ==null){
      return null;
    }
    final String name= data['name'];
    final String photoUrl= data['photoURL'];
    return
      User(
        name: name,
        photoUrl: photoUrl,

      );
  }
*/




  factory User.fromFire(Map<String, dynamic> data){
    if(data ==null){
      return null;
    }
    final String name= data['name'];
    final String photoUrl= data['photoURL'];
    return
      User(
        photoUrl: photoUrl,
        name: name,
      );
  }


}




