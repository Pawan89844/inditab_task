import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_inditab/screens/auth/sign_in.dart';
import 'package:task_inditab/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart' as firebase;
import 'package:task_inditab/services/FirebaseService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase.Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(
    token: user?.uid,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: _validation(token),
    );
  }

  _validation(String? uid) {
    if (uid == null || uid.isEmpty) {
      return const SignIn();
    } else {
      return const Home();
    }
  }
}
