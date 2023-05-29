import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/error.dart';
import '../components/error_pop.dart';
import '../components/login_button.dart';
import '../components/password_feild.dart';
import '../components/sucess.dart';
import '../components/text_feild.dart';
import '../global/constants.dart';
import '../service/auth_service.dart';
import '../service/userService.dart';
import '../service/validate_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  _SignUpPageState() {
    selectedGame = gameList[0];
  }

  final _formKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;
  bool isLoading = false;
  String? errorMessage = "";
  final ValidateService _validateService = ValidateService();
  final UserService _userService = UserService();
  String? selectedGame = '';
  final gameList = [
    'Select',
    GameType.mw,
    GameType.blur,
    GameType.cb,
    GameType.bn,
    GameType.hc,
    GameType.cod,
    GameType.pubg,
    GameType.all,
    GameType.reg,
  ];

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  Future createUserWithEmailAndPasswordFirestore({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future createUserWithEmailAndPassword() async {
    final isValidForm = _formKey.currentState!.validate();
    if (selectedGame != 'Select') {
      if (isValidForm) {
        if (_controllerPassword.text.toString() ==
            _controllerConfirmPassword.text.toString()) {
          try {
            await createUserWithEmailAndPasswordFirestore(
                email: _controllerEmail.text,
                password: _controllerPassword.text);
            if (mounted) {
              showSuccessDialog(
                  context, 'Successfully registered', '/signin', 'Sign in');
            }
          } on FirebaseAuthException catch (e) {
            setState(() {
              isLoading = false;
              errorMessage = e.message;
            });
            showPopErrorDialog(context, errorMessage!);
          }

          ///add user details
          _userService.addUserDetails(
            _controllerName.text.trim(),
            _controllerEmail.text.trim(),
            selectedGame.toString(),
          );
        } else {
          showPopErrorDialog(context, 'Confirmed password is not matched');
        }
      } else {
        _controllerName.text.isEmpty ||
                _controllerEmail.text.isEmpty ||
                _controllerPassword.text.isEmpty ||
                _controllerConfirmPassword.text.isEmpty
            ? showPopErrorDialog(context, 'Please fill the field')
            : _validateService.validateEmail(_controllerEmail.text) != null
                ? showPopErrorDialog(context, 'Please enter valid email')
                : _validateService.validatePassword(_controllerPassword.text) !=
                        null
                    ? showPopErrorDialog(context, 'Please enter valid password')
                    : showPopErrorDialog(
                        context, 'Please enter valid confirm password');
      }
    } else {
      showPopErrorDialog(context, 'Please select the game.');
    }
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      isHiddenConfirmPassword = !isHiddenConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            backgroundColor: Colors.white,
            expandedHeight: relativeHeight * 110,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.black,
            ),
            title: Padding(
              padding: EdgeInsets.only(left: relativeWidth * 20),
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 24,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            // hasScrollBody: false,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: relativeHeight * 19.0,
                              left: relativeWidth * 29.0,
                              right: relativeWidth * 29.0,
                            ),
                            child: CustomTextField(
                              title: 'Full name',
                              controller: _controllerName,
                              hintText: 'Full name',
                              iconName: CupertinoIcons.person,
                              validate: (value) =>
                                  _validateService.isEmptyField(value!),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: relativeHeight * 19.0,
                              left: relativeWidth * 29.0,
                              right: relativeWidth * 29.0,
                            ),
                            child: CustomTextField(
                              title: 'Email',
                              controller: _controllerEmail,
                              hintText: 'abc@email.com',
                              iconName: CupertinoIcons.mail,
                              validate: (value) =>
                                  _validateService.validateEmail(value!),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: relativeHeight * 22.0,
                              left: relativeWidth * 29.0,
                              right: relativeWidth * 29.0,
                            ),
                            child: DropdownButtonFormField(
                              isDense: true,
                              isExpanded: true,
                              hint: const Text(
                                'Game Type',
                                style: TextStyle(
                                    color: Color.fromARGB(179, 43, 42, 42),
                                    fontSize: 16),
                              ),
                              value: selectedGame == 'Select'
                                  ? null
                                  : selectedGame,
                              items: gameList
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: e == 'Select'
                                                ? Colors.grey
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedGame = val as String;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Game type',
                                prefixIcon: const Icon(
                                  CupertinoIcons.building_2_fill,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: relativeHeight * 19.0,
                              left: relativeWidth * 29.0,
                              right: relativeWidth * 29.0,
                            ),
                            child: Container(
                              // height: relativeHeight * 56.0,
                              // width: relativeWidth * 317.0,
                              child: PasswordFeild(
                                relativeHeight: relativeHeight,
                                relativeWidth: relativeWidth,
                                title: 'Your password',
                                controller: _controllerPassword,
                                hintText: 'Your password',
                                iconName: CupertinoIcons.lock,
                                validate: (value) =>
                                    _validateService.validatePassword(value!),
                                togglePasswordView: _togglePasswordView,
                                isHidden: isHiddenPassword,
                              ),
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
                              title: 'Confirm password',
                              controller: _controllerConfirmPassword,
                              hintText: 'Confirm password',
                              iconName: CupertinoIcons.lock,
                              validate: (value) =>
                                  _validateService.validatePassword(value!),
                              togglePasswordView: _toggleConfirmPasswordView,
                              isHidden: isHiddenConfirmPassword,
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
                              onPressed: createUserWithEmailAndPassword,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
