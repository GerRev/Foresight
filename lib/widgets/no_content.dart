import 'package:flutter/material.dart';

class NoContent extends StatelessWidget {
  NoContent({
    Key key,
    this.title = 'Nothing here',
    this.message = 'Add a Team',
  }) : super(key: key);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text(title,style: TextStyle(fontSize: 32,color: Colors.black54),),
          Text(message,style: TextStyle(fontSize: 16,color: Colors.black54),),
        ],
      ),
    );
  }
}
