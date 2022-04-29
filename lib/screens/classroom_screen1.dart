import 'package:flutter/material.dart';

import 'classroom_screen2.dart';

class ClassroomScreen1 extends StatefulWidget {
  const ClassroomScreen1({Key? key}) : super(key: key);
  static const String id = 'classroom_screen1';

  @override
  State<ClassroomScreen1> createState() => _ClassroomScreen1State();
}

class _ClassroomScreen1State extends State<ClassroomScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Classroom"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ClassroomScreen2.id);
              },
              child: const Text(
                'Subject 1',
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
                Navigator.pushNamed(context, ClassroomScreen2.id);
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
                Navigator.pushNamed(context, ClassroomScreen2.id);
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
                Navigator.pushNamed(context, ClassroomScreen2.id);
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
                Navigator.pushNamed(context, ClassroomScreen2.id);
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
                Navigator.pushNamed(context, ClassroomScreen2.id);
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
                Navigator.pushNamed(context, ClassroomScreen2.id);
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
                Navigator.pushNamed(context, ClassroomScreen2.id);
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
      ),
    );
  }
}
