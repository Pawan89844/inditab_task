import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_inditab/components/AppButton.dart';
import 'package:task_inditab/screens/auth/sign_in.dart';
import 'package:task_inditab/services/FirebaseService.dart';
import 'package:task_inditab/utils/AppText.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Utils.appText('Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Utils.appText('Account details',
                      fontSize: 25.0, fontWeight: FontWeight.w600),
                  Utils.appText('Protected')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 80.0,
                width: double.infinity,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: ListTile(
                      title: Utils.appText(
                          'Name: ${_firebaseAuth.currentUser?.displayName ?? ''}'),
                      subtitle: Utils.appText(
                          'Email: ${_firebaseAuth.currentUser?.email ?? ''}'),
                    )),
              ),
            ),
            const SizedBox(height: 10.0),
            AppButton(
                isLoading: isLoading,
                name: 'Logout',
                onPressed: () async {
                  isLoading = true;
                  setState(() {});
                  await FirebaseService.logout().onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Utils.appText(error.toString())));
                  }).whenComplete(() {
                    isLoading = false;
                    setState(() {});
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SignIn()));
                  });
                })
          ],
        ),
      ),
    );
  }
}
