//import 'package:imed_app/space_screen.dart';
//import 'package:imed_app/studyWithMe_screen.dart';
//import 'package:assignment_talks/screens/programming_screen.dart';
//import 'package:assignment_talks/screens/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:imed_app/screens/programming_screen.dart';
import 'package:imed_app/screens/studyWithMe_screen.dart';

class ExploreScreen extends StatefulWidget {
  //const ExploreScreen({Key key}) : super(key: key);
  static const String id = 'explore_screen';
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final controller = ScrollController();

  late String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Explore'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.deepOrangeAccent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minWidth: 200.0,
                  height: 48.0,
                  child: Text('Programming'),
                  onPressed: () {
                    Navigator.pushNamed(context, YoutubeLinksPlayer.id);
                  },
                ),
                MaterialButton(
                  color: Colors.deepOrangeAccent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minWidth: 200.0,
                  height: 48.0,
                  child: Text('Study With Me'),
                  onPressed: () {
                    Navigator.pushNamed(context, StudyWithMe.id);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.deepOrangeAccent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minWidth: 200.0,
                  height: 48.0,
                  child: Text('Workout'),
                  onPressed: () {
                    // Navigator.pushNamed(context, WorkoutScreen.id);
                  },
                ),
                MaterialButton(
                  color: Colors.deepOrangeAccent,
                  minWidth: 200.0,
                  height: 48.0,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text('Space'),
                  onPressed: () {
                    // Navigator.pushNamed(context, SpaceScreen.id);
                  },
                ),
              ],
            ),
            // ListView.builder(
            //     itemBuilder: itemBuilder
            // )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     showModalBottomSheet(
      //         context: context,
      //         builder: (context) => AddLink(),
      //         isScrollControlled: true,
      //         //backgroundColor: Colors.transparent,
      //         //enableDrag: true,
      //         // elevation: 1,
      //         shape: RoundedRectangleBorder(
      //             side: BorderSide.none,
      //             borderRadius:
      //                 BorderRadius.vertical(top: Radius.elliptical(20, 20))));
      //   },
      // DocumentReference ref =
      //     FirebaseFirestore.instance.collection('youtubeLinks').doc();
      // // DocumentReference ref1 = FirebaseFirestore.instance
      // //     .collection('youtubeLinks')
      // //     .doc(_auth.currentUser.uid);
      //
      // await ref.collection('Programming').doc().set({
      //   'postId': ref.id,
      //   'postTitle': postTitle,
      //   'sender': loggedInUser.displayName,
      //   'senderProfileImageUrl': senderProfileImageUrl,
      //   'senderId': loggedInUser.uid,
      //   'postType': postTypeText,
      //   'postImageUrl': postImageUrl,
      //   'created': FieldValue.serverTimestamp(),
      // });
    );
  }

  // bool selectedTag1 = false;
  // bool selectedTag2 = false;
  // Widget addLink() => Column(
  //       children: [
  //         Text('Select category of link:'),
  //         SizedBox(),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             MaterialButton(
  //               height: 48.0,
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20.0)),
  //               elevation: 5.0,
  //               color: selectedTag1 ? Colors.pinkAccent : Colors.grey[50],
  //               onPressed: () {
  //                 category = 'Question';
  //                 setState(() {
  //                   selectedTag1 = !selectedTag1;
  //                   selectedTag2 = false;
  //                 });
  //               },
  //               child: Text(
  //                 '# Question',
  //                 style: TextStyle(
  //                   color: selectedTag1 ? Colors.white : Colors.black,
  //                   fontSize: 15.0,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               width: 20.0,
  //             ),
  //             MaterialButton(
  //               height: 48.0,
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20.0)),
  //               elevation: 5.0,
  //               color: selectedTag2 ? Colors.pinkAccent : Colors.grey[50],
  //               onPressed: () {
  //                 category = 'Feed';
  //                 setState(() {
  //                   selectedTag2 = !selectedTag2;
  //                   selectedTag1 = false;
  //                 });
  //               },
  //               child: Text(
  //                 '# Feed',
  //                 style: TextStyle(
  //                   color: selectedTag2 ? Colors.white : Colors.black,
  //                   fontSize: 15.0,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     );
}

