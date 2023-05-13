import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vr_app_2022/components/bottom_navigation.dart';
import '../components/error.dart';
import '../components/error_pop.dart';
import '../components/login_button.dart';
import '../components/password_feild.dart';
import '../components/text_feild.dart';
import '../global/constants.dart';
import '../service/validate_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage = "";
  bool isHiddenPassword = true;
  bool isLoading = false;
  final ValidateService _validateService = ValidateService();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future signInWithEmailAndPasswordFirebase({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future signInWithEmailAndPassword() async {
    final isValidForm = _formKey.currentState!.validate();

    if (isValidForm) {
      try {
        setState(() {
          isLoading = true;
        });
        await signInWithEmailAndPasswordFirebase(
            email: _controllerEmail.text, password: _controllerPassword.text);
        setState(() {
          isLoading = false;
        });
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(
                indexPage: 0,
              ),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
          errorMessage = e.message;
        });
        showPopErrorDialog(context, errorMessage!);
      }
    } else {
      _controllerEmail.text.isEmpty || _controllerPassword.text.isEmpty
          ? showPopErrorDialog(context, 'Please fill the field')
          : _validateService.validateEmail(_controllerEmail.text) != null
              ? showPopErrorDialog(context, 'Please enter valid email')
              : _validateService.validatePassword(_controllerPassword.text) !=
                      null
                  ? showPopErrorDialog(context, 'Please enter valid password')
                  : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: relativeWidth * 100.0,
                  left: relativeWidth * 95.0,
                  right: relativeWidth * 95.0,
                ),
                child: Center(
                  child: Text(
                    'VR 23',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(55, 54, 74, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: relativeHeight * 41.0,
                  left: relativeWidth * 29.0,
                  right: relativeWidth * 275.0,
                ),
                child: Center(
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 24,
                      // fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(18, 13, 38, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: relativeHeight * 22.0,
                  left: relativeWidth * 29.0,
                  right: relativeWidth * 29.0,
                ),
                child: CustomTextField(
                  title: AutofillHints.email,
                  controller: _controllerEmail,
                  hintText: 'abc@email.com',
                  iconName: Icons.email,
                  validate: (value) => _validateService.validateEmail(value!),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: relativeHeight * 19.0,
                  left: relativeWidth * 29.0,
                  right: relativeWidth * 29.0,
                ),
                child: PasswordFeild(
                  relativeHeight: relativeHeight,
                  relativeWidth: relativeWidth,
                  title: AutofillHints.password,
                  controller: _controllerPassword,
                  hintText: 'Your password',
                  iconName: Icons.lock,
                  validate: (value) =>
                      _validateService.validatePassword(value!),
                  togglePasswordView: _togglePasswordView,
                  isHidden: isHiddenPassword,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: relativeHeight * 41.0,
                    left: relativeWidth * 52.0,
                    right: relativeWidth * 52.0),
                child: LoginButton(
                  title: 'SIGN IN',
                  relativeHeight: relativeHeight,
                  relativeWidth: relativeWidth,
                  onPressed: signInWithEmailAndPassword,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: relativeHeight * 41.0,
                    left: relativeWidth * 52.0,
                    right: relativeWidth * 52.0),
                child: LoginButton(
                  title: 'SIGN UP',
                  relativeHeight: relativeHeight,
                  relativeWidth: relativeWidth,
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
