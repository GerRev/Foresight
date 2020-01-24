import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:foresight_mobile/services/auth.dart';

// Loading state (UI) and Authentication logic (Service)

class SignInManager   {
  SignInManager({@required this.auth, @required this.isLoading});

  final AuthBase auth;
  final ValueNotifier<bool> isLoading ;


  //pass funtion as an input argument (less code when implementing different sign in methods)
  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
     isLoading.value= true;
      return await signInMethod();
    } catch (e) {
      isLoading.value= false;
      rethrow;
    }
  }

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
}
