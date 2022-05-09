import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:imed_app/userprofile/appbar_widget.dart';
import 'package:imed_app/userprofile/button_widget.dart';
import 'package:imed_app/userprofile/numbers_widget.dart';
import 'package:imed_app/userprofile/profile_widget.dart';

import '../constants.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile_page';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final controller = ScrollController();
  bool selectedTag1 = true;
  bool selectedTag2 = false;
  //final username = user.displayName;
  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;
    // final username = user.displayName;
    //final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        shrinkWrap: true,
        //physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user!.photoURL!,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          buildAbout(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                //flex: selectedTag1 ? 1 : 0,
                child: MaterialButton(
                  height: selectedTag1 ? 48 : 42,
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  elevation: selectedTag1 ? 10.0 : 0,
                  color: selectedTag1 ? Colors.white : Colors.grey[300],
                  onPressed: () {
                    setState(() {
                      selectedTag1 = !selectedTag1;
                      selectedTag2 = false;
                    });
                  },
                  child: Text(
                    'Feeds',
                    style: TextStyle(
                      color: selectedTag1 ? Colors.black : Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   width: 20.0,
              // ),
              Expanded(
                //flex: selectedTag2 ? 1 : 0,
                child: MaterialButton(
                  height: selectedTag2 ? 48 : 42,
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  elevation: selectedTag2 ? 10.0 : 0,
                  color: selectedTag2 ? Colors.white : Colors.grey[300],
                  onPressed: () {
                    setState(() {
                      selectedTag2 = !selectedTag2;
                      selectedTag1 = false;
                    });
                  },
                  child: Text(
                    'Questions',
                    style: TextStyle(
                      color: selectedTag2 ? Colors.black : Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //buildPost(),
          selectedTag1 ? buildPost() : buildQuestionsPost(),
        ],
      ),
    );
  }

  Widget buildName(user) => Column(
        children: [
          Text(
            FirebaseAuth.instance.currentUser!.displayName!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            FirebaseAuth.instance.currentUser!.email!,
            // style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => Column(
        children: [
          MaterialButton(
              elevation: 8,
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Colors.blueAccent,
              child: Text(
                'Edit you profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {}),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('allUserPost')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection('followers')
                          //.orderBy('created', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                                //backgroundColor: Colors.lightBlueAccent,
                                ),
                          );
                        }
                        final followersData = snapshot.data?.docs;
                        final count = followersData?.length;

                        return Text(count.toString());
                      }),
                  Text('Followers')
                ],
              ),
              Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('allUserPost')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection('following')
                          //.orderBy('created', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                                //backgroundColor: Colors.lightBlueAccent,
                                ),
                          );
                        }
                        final followingData = snapshot.data?.docs;
                        final count = followingData?.length;

                        return Text(count.toString());
                      }),
                  Text('Following')
                ],
              ),
            ],
          ),
        ],
      );

  Widget buildAbout() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Student at IMED Pune.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildPost() => Container(
        margin: EdgeInsets.all(1.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('allUserPost')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('feeds')
                .orderBy('created', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final allPostData = snapshot.data?.docs.reversed;
              final count = allPostData?.length;
              List<UserPostImage> userPostImage = [];
              // List<QuestionsButton> questionButton = [];
              List<UserDescription> userDescription = [];
              for (var post in allPostData!) {
                final postTitle = post['postTitle'];
                final postSender = post['sender'];
                final postSenderEmail = post['senderEmail'];
                final postSenderId = post['senderId'];

                final postSenderImage = post['senderProfileImageUrl'];
                final postType = post['postType'];
                final postImageUrl = post['postImageUrl'];
                //final postLikeCounter = post.data()['postLikeCounter'];
                // String id = post.id;
                final postDetails = UserDescription(
                  postSender: postSender,
                  postSenderId: postSenderId,
                  postText: postTitle,
                  postSenderImageUrl: postSenderImage,
                  postImageUrl: postImageUrl,
                  postType: postType,

                  //postLikeCounter: postLikeCounter,
                  id: post.id,
                );
                final imageDetails = UserPostImage(
                  postImageUrl: postImageUrl,
                  postSenderId: postSenderId,
                  postSenderImageUrl: postSenderImage,
                  postSender: postSender,
                  postSenderEmail: postSenderEmail,
                );

                userDescription.add(postDetails);
                userPostImage.add(imageDetails);
              }
              return Container(
                  child: //selectedTag1 ?
                      GridView.builder(
                          shrinkWrap: true,
                          controller: controller,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                          ),
                          itemCount: count,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: userPostImage[index],
                              onTap: () {
                                onClickItem(index);
                              },
                            );
                          }));
            }),
      );

  onClickItem(index) => showDialog(
        context: context,
        builder: (context) => StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('allUserPost')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('feeds')
                .orderBy('created', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final allPostData = snapshot.data?.docs.reversed;

              List<UserDescription> userDescription = [];
              for (var post in allPostData!) {
                final postTitle = post['postTitle'];
                final postSender = post['sender'];

                final postSenderId = post['senderId'];
                final postSenderImage = post['senderProfileImageUrl'];
                final postType = post['postType'];
                final postImageUrl = post['postImageUrl'];

                final postDetails = UserDescription(
                  postSender: postSender,

                  postSenderId: postSenderId,
                  postText: postTitle,
                  postSenderImageUrl: postSenderImage,
                  postImageUrl: postImageUrl,
                  postType: postType,

                  //postLikeCounter: postLikeCounter,
                  id: post.id,
                );

                userDescription.add(postDetails);
              }

              return Card(
                elevation: 10.0,
                margin: EdgeInsets.symmetric(vertical: 29.0, horizontal: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(20, 20),
                    topRight: Radius.elliptical(20, 20),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  side: BorderSide(
                    width: 0.1,
                  ),
                ),
                child: userDescription[index],
              );
            }),
      );
  Widget buildQuestionsPost() => Container(
        margin: EdgeInsets.all(1.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('allUserPost')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('questions')
                .orderBy('created', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final allPostData = snapshot.data?.docs.reversed;
              final count = allPostData?.length;
              List<QuestionsButton> questionButton = [];
              for (var post in allPostData!) {
                final postTitle = post['postTitle'];
                final postSender = post['sender'];
                // final postSenderEmail = post.data()['senderEmail'];
                final postSenderId = post['senderId'];

                final postSenderImage = post['senderProfileImageUrl'];
                final postType = post['postType'];
                final postImageUrl = post['postImageUrl'];
                //final postLikeCounter = post.data()['postLikeCounter'];
                String id = post.id;

                final questionPostDetails = QuestionsButton(
                  postSender: postSender,
                  postSenderId: postSenderId,
                  postText: postTitle,
                  postSenderImageUrl: postSenderImage,
                  postImageUrl: postImageUrl,
                  postType: postType,
                  id: id,
                );
                questionButton.add(questionPostDetails);
              }
              return ListView.builder(
                shrinkWrap: true,
                //cacheExtent: 20,
                //dragStartBehavior: DragStartBehavior.down,
                //scrollDirection: Axis.vertical,
                controller: controller,
                itemCount: count,
                itemBuilder: (context, index) {
                  return Container(
                    child: questionButton[index],
                  );
                },
              );
            }),
      );
}

