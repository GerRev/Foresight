import 'package:flutter/material.dart';
import 'package:foresight_mobile/app/home/models/user.dart';
import 'package:foresight_mobile/app/home/users/user_list_tile.dart';
import 'package:foresight_mobile/services/database.dart';
import 'package:provider/provider.dart';
import '../../../widgets/list_builder.dart';

class Fixtures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    print('@@@@@@@@@@');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Users'),
      ),
      body: StreamBuilder<List<User>>(
          stream: database.usersStream(),
          builder: (context, snapshot) {
            return ListsBuilder(
              snapshot: snapshot,
              itemBuilder: (context, user) => UserListTile(user: user),
            );
          }),
    );
  }
}
