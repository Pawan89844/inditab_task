// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_inditab/screens/auth/sign_up.dart';
import 'package:task_inditab/screens/home/home.dart';
import 'package:task_inditab/services/FirebaseService.dart';
import 'package:task_inditab/utils/AppText.dart';
import '../../components/AppButton.dart';
import '../../components/AppInputField.dart';
import '../../components/ImageButton.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _keyboardVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var size = MediaQuery.of(context);
    _keyboardVisible = size.viewInsets.bottom != 0;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      bottomNavigationBar: Row(
        children: [
          ImageButton(
              onTap: () => FirebaseService.signInWithGoogle()
                  .then((value) => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const Home(),
                      ))),
              imagePath: 'assets/google_icon.png',
              buttonName: 'Google'),
          ImageButton(
              onTap: () => FirebaseService.signInWithFacebook().then(
                    (value) => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const Home(),
                      ),
                    ),
                  ),
              imagePath: 'assets/facebook_icon.png',
              buttonName: 'Facebook'),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  AnimatedContainer(
                    // curve: Curves.decelerate,
                    duration: const Duration(seconds: 1),
                    height: _keyboardVisible
                        ? size.size.height * .2
                        : size.size.height * .3,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: SvgPicture.asset('assets/login.svg',
                        fit: BoxFit.fitHeight),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Utils.appText('Welcome to IndiTab',
                            fontSize: 25.0, fontWeight: FontWeight.w600),
                        Utils.appText('Login with simple steps'),
                        Visibility(
                            visible: _keyboardVisible,
                            child: const SizedBox(height: 10.0)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.size.height * .1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    AppInputField(
                        labelText: 'Email', controller: _emailController),
                    const SizedBox(height: 10.0),
                    AppInputField(
                        obscureText: true,
                        labelText: 'Password',
                        controller: _passwordController),
                    const SizedBox(height: 10.0),
                    AppButton(
                      isLoading: isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          await FirebaseService.login(_emailController.text,
                                  _passwordController.text)
                              .then((value) => print(value.user?.displayName))
                              .onError(
                            (error, stackTrace) {
                              hasError = true;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error.toString())));
                            },
                          ).whenComplete(() {
                            isLoading = false;
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
                      },
                      name: 'Submit',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Utils.appText('Don\'t have an account?'),
                        TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const SignUp(),
                                )),
                            child: const Text('Register now'))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30.0)
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