class UserPostImage extends StatefulWidget {
  UserPostImage({
    required this.postSender,
    required this.postSenderEmail,
    required this.postSenderId,
    //   this.postText,
    required this.postImageUrl,
    // required this.index,
    required this.postSenderImageUrl,
    // this.postType,
    //this.postLikeCounter,
    // this.id
  });

  final String postSender;
  final String postSenderEmail;
  final String postSenderId;
  // final String postText;
  final String postImageUrl;
  //final int index;
  final String postSenderImageUrl;
  // final String postType;
  // //final int postLikeCounter;
  // final String id;

  @override
  _UserPostImageState createState() => _UserPostImageState();
}

class _UserPostImageState extends State<UserPostImage> {
  final user = FirebaseAuth.instance.currentUser;
  final controller = ScrollController();
  //int _counter;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('allUserPost')
            .doc(widget.postSenderId)
            .collection('feeds')
            .snapshots(),
        builder: (context, snapshot) {
          return Card(
            elevation: 5,
            child: CachedNetworkImage(
              imageUrl: widget.postImageUrl,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.medium,
            ),
          );
        });
  }
}

class UserDescription extends StatefulWidget {
  UserDescription(
      {required this.postSender,
      required this.postSenderId,
      required this.postText,
      required this.postImageUrl,
      required this.postSenderImageUrl,
      required this.postType,
      //this.postLikeCounter,
      required this.id});

