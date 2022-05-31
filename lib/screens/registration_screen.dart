import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imed_app/components/rounded_button.dart';
import 'package:imed_app/constants.dart';

import 'package:imed_app/components/UserProfileImageFirebaseApi.dart';
//import 'package:assignment_talks/components/firebase_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:imed_app/screens/userDetails_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final _firestore = FirebaseFirestore.instance;

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController textEditingController = TextEditingController();
  bool showSpinner = false;
  late String name;
  late String email;
  late String password;
  //late String userDisplayImage;
  //late File _image;
  // final picker = ImagePicker();
  // late UploadTask task;

  //late File file;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    //final fileName = file.path;
    'No File Selected';
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.yellow,
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
                // TextField(
                //   keyboardType: TextInputType.name,
                //   textAlign: TextAlign.center,
                //   onChanged: (value) {
                //     name = value;
                //     print(name);
                //   },
                //   style: const TextStyle(
                //     color: Colors.black,
                //   ),
                //   decoration: kTextFieldDecoration.copyWith(
                //       hintText: 'Enter your name',
                //       hintStyle: TextStyle(color: Colors.grey[800])),
                // ),
                // const SizedBox(
                //   height: 8.0,
                // ),
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
                    await _firestore.collection('userdata').add({
                      //'userDisplayImageUrl': userDisplayImage,
                      //'c': FieldValue.serverTimestamp(),
                      'created': FieldValue.serverTimestamp(),
                    });
                    try {
                      // final newUser =
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      //final User? user1 = _auth.currentUser;
                      //await FirebaseAuth.instance.currentUser?.displayName=name; // (
                      // displayName: name); // photoURL: userDisplayImage);
                      // user1?.updateDisplayName(name);

                      // DocumentReference ref =
                      //     FirebaseFirestore.instance.collection("users").doc();
                      // await ref.set({
                      //   'userId': ref.id,
                      //   'name': name,

                      //   //'urlAvatar': _auth.currentUser?.photoURL,
                      //   //'lastMessageTime': FieldValue.serverTimestamp(),
                      // });

                      Navigator.pushNamed(context, UserDetailsScreen.id);

                      // if (FirebaseAuth.instance.currentUser!.emailVerified) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('User already registered'),
                      //     ),
                      //   );
                      // }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (signUpError) {
                      if (signUpError is PlatformException) {
                        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                          /// `foo@bar.com` has alread been registered.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('User already registered'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text(
                    'Next',
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
//TODO: Check how to upload to send email and password to firebase.

                // RoundedButton(
                //   title: 'Register',
                //   colour: Colors.blueAccent,
                //   onPressed: () // async
                //       async {
                //     final fileName = _image;
                //     final destination = 'userdisplayimage/$fileName';
                //     setState(() {
                //       showSpinner = true;
                //     });
                //     task = UserProfileImageFirebaseApi.uploadFile(
                //         destination, _image)!;
                //     setState(() {});

                //     if (task == null) return null;

                //     final snapshot = await task.whenComplete(() {});
                //     final urlDownload = await snapshot.ref.getDownloadURL();
                //     userDisplayImage = urlDownload;
                //     await _firestore.collection('userdata').add({
                //       'userDisplayImageUrl': userDisplayImage,
                //       //'created': FieldValue.serverTimestamp(),
                //     });

                //     try {
                //       final newUser =
                //           await _auth.createUserWithEmailAndPassword(
                //               email: email, password: password);
                //       final User? user1 = _auth.currentUser;
                //       await FirebaseAuth.instance.currentUser?.updateProfile(
                //           displayName: name, photoURL: userDisplayImage);
                //       if (newUser != null) {
                //         user1?.sendEmailVerification();
                //         DocumentReference ref = FirebaseFirestore.instance
                //             .collection("users")
                //             .doc();
                //         await ref.set({
                //           'idUser': ref.id,
                //           'name': _auth.currentUser?.displayName,
                //           'urlAvatar': _auth.currentUser?.photoURL,
                //           'lastMessageTime': FieldValue.serverTimestamp(),
                //         });
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           const SnackBar(
                //             content: Text(
                //                 'Verification email send, please check your email'),
                //           ),
                //         );
                //         Navigator.pop(context);
                //       }

                //       setState(() {
                //         showSpinner = false;
                //       });
                //     } catch (e) {
                //       print(e);
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
