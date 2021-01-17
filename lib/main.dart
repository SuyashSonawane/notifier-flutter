import 'package:Notifier_7/provider/subscription.dart';
import 'package:Notifier_7/screens/detail-notice.dart';
import 'package:Notifier_7/screens/home.dart';
import 'package:Notifier_7/screens/login.dart';
import 'package:Notifier_7/screens/user-profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  await Firebase.initializeApp().then((value) {
    runApp(ChangeNotifierProvider(
      create: (_) => Subscriptions(),
      child: MaterialApp(
        home: MyApp(),
        debugShowCheckedModeBanner: false,
        routes: {
          DetailNotice.routeName: (_) => DetailNotice(),
          UserProfile.routeName: (_) => UserProfile(),
        },
      ),
    ));
  });
}

class MyApp extends StatelessWidget {
  var snapshot;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.hasData) {
          snapshot = userSnapshot.data.phoneNumber;
          return Home();
        } else
          return LoginScreen();
      },
    );
  }
}
