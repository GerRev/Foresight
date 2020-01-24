import 'package:flutter/material.dart';
import 'package:foresight_mobile/app/sign_in/sign_in_manager.dart';
import 'package:provider/provider.dart';
import 'package:foresight_mobile/app/sign_in/social_sign_in_button.dart';
import 'package:foresight_mobile/widgets/platform_exception_alert_dialog.dart';
import 'package:foresight_mobile/services/auth.dart';
import 'package:flutter/services.dart';

// Stateless widget
class SignInPage extends StatelessWidget {
  SignInPage({Key key, @required this.manager, @required this.isLoading}) : super(key: key);

  final SignInManager manager;
  final bool isLoading;

  // Create static method so no need to wrap this widget with Provider in Landing Page
  // Use ChangeNotifierProvider with ValueNotifier(ValueNotifier: holds a value (isLoading) and notifies listeners when value changes);
  // Use Consumer to Register for updates. When isLoading.value changes the builder is called. And build descendants if value changes
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
              builder: (context, manager, _) => SignInPage(
                    manager: manager,isLoading: isLoading.value,
                  )),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Mobile Foresight'),
        elevation: 0,
      ),
      //Wrap body with StreamBuilder, not the scaffold(appbar doesn't change)
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
          ),
          SizedBox(height: 48.0),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
