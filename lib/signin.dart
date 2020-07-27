import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/services/database.dart';
import 'package:flutter_chat_app/widgets/widget.dart';

import 'chatRoomsScreen.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  signIn () {
    if(formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        'email' : emailController.text.trim(),
      };

      setState(() {
        isLoading = true;
      });

      authMethods.signInWithEmailAndPassword(emailController.text.trim(), passwordController.text)
          .then((value) {
        databaseMethods.uploadUserInfo(userInfoMap);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator())
      ) : SingleChildScrollView(
        // 키보드 올라옴 방지
        child: Container(
          height: MediaQuery.of(context).size.height - 80,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    validator: (val) {
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                      null : "Enter correct email";
                    },
                    controller: emailController,
                    decoration: textFieldInputDecoration('email'),
                    style: simpleTextFieldStyle(),
                  ),
                  TextFormField(
                    validator: (val) {
                      return val.length < 6 ? "length must be more than 6" : null;
                    },
                    obscureText: true,
                    controller: passwordController,
                    decoration: textFieldInputDecoration('password'),
                    style: simpleTextFieldStyle(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forget Password?',
                        style: simpleTextFieldStyle(),
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      signIn();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Text(
                        'Sign In',
                        style: simpleTextFieldStyle(),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(colors: [
                            Colors.lightGreen,
                            Colors.green.withOpacity(0.9),
                          ])),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Text(
                      'Sign In with Google',
                      style: simpleTextFieldStyle(),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(colors: [
                          Colors.grey.withOpacity(0.2),
                          Colors.green.withOpacity(0.4),
                        ])),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Don't have account? ",
                          style: simpleTextFieldStyle()),
                      InkWell(
                        onTap: () {

                        },
                        child: Text(
                          'Register now',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 80),
                  ],
                ),
            ),
          )
        ),
      )
    );
  }
}
