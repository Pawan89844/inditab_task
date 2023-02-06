import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_inditab/components/AppButton.dart';
import 'package:task_inditab/components/AppInputField.dart';
import 'package:task_inditab/screens/home/home.dart';
import 'package:task_inditab/services/FirebaseService.dart';

import '../../utils/AppText.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSignedUp = false;
  bool _keyboardVisible = false;
  bool hasError = false;
  final List<Text> _title = [
    Utils.appText('Create your Account',
        fontSize: 25.0, fontWeight: FontWeight.w600),
    Utils.appText('by following simple steps!')
  ];

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context);
    _keyboardVisible = size.viewInsets.bottom != 0;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: AppButton(
            isLoading: isSignedUp,
            name: 'Sign Up',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                isSignedUp = true;
                setState(() {});
                await FirebaseService.registerUser(
                        _emailController.text, _passwordController.text)
                    .then((value) {})
                    .onError((error, stackTrace) {
                  hasError = true;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                }).whenComplete(() {
                  isSignedUp = false;
                  setState(() {});
                  if (!hasError) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const Home(),
                        ));
                  }
                });
              }
            }),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  AnimatedContainer(
                    // curve: Curves.decelerate,
                    duration: const Duration(seconds: 1),
                    height: _keyboardVisible
                        ? size.size.height * .3
                        : size.size.height * .35,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: SvgPicture.asset('assets/signup.svg',
                        fit: BoxFit.fitHeight),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: _title,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    AppInputField(
                        labelText: 'Email', controller: _emailController),
                    const SizedBox(height: 10.0),
                    AppInputField(
                        labelText: 'Password',
                        controller: _passwordController,
                        obscureText: true),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
