import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imed_app/screens/ams_screen2.dart';
import 'package:imed_app/screens/home_screen.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance.currentUser!.uid;

class AmsScreen1 extends StatefulWidget {
  const AmsScreen1({Key? key}) : super(key: key);
  static const String id = 'ams1_screen';

  @override
  State<AmsScreen1> createState() => _AmsScreen1State();
}

class _AmsScreen1State extends State<AmsScreen1> {
  late String programm;
  late String semeste;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("AMS"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }
            for (var i = 0; i < snapshot.data!.size; i++) {
              final userdata = snapshot.data?.docs[i];

              // Future<DocumentSnapshot<Map<String, dynamic>>> userProgramme =
              //     _firestore.collection('users').doc(_auth).get();
//Map<String, dynamic> data = userProgramme.data();
//      var collection = FirebaseFirestore.instance.collection('users');
// var docSnapshot = collection.doc(_auth).get();
// if (docSnapshot.exists) {
//   Map<String, dynamic> data = docSnapshot.data()!;

//   // You can then retrieve the value from the Map like this:
//   var name = data['name'];
//}
//userProgramme.forEach('details',' programme');

              // for (var details in userdata!) {
              if (_auth == userdata!.id) {
                //String programm = details.get(['programme']);
                programm = userdata['programme'];
                print(programm);
                semeste = userdata['semester'];
                // {
                //   details.data(): ['semester']
                // };
                print(semeste);
                if (programm == 'MCA' && semeste == 'I') {
                  final User? user1 = FirebaseAuth.instance.currentUser;
                  CollectionReference ref = (FirebaseFirestore.instance
                      .collection("users")
                      .doc(user1!.uid)
                      .collection('OOSE')); //as CollectionReference<Object?>;
                  ref.doc('2'); //.add('2');
                }
              }
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AmsScreen2.id);
                    },
                    child: Text(
                      programm,
                      //'Subject 1',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    // ignore: prefer_const_constructors
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(350, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 181, 34),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AmsScreen2.id);
                    },
                    child: const Text(
                      'Subject 2',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    // ignore: prefer_const_constructors
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(350, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 181, 34),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AmsScreen2.id);
                    },
                    child: const Text(
                      'Subject 3',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    // ignore: prefer_const_constructors
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(350, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 181, 34),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AmsScreen2.id);
                    },
                    child: const Text(
                      'Subject 4',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    // ignore: prefer_const_constructors
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(350, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 181, 34),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AmsScreen2.id);
                    },
                    child: const Text(
                      'Subject 5',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    // ignore: prefer_const_constructors
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(350, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 181, 34),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AmsScreen2.id);
                    },
                    child: const Text(
                      'Subject 6',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    // ignore: prefer_const_constructors
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(350, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 181, 34),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AmsScreen2.id);
                    },
                    child: const Text(
                      'Subject 7',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    // ignore: prefer_const_constructors
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(350, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 181, 34),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AmsScreen2.id);
                    },
                    child: const Text(
                      'Subject 8',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    // ignore: prefer_const_constructors
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(350, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 181, 34),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
