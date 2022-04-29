import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imed_app/components/rounded_button.dart';
import 'package:imed_app/constants.dart';
import 'package:imed_app/screens/forgotPass_screen.dart';
import 'package:imed_app/screens/userDetails_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image.asset('images/imed_logo.jpg'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey[800])),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.grey[800])),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Navigator.pushNamed(context, UserDetailsScreen.id);
                  //Navigator.pop(context);
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    final User? user1 = _auth.currentUser;
                    final userName = user1?.displayName;
                    if (user1?.emailVerified == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please verify your email'),
                        ),
                      );

                      // Navigator.pushNamed(context, HomeScreen.id);
                    } else if (user1?.emailVerified == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Welcome ' + userName!),
                        ),
                      );

                      Navigator.pushNamed(context, HomeScreen.id);
                    }
// And after creation of home screen

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(100, 45)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 10, 83, 143),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              // Navigator.pop(context);
              //             setState(() {
              //               //showSpinner = true;
              //             });
              //             //try {
              //               // final user = await _auth.signInWithEmailAndPassword(
              //               //     email: email, password: password);
              //               // final User user1 = _auth.currentUser;
              //               // final userName = user1.displayName;
              //               // if (user != null) {
              //               //   if (user1.emailVerified == false) {
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                     const SnackBar(
              //                       content: Text('Please verify your email'),
              //                     ),
              //                   );
              //               //     Navigator.pop(
              //               //         context); //input Navigator.pushNamed(context, HomeScreen.id); after testing
              //               //   } else if (user1.emailVerified == true) {
              //               //     ScaffoldMessenger.of(context).showSnackBar(
              //               //       SnackBar(
              //               //         content: Text('Welcome ' + userName),
              //               //       ),
              //               //     );
              //               //     Navigator.pushNamed(context, HomeScreen.id);
              //               //   }
              //              //  } // And after creation of home screen

              // // setState(() {
              // //                 showSpinner = false;
              // //               });
              // //             } catch (e) {
              // //               print(e);
              // //             }

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ForgotPassScreen.id);
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: Colors.red,
                      //fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