// class AddLink extends StatefulWidget {
//   //const AddLink({Key key}) : super(key: key);
//
//   @override
//   _AddLinkState createState() => _AddLinkState();
// }
//
// class _AddLinkState extends State<AddLink> {
//   DocumentReference linkRef;
//   bool selectedTag1 = false;
//   bool selectedTag2 = false;
//   bool selectedTag3 = false;
//   bool selectedTag4 = false;
//   final textController = TextEditingController();
//   String link;
//   String category;
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         SizedBox(
//           height: 25,
//         ),
//         Center(
//           child: Text(
//             'Add a Youtube Link',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Divider(
//           thickness: 2,
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Center(
//           child: Text(
//             'Select category of link:',
//             style: TextStyle(
//               //fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 25,
//         ),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               MaterialButton(
//                 height: 30.0,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0)),
//                 elevation: 5.0,
//                 color: selectedTag1 ? Colors.pinkAccent : Colors.grey[50],
//                 onPressed: () {
//                   category = 'Programming';
//                   setState(() {
//                     selectedTag1 = !selectedTag1;
//                     //selectedTag2 = false;
//                   });
//                 },
//                 child: Text(
//                   'Programming',
//                   style: TextStyle(
//                     color: selectedTag1 ? Colors.white : Colors.black,
//                     fontSize: 15.0,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 20.0,
//               ),
//               MaterialButton(
//                 height: 30.0,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0)),
//                 elevation: 5.0,
//                 color: selectedTag2 ? Colors.pinkAccent : Colors.grey[50],
//                 onPressed: () {
//                   category = 'Study With Me';
//                   setState(() {
//                     selectedTag2 = !selectedTag2;
//                     //selectedTag1 = false;
//                   });
//                 },
//                 child: Text(
//                   'Study With Me',
//                   style: TextStyle(
//                     color: selectedTag2 ? Colors.white : Colors.black,
//                     fontSize: 15.0,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 20.0,
//               ),
//               MaterialButton(
//                 height: 30.0,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0)),
//                 elevation: 5.0,
//                 color: selectedTag3 ? Colors.pinkAccent : Colors.grey[50],
//                 onPressed: () {
//                   category = 'Workout';
//                   setState(() {
//                     selectedTag3 = !selectedTag3;
//                     // selectedTag1 = false;
//                   });
//                 },
//                 child: Text(
//                   'Workout',
//                   style: TextStyle(
//                     color: selectedTag3 ? Colors.white : Colors.black,
//                     fontSize: 15.0,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 20.0,
//               ),
//               MaterialButton(
//                 height: 30.0,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0)),
//                 elevation: 5.0,
//                 color: selectedTag4 ? Colors.pinkAccent : Colors.grey[50],
//                 onPressed: () {
//                   category = 'Space';
//                   setState(() {
//                     selectedTag4 = !selectedTag4;
//                     //selectedTag1 = false;
//                   });
//                 },
//                 child: Text(
//                   'Space',
//                   style: TextStyle(
//                     color: selectedTag4 ? Colors.white : Colors.black,
//                     fontSize: 15.0,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 50,
//         ),
//         TextFormField(
//           keyboardType: TextInputType.multiline,
//           decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(width: 1, color: Colors.blueAccent),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 1, color: Colors.blueAccent),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               hintText: 'Paste the YouTube link here.'),
//           textInputAction: TextInputAction.done,
//           controller: textController,
//           onChanged: (value) {
//             link = value;
//           },
//         ),
//         SizedBox(
//           height: 50,
//         ),
//         MaterialButton(
//           minWidth: 20.0,
//           height: 50.0,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//           elevation: 5.0,
//           color: Colors.lightBlue,
//           onPressed: () async {
//             // int id = 0;
//             // String docId = (id++).toString();
//             // DocumentReference ref =
//             //     FirebaseFirestore.instance.collection("youtubeLinks").doc();
//             // await ref.set({
//             //   'docId': ref.id,
//             //   'created': FieldValue.serverTimestamp(),
//             // });
//             // DocumentReference ref1 = FirebaseFirestore.instance
//             //     .collection('youtubeLinks')
//             //     .doc(docId)
//             //     .collection(category)
//             //     .doc(docId);
//             //
//             // await ref1.set({
//             //   'link': link,
//             //   'sender': FirebaseAuth.instance.currentUser.displayName,
//             //   'senderId': FirebaseAuth.instance.currentUser.uid,
//             //   'category': category,
//             //   'created': FieldValue.serverTimestamp(),
//             // });
//           },
//           child: Text(
//             'Confirm',
//             style: TextStyle(
//               fontSize: 15.0,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   @override
//   void initState() {
//     linkRef = FirebaseFirestore.instance.collection('links').doc('urls');
//     super.initState();
//     getData();
//     //print(videoID);
//   }
//
//   _addItemFuntion() async {
//     await linkRef.set({
//       textController.text.toString(): textController.text.toString()
//     }, SetOptions(merge: true));
//     // Flushbar(
//     //     title: 'Added',
//     //     message: 'updating...',
//     //     duration: Duration(seconds: 3),
//     //     icon: Icon(Icons.info_outline))
//     //   ..show(context);
//     setState(() {
//       videoID.add(textController.text);
//     });
//     print('added');
//     FocusScope.of(this.context).unfocus();
//     textController.clear();
//   }
//
//   getData() async {
//     await linkRef
//         .get()
//         .then((value) => value.data()?.forEach((key, value) {
//       if (!videoID.contains(value)) {
//         videoID.add(value);
//       }
//     }))
//         .whenComplete(() => setState(() {
//       videoID.shuffle();
//       showItem = true;
//     }));
//   }
// }
// }
