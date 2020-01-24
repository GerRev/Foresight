import 'package:flutter/material.dart';
import 'package:foresight_mobile/app/home/models/user.dart';

class UserListTile extends StatelessWidget {
  UserListTile({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 100,
      ),
      ListTile(
        title: Text(user.name),
        trailing: new Container(
          width: 50.0,
          height: 50.0,
          decoration: new BoxDecoration(
            color: const Color(0xff7c94b6),
            image: new DecorationImage(
              image: new NetworkImage(user.photoUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
            border: new Border.all(
              color: Colors.red,
              width: 2.0,
            ),
          ),
        ),
      ),
    ]);
  }
}
