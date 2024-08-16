import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourtyoneminutes/resuable_widgets/resuable_widget.dart';
import 'package:fourtyoneminutes/screens/home_screens.dart';
import 'package:fourtyoneminutes/screens/signup_screens.dart';
import 'package:fourtyoneminutes/utils/color_utils.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
             hexStringToColor("CB2B93"),
             hexStringToColor("9546C4"),
             hexStringToColor("5E61F4")
             ], begin: Alignment.topCenter, end: Alignment.bottomCenter )),
             child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Column(
                    children: <Widget>[
                      logoWidget("assets/images/logo1.png"),
                      SizedBox(
                        height: 30,
                      ),
                      reusableTextField("Enter UserName", Icons.person_outlined, false, 
                      _emailTextController),
                      SizedBox(
                        height: 30,
                      ),
                      reusableTextField(
                        "Enter password", Icons.lock_outline, true, 
                        _passwordTextController),
                        SizedBox(
                          height: 30,
                        ),
                        signInSignUpButton(context, true, () {
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailTextController.text,
                           password: _passwordTextController.text).then((value) {
                             Navigator.push(context,
                       MaterialPageRoute(builder: (context) => HomeScreen()));
                           }).onError((error, StackTrace) {
                            print("Error ${error.toString()}");
                           });
                        }),
                        signUpOption()
                    ],
                  ),
              ),
             ),
             ),
             );
  }
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}