import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.yellow,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset(
                        'images/imed_logo.jpg',
                        alignment: Alignment.center,
                      ),
                      height: 90.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 48.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
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

              // RoundedButton(
              //   title: 'Log In',
              //   colour: Colors.lightBlueAccent,
              //   onPressed: () {
              //     Navigator.pushNamed(context, LoginScreen.id);
              //
              //   },
              // ),
              // todo: uncomment it after registration screen is created.
              // RoundedButton(
              //   title: 'Register',
              //   colour: Colors.blueAccent,
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => RegistrationScreen(),
              //         ));
              //   },
              // ),

              const SizedBox(
                height: 10,
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                child: const Text(
                  'Register',
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
            ],
          ),
        ),
      ),
    );
  }
}