  final String postSender;
  final String postSenderId;
  final String postText;
  final String postImageUrl;
  final String postSenderImageUrl;
  final String postType;
  //final int postLikeCounter;
  final String id;

  @override
  _UserDescriptionState createState() => _UserDescriptionState();
}

bool liked = false;
//final _counter  = ;

class _UserDescriptionState extends State<UserDescription> {
  //int _counter;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.postSenderImageUrl),
            ),
            title: Row(
              children: [
                Text(
                  widget.postSender != null
                      ? widget.postSender
                      : 'Error fetching user',
                ),
                Flexible(
                  child: Container(
                    alignment: Alignment.centerRight,
                    //padding: EdgeInsets.only(
                    //left: widget.postType == 'Feed' ? 50.0 : 50.0),
                    child: SizedBox(
                      width: widget.postType == 'Feed' ? 50 : 70,
                      height: 25.0,
                      child: Material(
                        color: widget.postType == 'Feed'
                            ? Colors.greenAccent
                            : Colors.red,
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Center(
                          child: Text(
                            widget.postType != null ? widget.postType : 'error',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // trailing: PopupMenuButton(
            //   itemBuilder: (context) => [PopupMenuItem(child: Text('Report'))],
            // ),
          ),
        ),
        Divider(
          thickness: 1,
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 13.0, bottom: 13.0),
          alignment: Alignment.centerLeft,
          child: Text(
            widget.postText,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 17.5,
            ),
          ),
        ),
        // SizedBox(
        //   height: 10.0,
        // ),
        Expanded(
          child: CachedNetworkImage(
              imageUrl: //widget.postImageUrl != null ?
                  widget.postImageUrl,
              //: Text('Error Retrieving image'),
              fit: BoxFit.fitWidth,
              width: double.maxFinite,
              height: 540.0 // widget.postImageUrl != null ? 550.0 : 100.0,
              ),
        ),
        Divider(
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  likes(),
                  // Text(_counter.toString()),
                  //postLikeCounter(),
                ],
              ),
            ),
            new IconButton(
              icon: Icon(
                Icons.mode_comment_outlined,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => comments(),
                    isScrollControlled: true,
                    //backgroundColor: Colors.transparent,
                    //enableDrag: true,
                    // elevation: 1,
                    shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.elliptical(20, 20))));
              },
            ),
            new IconButton(
              icon: Icon(
                Icons.bookmark_border_rounded,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget likes() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('likes')
            .doc(widget.id)
            .collection('likedByUsers')
            //.orderBy('created', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final likesData = snapshot.data?.docs;
          final count = likesData?.length;
          // List<int> likes = [];
          // for (var like in likesData) {
          //   final likesCount = like.data()['postTitle'];
          //   final postSender = post.data()['sender'];
          //   final postSenderId = post.data()['senderId'];
          //   final postSenderImage = post.data()['senderProfileImageUrl'];
          //   final postType = post.data()['postType'];
          //   final postImageUrl = post.data()['postImageUrl'];
          //   final postLikeCounter = post.data()['postLikeCounter'];
          // }

          return GestureDetector(
              child: Row(
                children: [
                  Icon(
                    // conditions below change the color of star when liked to yellow when pressed else color remains
                    liked ? Icons.star : Icons.star_border_outlined,
                    color: liked ? Colors.yellow : null,
                  ),
                  // FutureBuilder(
                  //     future: postLikeCounter(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         return Text(snapshot.data.toString());
                  //       }
                  //       return Container();
                  //     }),
                  Text(count.toString()),
                ],
              ),
              onTap: () async {
                setState(() {
                  //TODO: Work on star state update being same for user post being from the same user.
                  liked = !liked;
                  // int count = await getCount();
                  // return count;
                });
                if (liked == false) {
                  DocumentReference ref1 = FirebaseFirestore.instance
                      .collection("likes")
                      .doc(widget.id);

                  ref1
                      .collection('likedByUsers')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .delete();

                  await FirebaseFirestore.instance
                      .collection('likes')
                      .doc(widget.id)
                      .update({
                    'likesCounter': count! + 1,
                  });
                  await FirebaseFirestore.instance
                      .collection('postdata')
                      .doc(widget.id)
                      .update({
                    'likesCounter': count + 1,
                  });
                }

                ///////////////////////////////////////////////////////////////

                else if (liked == true) {
                  //postLikeCounter();

                  DocumentReference ref = FirebaseFirestore.instance
                      .collection("likes")
                      .doc(widget.id);

                  ref.set({
                    'postId': ref.id,
                    // 'userId': loggedInUser.uid,
                    'created': FieldValue.serverTimestamp(),
                  });

                  DocumentReference ref1 = FirebaseFirestore.instance
                      .collection("likes")
                      .doc(widget.id)
                      .collection('likedByUsers')
                      .doc(FirebaseAuth.instance.currentUser?.uid);
                  // as CollectionReference;
                  ref1.set({
                    'likedById': widget.postSenderId,
                    // 'userId': loggedInUser.uid,
                    'created': FieldValue.serverTimestamp(),
                  });

                  await FirebaseFirestore.instance
                      .collection('likes')
                      .doc(widget.id)
                      .update({
                    'likesCounter': count! + 1,
                  });
                  await FirebaseFirestore.instance
                      .collection('postdata')
                      .doc(widget.id)
                      .update({
                    'likesCounter': count + 1,
                  });
                }
              });
        });
  }

  late String commentText;
  late String commentSenderId;
  final textController = TextEditingController();
  final controller = ScrollController();
  Widget comments() {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (_, controller) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppBar(
              title: Text('Comments'),
              centerTitle: true,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(20, 20),
                ),
              )),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('comments')
                .doc(widget.id)
                .collection('users')
                .snapshots(),
            //.orderBy('created', descending: false)
            //.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              final commentData = snapshot.data?.docs.reversed;
              final count = commentData?.length;
              List<String> comments = [];
              for (var comment in commentData!) {
                // final likesCount = like.data()['postTitle'];
                final userComment = comment['comment'];
                //final userCommentSenderId = comment.data()['senderId'];
                // final postSenderImage = post.data()['senderProfileImageUrl'];
                // final postType = post.data()['postType'];
                // final postImageUrl = post.data()['postImageUrl'];
                // final postLikeCounter = post.data()['postLikeCounter'];

                comments.add(
                  userComment,
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  //reverse: true,
                  controller: controller,
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(child: FlutterLogo()),
                      title: Text(
                        comments[index],
                      ),
                      trailing: Icon(Icons.report),
                    );
                  });
            },
          ),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: textController,
                    onChanged: (value) {
                      commentText = value;
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    textController.clear();
                    DocumentReference ref = FirebaseFirestore.instance
                        .collection('comments')
                        .doc(widget.id);
                    ref.set({
                      'postId': ref.id,
                      // 'userId': loggedInUser.uid,
                      'created': FieldValue.serverTimestamp(),
                    });

                    DocumentReference ref1 = FirebaseFirestore.instance
                        .collection('comments')
                        .doc(widget.id)
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid);
                    //.collection('users') as DocumentReference;
                    ref1.set({
                      'comment': commentText,
                      'commentSenderId': commentSenderId,
                      'created': FieldValue.serverTimestamp(),
                    });
                  },
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionsButton extends StatefulWidget {
  QuestionsButton(
      {required this.postSender,
      required this.postSenderId,
      required this.postText,
      required this.postImageUrl,
      required this.postSenderImageUrl,
      required this.postType,
      //this.postLikeCounter,
      required this.id});

  final String postSender;
  final String postSenderId;
  final String postText;
  final String postImageUrl;
  final String postSenderImageUrl;
  final String postType;
  //final int postLikeCounter;
  final String id;

  @override
  _QuestionsButtonState createState() => _QuestionsButtonState();
}

