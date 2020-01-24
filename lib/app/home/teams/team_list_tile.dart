import 'package:flutter/material.dart';
import 'package:foresight_mobile/app/home/models/team.dart';

class TeamListTile extends StatelessWidget {

  TeamListTile({Key key,@required this.team,  this.onTap}): super(key:key);

  final VoidCallback onTap;
  final Team team;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(8),
      height: 100,
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(team.name),//title: Text(widget.team == null ? 'New Team' : 'Edit Team'),

                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


/*
ListTile(
title: Text(team.name),
trailing: Icon(Icons.chevron_right),
onTap: onTap,
);*/
