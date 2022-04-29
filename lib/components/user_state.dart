import 'package:flutter/material.dart';
import 'package:imed_app/screens/welcome_screen.dart';
import 'package:imed_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);
  static const String id = "userDetails_screen";

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final User? user1 = _auth.currentUser;

    if (user1 != null) {
      return const HomeScreen();
    } else {
      return const WelcomeScreen();
    }
  }
}