//bool liked = false;
//final _counter  = ;

class _QuestionsButtonState extends State<QuestionsButton> {
  //int _counter;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      //margin: EdgeInsets.symmetric(vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(20, 20),
          topRight: Radius.elliptical(20, 20),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        side: BorderSide(
          width: 0.1,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 45.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.postSenderImageUrl),
              ),
              title: Row(
                children: [
                  Text(
                    widget.postSender != null
                        ? widget.postSender
                        : 'Error fetching user',
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerRight,
                      //padding: EdgeInsets.only(
                      //left: widget.postType == 'Feed' ? 50.0 : 50.0),
                      child: SizedBox(
                        width: widget.postType == 'Feed' ? 50 : 70,
                        height: 25.0,
                        child: Material(
                          color: widget.postType == 'Feed'
                              ? Colors.greenAccent
                              : Colors.red,
                          shape: RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Center(
                            child: Text(
                              widget.postType != null
                                  ? widget.postType
                                  : 'error',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // trailing: PopupMenuButton(
              //   itemBuilder: (context) => [PopupMenuItem(child: Text('Report'))],
              // ),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, top: 13.0, bottom: 13.0),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.postText,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 17.5,
              ),
            ),
          ),
          // SizedBox(
          //   height: 10.0,
          // ),
          widget.postImageUrl != null
              ? CachedNetworkImage(
                  imageUrl: //widget.postImageUrl != null ?
                      widget.postImageUrl,
                  // : Text('Error Retrieving image'),
                  fit: BoxFit.fitWidth,
                  width: double.maxFinite,
                  height: 450.0 // widget.postImageUrl != null ? 550.0 : 100.0,
                  )
              : SizedBox(),
          Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    likes(),
                    // Text(_counter.toString()),
                    //postLikeCounter(),
                  ],
                ),
              ),
              new IconButton(
                icon: Icon(
                  Icons.mode_comment_outlined,
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => comments(),
                      isScrollControlled: true,
                      //backgroundColor: Colors.transparent,
                      //enableDrag: true,
                      // elevation: 1,
                      shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(20, 20))));
                },
              ),
              new IconButton(
                icon: Icon(
                  Icons.bookmark_border_rounded,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget likes() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('likes')
            .doc(widget.id)
            .collection('likedByUsers')
            //.orderBy('created', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final likesData = snapshot.data?.docs;
          final count = likesData?.length;
          // List<int> likes = [];
          // for (var like in likesData) {
          //   final likesCount = like.data()['postTitle'];
          //   final postSender = post.data()['sender'];
          //   final postSenderId = post.data()['senderId'];
          //   final postSenderImage = post.data()['senderProfileImageUrl'];
          //   final postType = post.data()['postType'];
          //   final postImageUrl = post.data()['postImageUrl'];
          //   final postLikeCounter = post.data()['postLikeCounter'];
          // }

          return GestureDetector(
              child: Row(
                children: [
                  Icon(
                    // conditions below change the color of star when liked to yellow when pressed else color remains
                    liked ? Icons.star : Icons.star_border_outlined,
                    color: liked ? Colors.yellow : null,
                  ),
                  // FutureBuilder(
                  //     future: postLikeCounter(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         return Text(snapshot.data.toString());
                  //       }
                  //       return Container();
                  //     }),
                  Text(count.toString()),
                ],
              ),
              onTap: () async {
                setState(() {
                  //TODO: Work on star state update being same for user post being from the same user.
                  liked = !liked;
                  // int count = await getCount();
                  // return count;
                });
                if (liked == false) {
                  DocumentReference ref1 = FirebaseFirestore.instance
                      .collection("likes")
                      .doc(widget.id);

                  ref1
                      .collection('likedByUsers')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .delete();

                  await FirebaseFirestore.instance
                      .collection('likes')
                      .doc(widget.id)
                      .update({
                    'likesCounter': count! + 1,
                  });
                  await FirebaseFirestore.instance
                      .collection('postdata')
                      .doc(widget.id)
                      .update({
                    'likesCounter': count + 1,
                  });
                }

                ///////////////////////////////////////////////////////////////

                else if (liked == true) {
                  //postLikeCounter();

                  DocumentReference ref = FirebaseFirestore.instance
                      .collection("likes")
                      .doc(widget.id);

                  ref.set({
                    'postId': ref.id,
                    // 'userId': loggedInUser.uid,
                    'created': FieldValue.serverTimestamp(),
                  });

                  DocumentReference ref1 = FirebaseFirestore.instance
                      .collection("likes")
                      .doc(widget.id)
                      .collection('likedByUsers')
                      .doc(FirebaseAuth.instance.currentUser?.uid);
                  // as CollectionReference;
                  ref1.set({
                    'likedById': widget.postSenderId,
                    // 'userId': loggedInUser.uid,
                    'created': FieldValue.serverTimestamp(),
                  });

                  await FirebaseFirestore.instance
                      .collection('likes')
                      .doc(widget.id)
                      .update({
                    'likesCounter': count! + 1,
                  });
                  await FirebaseFirestore.instance
                      .collection('postdata')
                      .doc(widget.id)
                      .update({
                    'likesCounter': count + 1,
                  });
                }
              });
        });
  }

  late String commentText;
  late String commentSenderId;
  final textController = TextEditingController();
  final controller = ScrollController();
  Widget comments() {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (_, controller) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppBar(
              title: Text('Comments'),
              centerTitle: true,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(20, 20),
                ),
              )),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('comments')
                .doc(widget.id)
                .collection('users')
                .snapshots(),
            //.orderBy('created', descending: false)
            //.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              final commentData = snapshot.data?.docs.reversed;
              final count = commentData?.length;
              List<String> comments = [];
              for (var comment in commentData!) {
                // final likesCount = like.data()['postTitle'];
                final userComment = comment['comment'];
                //final userCommentSenderId = comment.data()['senderId'];
                // final postSenderImage = post.data()['senderProfileImageUrl'];
                // final postType = post.data()['postType'];
                // final postImageUrl = post.data()['postImageUrl'];
                // final postLikeCounter = post.data()['postLikeCounter'];

                comments.add(
                  userComment,
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  //reverse: true,
                  controller: controller,
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(child: FlutterLogo()),
                      title: Text(
                        comments[index],
                      ),
                      trailing: Icon(Icons.report),
                    );
                  });
            },
          ),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: textController,
                    onChanged: (value) {
                      commentText = value;
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    textController.clear();
                    DocumentReference ref = FirebaseFirestore.instance
                        .collection('comments')
                        .doc(widget.id);
                    ref.set({
                      'postId': ref.id,
                      // 'userId': loggedInUser.uid,
                      'created': FieldValue.serverTimestamp(),
                    });

                    DocumentReference ref1 = FirebaseFirestore.instance
                        .collection('comments')
                        .doc(widget.id)
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid);
                    //.collection('users') as DocumentReference;
                    ref1.set({
                      'comment': commentText,
                      'commentSenderId': commentSenderId,
                      'created': FieldValue.serverTimestamp(),
                    });
                  },
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
