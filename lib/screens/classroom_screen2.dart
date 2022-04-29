import 'package:flutter/material.dart';

class ClassroomScreen2 extends StatefulWidget {
  const ClassroomScreen2({Key? key}) : super(key: key);
  static const String id = 'classroom_screen2';

  @override
  State<ClassroomScreen2> createState() => _ClassroomScreen2State();
}

class _ClassroomScreen2State extends State<ClassroomScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Subject Name"),
          centerTitle: true,
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ClassroomScreen2.id);
            },
            child: const Text(
              'Study Material',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            // ignore: prefer_const_constructors
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
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
              Navigator.pushNamed(context, ClassroomScreen2.id);
            },
            child: const Text(
              'Assignments',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            // ignore: prefer_const_constructors
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
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
        ])));
  }
}
