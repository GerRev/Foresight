import 'package:foresight_mobile/app/home/models/team.dart';
import 'package:foresight_mobile/app/home/models/user.dart';
import 'package:foresight_mobile/app/home/models/support_teams.dart';
import 'package:foresight_mobile/services/database.dart';
import 'package:rxdart/rxdart.dart';

class CombineStreams {
  final Database database;

  CombineStreams({this.database});

  Stream<List<SupportTeams>> joinedStreams (Database database){
    return

      Rx.combineLatest2(
      database.usersStream(), database.teamsStream(),combiner);

  }

  List<SupportTeams> combiner(List<User> users, List<Team> teams) =>
      users.map((user) =>
          teams.map((team) =>
              SupportTeams(user,team))).expand((i) => i).toList();
}
