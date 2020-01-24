import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:foresight_mobile/app/home/models/user.dart';
import 'package:meta/meta.dart';
import 'package:foresight_mobile/app/home/models/team.dart';
import 'package:foresight_mobile/services/api_path.dart';
import 'package:foresight_mobile/services/firebase_servcie.dart';

abstract class Database {
  Future<void> setTeam(Team team);
  Stream<List<Team>> teamsStream();
  Future<void> deleteTeam(Team team);
  Stream<List<User>> usersStream();

}

String docIdFromCurrentTime() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirebaseService.instance;

  Future<void> setTeam(Team team) async => await _service.write(
    path: Paths.team(uid, team.id),
    data: team.toFire(),
  );



  Stream<List<Team>> teamsStream() => _service.readStreamWithId(
    path: Paths.teams(uid),
    builder: (data, documentId) => Team.fromFire(data, documentId),
  );

  Stream<List<User>> usersStream() => _service.readStream(
    path: Paths.users(),
    builder: (data) => User.fromFire(data),
  );



  
  Future<void> deleteTeam(Team team) async => await _service.delete(
      path: Paths.team(uid,team.id),
  );
}
