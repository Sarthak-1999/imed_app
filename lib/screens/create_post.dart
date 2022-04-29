import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:imed_app/components/FirebaseApi.dart';

import '../components/FirebaseApi.dart';

late User loggedInUser;

class CreatePost extends StatefulWidget {
  static const String id = 'create_post';

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final postTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String postTitle;
  bool selectedTag1 = false;
  bool selectedTag2 = false;
  late String postTypeText;
  late String value;
  late String postImageUrl;
  late String senderProfileImageUrl;
  late String senderEmail;
  late String postId;

  late UploadTask task;
  late File file;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final fileName = file != null ? basename(file.path) : 'No File Selected';
    senderProfileImageUrl = _auth.currentUser!.photoURL.toString();
    senderEmail = _auth.currentUser!.email!;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_rounded),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Create Post'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text('Select your post type:'),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  height: 48.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 5.0,
                  color: selectedTag1 ? Colors.pinkAccent : Colors.grey[50],
                  onPressed: () {
                    postTypeText = 'Question';
                    setState(() {
                      selectedTag1 = !selectedTag1;
                      selectedTag2 = false;
                    });
                  },
                  child: Text(
                    '# Question',
                    style: TextStyle(
                      color: selectedTag1 ? Colors.white : Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                MaterialButton(
                  height: 48.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 5.0,
                  color: selectedTag2 ? Colors.pinkAccent : Colors.grey[50],
                  onPressed: () {
                    postTypeText = 'Feed';
                    setState(() {
                      selectedTag2 = !selectedTag2;
                      selectedTag1 = false;
                    });
                  },
                  child: Text(
                    '# Feed',
                    style: TextStyle(
                      color: selectedTag2 ? Colors.white : Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Type your question or tagline of your post.'),
              textInputAction: TextInputAction.done,
              controller: postTextController,
              onChanged: (value) {
                postTitle = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    selectFile();
                  },
                  icon: Icon(
                    Icons.image_rounded,
                  ),
                  tooltip: 'Add image from gallery',
                ),
                SizedBox(
                  width: 10.0,
                ),
                IconButton(
                  onPressed: () {
                    selectFile();
                  },
                  icon: Icon(
                    Icons.camera_alt_rounded,
                  ),
                  tooltip: 'Capture image from camera',
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Example file",
              // fileName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            task != null ? buildUploadStatus(task) : Container(),
            SizedBox(
              height: 50,
            ),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 5.0,
              color: Colors.deepOrangeAccent,
              child: MaterialButton(
                child: Text('Post'),
                onPressed: () async {
                  postTextController.clear();
                  if (postTypeText == 'Feed') {
                    if (file != null) {
                      final fileName = basename(file.path);
                      final destination = 'files/$fileName';

                      task = FirebaseApi.uploadFile(destination, file)!;
                      setState(() {});

                      //if (task == null) return null;

                      final snapshot = await task.whenComplete(() {});
                      final urlDownload = await snapshot.ref.getDownloadURL();

                      DocumentReference ref = FirebaseFirestore.instance
                          .collection("postdata")
                          .doc();

                      DocumentReference ref1 = FirebaseFirestore.instance
                          .collection("allUserPost")
                          .doc(_auth.currentUser?.uid);

                      postImageUrl = urlDownload;

                      await ref.set({
                        'postId': ref.id,
                        'postTitle': postTitle,
                        'sender': loggedInUser.displayName,
                        'senderEmail': loggedInUser.email,
                        'senderProfileImageUrl': senderProfileImageUrl,
                        'senderId': loggedInUser.uid,
                        'postType': postTypeText,
                        'postImageUrl': postImageUrl,
                        'created': FieldValue.serverTimestamp(),
                      });

                      await ref1.collection('feeds').doc(ref.id).set({
                        'postId': ref.id,
                        'postTitle': postTitle,
                        'sender': loggedInUser.displayName,
                        'senderEmail': loggedInUser.email,
                        'senderProfileImageUrl': senderProfileImageUrl,
                        'senderId': loggedInUser.uid,
                        'postType': postTypeText,
                        'postImageUrl': postImageUrl,
                        'created': FieldValue.serverTimestamp(),
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Post Uploaded Successfully'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Feed can't be posted without an image!"),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }
                  } else if (postTypeText == 'Question') {
                    if (file != null) {
                      final fileName = basename(file.path);
                      final destination = 'files/$fileName';

                      task = FirebaseApi.uploadFile(destination, file)!;
                      setState(() {});

                      //if (task == null) return null;

                      final snapshot = await task.whenComplete(() {});
                      final urlDownload = await snapshot.ref.getDownloadURL();

                      DocumentReference ref = FirebaseFirestore.instance
                          .collection("postdata")
                          .doc();

                      DocumentReference ref1 = FirebaseFirestore.instance
                          .collection("allUserPost")
                          .doc(_auth.currentUser?.uid);

                      postImageUrl = urlDownload;

                      await ref.set({
                        'postId': ref.id,
                        'postTitle': postTitle,
                        'sender': loggedInUser.displayName,
                        'senderEmail': loggedInUser.email,
                        'senderProfileImageUrl': senderProfileImageUrl,
                        'senderId': loggedInUser.uid,
                        'postType': postTypeText,
                        'postImageUrl': postImageUrl,
                        'created': FieldValue.serverTimestamp(),
                      });
                      await ref1.collection('questions').doc(ref.id).set({
                        'postId': ref.id,
                        'postTitle': postTitle,
                        'sender': loggedInUser.displayName,
                        'senderEmail': loggedInUser.email,
                        'senderProfileImageUrl': senderProfileImageUrl,
                        'senderId': loggedInUser.uid,
                        'postType': postTypeText,
                        'postImageUrl': postImageUrl,
                        'created': FieldValue.serverTimestamp(),
                      });

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Post Uploaded Successfully'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    } else if (file == null && postImageUrl == null) {
                      DocumentReference ref = FirebaseFirestore.instance
                          .collection("postdata")
                          .doc();

                      DocumentReference ref1 = FirebaseFirestore.instance
                          .collection("allUserPost")
                          .doc(_auth.currentUser?.uid);

                      await ref.set({
                        'postId': ref.id,
                        'postTitle': postTitle,
                        'sender': loggedInUser.displayName,
                        'senderEmail': loggedInUser.email,
                        'senderProfileImageUrl': senderProfileImageUrl,
                        'senderId': loggedInUser.uid,
                        'postType': postTypeText,
                        'postImageUrl': null,
                        'created': FieldValue.serverTimestamp(),
                      });
                      await ref1.collection('questions').doc(ref.id).set({
                        'postId': ref.id,
                        'postTitle': postTitle,
                        'sender': loggedInUser.displayName,
                        'senderEmail': loggedInUser.email,
                        'senderProfileImageUrl': senderProfileImageUrl,
                        'senderId': loggedInUser.uid,
                        'postType': postTypeText,
                        'postImageUrl': null,
                        'created': FieldValue.serverTimestamp(),
                      });

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Post Uploaded Successfully'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path!));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file)!;
    setState(() {});

    if (task == null) return null;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    postImageUrl = urlDownload;
    await FirebaseFirestore.instance
        .collection('userdata')
        .add({'postImageUrl': postImageUrl});

    //print(postImageUrl); //'Download-Link: $urlDownload'
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap!.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
