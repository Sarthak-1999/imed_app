import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imed_app/constants.dart';
import 'package:imed_app/screens/home_screen.dart';
import 'package:imed_app/screens/welcome_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/UserProfileImageFirebaseApi.dart';

class UserDetailsScreen extends StatefulWidget {
  static const String id = "userDetails_screen";
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  bool showSpinner = false;
  var isDateSelected;
  String? name;
  String? phoneNo;
  String? aadharNo;
  String? birthDateInString;
  DateTime? birthDate;
  final _firestore = FirebaseFirestore.instance;
  String? userDisplayImage;
  String? dropdownValuePro;
  String? dropdownValueSem;
  File? _image;
  final picker = ImagePicker();
  final _auth = FirebaseAuth.instance;
  TextEditingController textEditingController = TextEditingController();
  late UploadTask task;
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: const Color(0xffFDCF09),
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              _image!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100)),
                            width: 150,
                            height: 150,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: textEditingController,
                keyboardType: TextInputType.name,
                //textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: Colors.grey[800])),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text(
                      'Programme',
                      //textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                    focusColor: Colors.blueAccent,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    value: dropdownValuePro,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValuePro = newValue!;
                      });
                    },
                    items: <String>['BBA', 'BCA', 'MBA', 'MCA']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          // textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(
                height: 8.0,
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text(
                      'Semester',
                      //textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                    focusColor: Colors.blueAccent,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    value: dropdownValueSem,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueSem = newValue!;
                      });
                    },
                    items: <String>['I', 'II', 'III', 'IV', 'V', 'VI']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          // textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.phone,

                // textAlign: TextAlign.center,
                onChanged: (value) {
                  phoneNo = value;
                },
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Phone No.',
                    hintStyle: TextStyle(color: Colors.grey[800])),
              ),
              const SizedBox(
                height: 8.0,
              ),

              TextField(
                keyboardType: TextInputType.number,

                obscureText: true,
                //textAlign: TextAlign.center,
                onChanged: (value) {
                  aadharNo = value;
                },
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Aadhar No.',
                    hintStyle: TextStyle(color: Colors.grey[800])),
              ),
              const SizedBox(
                height: 8.0,
              ),

              Container(
                //Todo: fix date not displaying after selection
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'D.O.B',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    // const SizedBox(
                    //   width: 80,
                    // ),
                    GestureDetector(
                        child: const Icon(Icons.calendar_today),
                        onTap: () async {
                          final datePick = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          if (datePick != null && datePick != birthDate) {
                            setState(
                              () {
                                birthDate = datePick;
                                isDateSelected = true;

                                // put it here
                                birthDateInString =
                                    "${birthDate?.month}/${birthDate?.day}/${birthDate?.year}"; // 08/14/2019
                              },
                            );
                          }
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              ElevatedButton(
                onPressed: () async {
                  final User? user1 = _auth.currentUser;
                  user1?.updateDisplayName(name);
                  final fileName = _image;
                  final destination = 'userdisplayimage/$fileName';
                  setState(() {
                    showSpinner = true;
                  });
                  task = UserProfileImageFirebaseApi.uploadFile(
                      destination, _image!)!;
                  setState(() {});

                  if (task == null) return null;

                  final snapshot = await task.whenComplete(() {});
                  final urlDownload = await snapshot.ref.getDownloadURL();
                  userDisplayImage = urlDownload;
                  await _firestore.collection('userdata').add({
                    'userDisplayImageUrl': userDisplayImage,
                    //'created': FieldValue.serverTimestamp(),
                  });

                  FirebaseAuth.instance.currentUser
                      ?.updatePhotoURL(userDisplayImage);
                  DocumentReference ref = FirebaseFirestore.instance
                      .collection("users")
                      .doc(user1!.uid);
                  await ref.set({
                    'idUser': ref.id,
                    'name': name,
                    'programme': dropdownValuePro,
                    'semester': dropdownValueSem,
                    'phone number': phoneNo,
                    'aadhar number': aadharNo,
                    'dob': birthDate,
                    'urlAvatar': _auth.currentUser?.photoURL,
                    'lastMessageTime': FieldValue.serverTimestamp(),
                  });
                  Navigator.pushNamed(context, WelcomeScreen.id);
                  user1.sendEmailVerification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Verification email send, please check your email'),
                    ),
                  );
                },
                child: const Text(
                  'Done',
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

              // TextField(
              //   //keyboardType: TextInputType.datetime,
              //   //textAlign: TextAlign.center,
              //   onChanged: (value) {
              //     dob = value;
              //
              //   },
              //   style: const TextStyle(
              //     color: Colors.black,
              //   ),
              //   decoration: kTextFieldDecoration.copyWith(
              //       hintText: 'D.O.B',
              //       hintStyle: TextStyle(color: Colors.grey[800])),
              // ),
              // RoundedButton(
              //   title: 'Register',
              //   colour: Colors.blueAccent,
              //   onPressed: () async {
              //     final fileName = _image;
              //     final destination = 'userdisplayimage/$fileName';
              //     setState(() {
              //       showSpinner = true;
              //     });
              //     task = UserProfileImageFirebaseApi.uploadFile(
              //         destination, _image);
              //     setState(() {});

              //     if (task == null) return null;

              //     final snapshot = await task.whenComplete(() {});
              //     final urlDownload = await snapshot.ref.getDownloadURL();
              //     userDisplayImage = urlDownload;
              //     // await _firestore.collection('userdata').add({
              //     //   'userDisplayImageUrl': userDisplayImage,
              //     //   //'created': FieldValue.serverTimestamp(),
              //     // });

              //     try {
              //       final newUser = await _auth.createUserWithEmailAndPassword(
              //           email: email, password: password);
              //       final User user1 = _auth.currentUser;
              //       await FirebaseAuth.instance.currentUser.updateProfile(
              //           displayName: name, photoURL: userDisplayImage);
              //       if (newUser != null) {
              //         user1.sendEmailVerification();
              //         DocumentReference ref =
              //             FirebaseFirestore.instance.collection("users").doc();
              //         await ref.set({
              //           'idUser': ref.id,
              //           'name': _auth.currentUser.displayName,
              //           'urlAvatar': _auth.currentUser.photoURL,
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
    );
  }

  _imgFromCamera() async {
    final image = await picker.getImage(source: ImageSource.camera);
    setState(() async {
      _image = image as File;

      final fileName = _image;
      final destination = 'userdisplayimage/$fileName';
      //
      //   task = UserProfileImageFirebaseApi.uploadFile(destination, _image);
      setState(() {});
      //
      // if (task == null) return null;
      //
      //   final snapshot = await task.whenComplete(() {});
      //   final urlDownload = await snapshot.ref.getDownloadURL();
      //   userDisplayImage = urlDownload;
      //   await _firestore.collection('userdata').add({
      //     'userDisplayImageUrl': userDisplayImage,
      //     //'created': FieldValue.serverTimestamp(),
      //   });
    });
  }

//Future
  _imgFromGallery() async {
    final image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  // Text('Choose From',
                  //   style: TextStyle(
                  //   fontSize: 20.0,
                  //     fontWeight: FontWeight.bold,
                  // ),
                  // ),
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: const Text('Image gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
