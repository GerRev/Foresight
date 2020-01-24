import 'package:flutter/material.dart';
import 'package:foresight_mobile/app/home/models/support_teams.dart';

class SupporterListTile extends StatelessWidget {
  SupporterListTile({Key key, @required this.supportTeams}) : super(key: key);

  final SupportTeams supportTeams;

  @override
  Widget build(BuildContext context) {
   return Container(
     padding: EdgeInsets.all(8),
     height: 100,
     child: Card(
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children:[
           Text(supportTeams.user.name),//title: Text(widget.team == null ? 'New Team' : 'Edit Team'),
           Text('subscribes to'),
           Text(supportTeams.team.name),
         ],
       ),
     ),
   );

  }
}
