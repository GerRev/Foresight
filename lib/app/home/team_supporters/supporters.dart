import 'package:flutter/material.dart';
import 'package:foresight_mobile/app/home/team_supporters/combine_streams.dart';
import 'package:foresight_mobile/app/home/models/support_teams.dart';
import 'package:foresight_mobile/app/home/team_supporters/supporter_tile.dart';
import 'package:foresight_mobile/services/database.dart';
import 'package:provider/provider.dart';

import '../../../widgets/list_builder.dart';

class Supporters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    print('@@@@@@@@@@');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Combined'),
      ),
      backgroundColor: Colors.grey[200],
      body: StreamBuilder<List<SupportTeams>>(
          stream: CombineStreams(database: database).joinedStreams(database),
          builder: (context, snapshot) {
            return ListsBuilder(
              content: "No Subscriptions",
              snapshot: snapshot,
              itemBuilder: (context, supportTeams) =>
                  SupporterListTile(supportTeams: supportTeams),
            );
          }),
    );
  }
}
