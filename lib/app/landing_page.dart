import 'package:flutter/material.dart';
import 'package:foresight_mobile/services/database.dart';
import 'package:provider/provider.dart';
import 'package:foresight_mobile/app/home/teams/team_page.dart';
import 'package:foresight_mobile/app/sign_in/sign_in_page.dart';
import 'package:foresight_mobile/services/auth.dart';

import 'home/home_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context,listen: false);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SignInPage.create(context);
            }
            return Provider<Database>(
                create:(_)=> FirestoreDatabase(uid:user.uid),
                child: HomePage());
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
