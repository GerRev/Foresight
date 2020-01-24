

// Entire client facing API for Firestore can be kept here

class Paths{
  static String team(String uid, String teamId)=> 'user/$uid/teams/$teamId/';
  static String teams(String uid)=> 'user/$uid/teams';
  static String users()=> 'user';




}