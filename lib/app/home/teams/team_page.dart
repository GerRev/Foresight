import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foresight_mobile/app/home/models/team.dart';
import 'package:foresight_mobile/app/home/teams/add_team_page.dart';
import 'package:foresight_mobile/widgets/list_builder.dart';
import 'package:foresight_mobile/app/home/teams/team_list_tile.dart';
import 'package:foresight_mobile/services/database.dart';
import 'package:foresight_mobile/widgets/platform_exception_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:foresight_mobile/widgets/platform_alert_dialog.dart';
import 'package:foresight_mobile/services/auth.dart';

class TeamPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Teams'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add,color: Colors.black54,),
            onPressed: () => EditTeamPage.show(context),
          ),
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),

        ],
      ),
      body: _contents(context),
    );
  }


  Widget _contents(BuildContext context) {
    final database = Provider.of<Database>(context,listen: false);
    return StreamBuilder<List<Team>>(
        stream: database.teamsStream(),
        builder: (context, snapshot) {
          return ListsBuilder(
            content: "Add a team",
            snapshot: snapshot,
            itemBuilder: (context, team) => Dismissible(
              direction: DismissDirection.endToStart,
              background: Container(color: Colors.red,),
              key: Key('team-${team.id}'),
              onDismissed: (direction)=> _delete(context,team),
              child: TeamListTile(
                team: team,
                onTap: () => EditTeamPage.show(context, team: team),
              ),
            ),
          );
        });
  }







 Future<void> _delete(BuildContext context, Team team) async{try {
      final database = Provider.of<Database>(context,listen: false);
      await database.deleteTeam(team);
    } on PlatformException catch (e){
      PlatformExceptionAlertDialog(
        title: '',
        exception: e,
      ).show(context);
    }
  }
}
