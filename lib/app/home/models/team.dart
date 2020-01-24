import 'package:flutter/cupertino.dart';

class Team {
  final String name;
  final int division;
  final String id;

  Team({@required this.name, @required this.division, @required this.id});

  Map<String, dynamic> toFire() {
    return {
      'name': name,
      'division': division,
    };
  }

  factory Team.fromFire(Map<String, dynamic> data, String documentId){
    if(data ==null){
      return null;
    }
    final String name= data['name'];
    final int division= data['division'];
    return
        Team(
          id: documentId,
          name: name,
          division: division,
        );
  }
}
