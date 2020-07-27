import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/signin.dart';
import 'package:flutter_chat_app/widgets/widget.dart';

import 'chatRoomsScreen.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signMeUp () {
    if(formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      authMethods.signUpWithEmailAndPassword(emailController.text, passwordController.text)
          .then((value) {
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
          child: Center(child: CircularProgressIndicator()
        )) : SingleChildScrollView(
          // 키보드 올라옴 방지
          child: Container(
              height: MediaQuery.of(context).size.height - 80,
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              return val.isEmpty || val.length < 4 ? "Please Provide UserName" : null;
                            },
                            controller: userNameController,
                            decoration: textFieldInputDecoration('username'),
                            style: simpleTextFieldStyle(),
                          ),
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
                            obscureText: true,
                            validator: (val) {
                              return val.length < 6 ? "length must be more than 6" : null;
                            },
                            controller: passwordController,
                            decoration: textFieldInputDecoration('password'),
                            style: simpleTextFieldStyle(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        signMeUp();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Text(
                          'Sign Up',
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
                        'Sign Up with Google',
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
                        Text("Already have account? ",
                            style: simpleTextFieldStyle()),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => SignIn()
                            ));
                          },
                          child: Text(
                            'Sign In now',
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
              )
          ),
        )
    );
  }
}
