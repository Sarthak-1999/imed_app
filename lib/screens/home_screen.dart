import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:imed_app/components/navigation_provider.dart';
import 'package:imed_app/constants.dart';
import 'package:imed_app/screens/ams_screen1.dart';
import 'package:imed_app/screens/classroom_screen1.dart';
import 'package:imed_app/screens/create_post.dart';
import 'package:imed_app/screens/explore_screen.dart';
import 'package:imed_app/screens/profile_user.dart';
import 'package:imed_app/screens/view_profile.dart';
import 'package:imed_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import '../components/drawer_item.dart';
import '../components/drawer_items.dart';

final _firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  final _auth = FirebaseAuth.instance;
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = (brightness == Brightness.dark);
    final provider = Provider.of<NavigationProvider>(context);
    final isCollapsed = true;
    final safeArea = EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top, bottom: 50.0);
    //MyThemes();

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: const Text(
          'IMED',
          // style: TextStyle(color:isDarkMode==true ?Colors.white:Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              child: const Icon(Icons.notifications_none_outlined),
              onTap: () {
                Navigator.pushNamed(context, HomeScreen.id);
              },
            ),
          )
        ],
      ),

      // A widget to create navigation drawer
      drawer: SizedBox(
        width: isCollapsed ? null : MediaQuery.of(context).size.width * 0.2,
        child: Drawer(
          child: Container(
            child: Column(
              children: [
                builderHeader(isCollapsed),
                const Divider(
                  thickness: 2.0,
                ),
                buildList(items: itemsFirst, isCollapsed: isCollapsed),
                const SizedBox(
                  height: 24,
                ),
                const Divider(
                  thickness: 2.0,
                ),
                const SizedBox(
                  height: 24,
                ),
                buildList(
                    indexOffset: itemsFirst.length,
                    items: itemsSecond,
                    isCollapsed: isCollapsed),
                const Spacer(),
                builderCollapseIcon(context, isCollapsed),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),

      // The body shows the main scrollable content
// displaypost();
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('postdata')
            .orderBy('created', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final userdata = snapshot.data?.docs.reversed;

          List<UserDescription> userDescription = [];
          for (var post in userdata!) {
            final postTitle = post['postTitle'];
            final postSender = post['sender'];
            final postSenderId = post['senderId'];
            final postSenderImage = post['senderProfileImageUrl'];
            final postType = post['postType'];
            final postImageUrl = post['postImageUrl'];
            //final postLikeCounter = post.data()['postLikeCounter'];
            // String id = post.id;

            final postDetails = UserDescription(
              postSender: postSender.toString(),
              postSenderId: postSenderId.toString(),
              postText: postTitle.toString(),
              postSenderImageUrl: postSenderImage.toString(),
              postImageUrl: postImageUrl.toString(),
              postType: postType.toString(),
              //postLikeCounter: postLikeCounter,
              id: post.id,
            );

            userDescription.add(postDetails);
          }
          return ListView.builder(
            //cacheExtent: 20,
            dragStartBehavior: DragStartBehavior.down,
            scrollDirection: Axis.vertical,
            controller: controller,
            itemCount: userdata.length,
            itemBuilder: (context, index) {
              return Container(
                child: Card(
                  elevation: 5.0,
                  //margin: EdgeInsets.symmetric(vertical: 5.0),
                  shape: const RoundedRectangleBorder(
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
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar: SizedBox(
        height: 50.0,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home_rounded),
                onPressed: () {
                  scrollUp();
                },
              ),
              IconButton(
                icon: const Icon(Icons.group),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          transitionsBuilder:
                              (context, animation, animationTime, child) {
                            animation = CurvedAnimation(
                              parent: animation,
                              curve: Curves.linearToEaseOut,
                            );
                            return ScaleTransition(
                              scale: animation,
                              alignment: Alignment.bottomLeft,
                              child: child,
                            );
                          },
                          pageBuilder: (context, animation, animationTime) {
                            return const AmsScreen1();
                          }));
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, CreatePost.id);
                },
              ),
              IconButton(
                icon: const Icon(Icons.school_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          transitionsBuilder:
                              (context, animation, animationTime, child) {
                            animation = CurvedAnimation(
                              parent: animation,
                              curve: Curves.linearToEaseOut,
                            );
                            return ScaleTransition(
                              scale: animation,
                              alignment: Alignment.bottomCenter,
                              child: child,
                            );
                          },
                          pageBuilder: (context, animation, animationTime) {
                            return const ClassroomScreen1();
                          }));
                },
              ),
              IconButton(
                icon: const Icon(Icons.book_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          transitionsBuilder:
                              (context, animation, animationTime, child) {
                            animation = CurvedAnimation(
                              parent: animation,
                              curve: Curves.linearToEaseOut,
                            );
                            return ScaleTransition(
                              scale: animation,
                              alignment: Alignment.bottomRight,
                              child: child,
                            );
                          },
                          pageBuilder: (context, animation, animationTime) {
                            return ExploreScreen(); //ChatScreen();
                          }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

// A Widget to create navigation drawer

  Widget builderHeader(bool isCollapsed) => isCollapsed
      ? Column(
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: GestureDetector(
                    child: CircleAvatar(
                      radius: 45.0,
                      // child: CachedNetworkImage(
                      //   imageUrl: _auth.currentUser!.photoURL.toString(),
                      //   fit: BoxFit.cover,
                      // ),
                      backgroundImage:
                          NetworkImage(_auth.currentUser!.photoURL.toString()),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, ProfilePage.id);
                    }),
              ),
            ),
            Column(
              children: [
                Text(
                  _auth.currentUser!.displayName
                      .toString(), //   user display name.
                  style: const TextStyle(fontSize: 25),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  _auth.currentUser!.email
                      .toString(), //         user display email.
                  style: const TextStyle(fontSize: 13),
                  maxLines: 1,
                ),
              ],
            ),
          ],
        )
      : SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              //width: 70.0,
              child: GestureDetector(
                child: const CircleAvatar(
                  radius: 38.0, // TODO: work here.
                  // child: CachedNetworkImage(
                  //   imageUrl: _auth.currentUser.photoURL,
                  // ),
                  // backgroundImage: NetworkImage(_auth.currentUser.photoURL),
                ),
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
              ),
            ),
          ),
        );

  Widget buildList({
    required bool isCollapsed,
    required List<DrawerItem> items,
    int indexOffset = 0,
  }) =>
      ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) {
          final item = items[index];

          return buildMenuItem(
            isCollapsed: isCollapsed,
            text: item.title,
            icon: item.icon,
            onClicked: () => selectItem(context, indexOffset + index),
          );
        },
      );

  selectItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.pushNamed(context, HomeScreen.id);

        break;
      //TODO: Add other cases to access other button like settings and help buttons.
      case 3:
        Navigator.pushNamed(context, WelcomeScreen.id);
        return _auth.signOut();
        break;
    }
  }

  Widget buildMenuItem({
    required bool isCollapsed,
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) {
    final leading = Icon(
      icon,
    );

    return Material(
        color: Colors.transparent,
        child: isCollapsed
            ? ListTile(
                leading: leading,
                title: Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
                onTap: onClicked,
              )
            : ListTile(
                title: leading,
                onTap: onClicked,
              ));
  }

  Widget builderCollapseIcon(BuildContext context, bool isCollapsed) {
    const double size = 52;
    final icon = isCollapsed
        ? Icons.arrow_back_ios_rounded
        : Icons.arrow_forward_ios_rounded;
    final alignment = isCollapsed ? Alignment.centerRight : Alignment.center;
    final margin = isCollapsed ? const EdgeInsets.only(right: 16) : null;
    final width = isCollapsed ? size : double.infinity;

    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: width,
            height: size,
            child: Icon(icon),
          ),
          onTap: () {
            final provider =
                Provider.of<NavigationProvider>(context, listen: false);
            provider.toggleIsCollapsed();
          },
        ),
      ),
    );
  }

// A function to provide scroll to Top functionality and calling it on press of home button in bottom navigation bar.
  void scrollUp() {
    final double start = 0;
    controller.animateTo(start,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

//A function to display a menu on pressing the + icon in bottom navigation bar
  void createButtonOptions(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (BuildContext bc) {
        return Container(
          height: 150.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Icon(
                        Icons.post_add_rounded,
                        size: 30.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Create a Post',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  //Navigator.pushNamed(context, CreatePost.id);
                },
              ),
              GestureDetector(
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Icon(
                        Icons.live_tv_rounded,
                        size: 30.0,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Stream Live',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class UserDescription extends StatefulWidget {
  const UserDescription(
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
bool bookmark = false;

//late _counter;

class _UserDescriptionState extends State<UserDescription> {
  var _counter;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45.0,
          child: ListTile(
            leading: CircleAvatar(
              foregroundImage: NetworkImage(
                widget.postSenderImageUrl,
              ),
            ),
            onTap: () {
              String postSenderId = widget.postSenderId;
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ViewProfile(
                  postSenderId: postSenderId,
                  postSender: '',
                  postSenderEmail: '',
                  postSenderImageUrl: '',
                );
              }));
              //Navigator.push(context, ViewProfile(postSenderId: widget.postSenderId));
            },
            title: Row(
              children: [
                Text(
                  widget.postSender,
                ),
                Flexible(
                  child: Container(
                    alignment: Alignment.centerRight,
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
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: TextButton(
                    child: const Text('Report'),
                    onPressed: () {
                      DocumentReference ref = FirebaseFirestore.instance
                          .collection('reportedPost')
                          .doc(widget.id);
                      ref.set({
                        'postId': ref.id,
                        'reportedByID': FirebaseAuth.instance.currentUser?.uid,
                        'created': FieldValue.serverTimestamp(),
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Post Reported Successfully'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1,
        ),

        Container(
          padding: const EdgeInsets.only(left: 10.0, top: 13.0, bottom: 13.0),
          alignment: Alignment.centerLeft,
          child: Text(
            widget.postText,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 17.5,
            ),
          ),
        ),
        // SizedBox(
        //   height: 10.0,
        // ),
        widget.postImageUrl != null
            ? CachedNetworkImage(
                imageUrl: //widget.postImageUrl != null  ?
                    widget.postImageUrl, //:
                //const Text('Error Retrieving image'),
                fit: BoxFit.fitWidth,
                width: double.maxFinite,
                height: 540.0 // widget.postImageUrl != null ? 550.0 : 100.0,
                )
            : const SizedBox(),
        const Divider(
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
                  Text(_counter.toString()),
                  // postLikeCounter(),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.mode_comment_outlined,
              ),
              onPressed: () {
                //   showModalBottomSheet(
                //       context: context,
                //    //   builder: (context) => comments(),
                //       isScrollControlled: true,
                //       //backgroundColor: Colors.transparent,
                //       //enableDrag: true,
                //       // elevation: 1,
                //       shape: const RoundedRectangleBorder(
                //           side: BorderSide.none,
                //           borderRadius: const BorderRadius.vertical(
                //               top: Radius.elliptical(20, 20))));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: const [
                  //bookmarks(),
                  // Text(_counter.toString()),
                  //postLikeCounter(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget likes() {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
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
          List<int> likes = [];
          for (var like in likesData!) {
            final likesCount = like['postTitle'];
            final postSender = like['sender'];
            final postSenderId = like['senderId'];
            final postSenderImage = like['senderProfileImageUrl'];
            final postType = like['postType'];
            final postImageUrl = like['postImageUrl'];
            final postLikeCounter = like['postLikeCounter'];
          }

          return GestureDetector(
              child: Row(
                children: [
                  Icon(
                    // conditions below change the color of star when liked to yellow when pressed else color remains
                    liked ? Icons.star : Icons.star_border_outlined,
                    color: liked ? Colors.yellow : null,
                  ),
                  Text(count.toString()),
                ],
              ),
              onTap: () async {
                setState(() async {
                  //TODO: Work on star state update being same for user post being from the same user.
                  // liked = !liked;
                  //  int count = await getCount();
                  //  return count;
                });

                if (liked == false) {
                  DocumentReference ref1 = FirebaseFirestore.instance
                      .collection("likes")
                      .doc(widget.id);

                  await ref1
                      .collection('likedByUsers')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .delete();

                  await _firestore.collection('likes').doc(widget.id).update({
                    'likesCounter': count! - 1,
                  });
                  await _firestore
                      .collection('postdata')
                      .doc(widget.id)
                      .update({
                    'likesCounter': count - 1,
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
                    'userId': loggedInUser?.uid,
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
                    'userId': loggedInUser?.uid,
                    'created': FieldValue.serverTimestamp(),
                  });

                  await _firestore.collection('likes').doc(widget.id).update({
                    'likesCounter': count! + 1,
                  });
                  await _firestore
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
  String commentSenderId = FirebaseAuth.instance.currentUser!.uid;
  String? commentSender = FirebaseAuth.instance.currentUser!.displayName;
  String? commentSenderImageUrl = FirebaseAuth.instance.currentUser!.photoURL;
  final textController = TextEditingController();
  final controller = ScrollController();
  Widget comments() {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (_, controller) => Column(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                  title: const Text('Comments'),
                  centerTitle: true,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.elliptical(20, 20),
                    ),
                  )),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
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
                  List<CommentsList> comments = [];
                  for (var comment in commentData!) {
                    // final likesCount = like.data()['postTitle'];
                    final userComment = comment['comment'];
                    final commentSenderId = comment['commentSenderId'];
                    final commentSenderImage = comment['commentSenderImageUrl'];
                    final commentSender = comment['commentSender'];
                    // final postImageUrl = post.data()['postImageUrl'];
                    // final postLikeCounter = post.data()['postLikeCounter'];
                    final commentDetails = CommentsList(
                      commentSender: commentSender,
                      commentSenderId: commentSenderId,
                      commentText: userComment,
                      commentSenderImageUrl: commentSenderImage,

                      //postLikeCounter: postLikeCounter,
                      id: comment.id,
                    );

                    comments.add(
                      commentDetails,
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      //reverse: true,
                      controller: controller,
                      itemCount: count,
                      itemBuilder: (context, index) {
                        return Container(
                          child: comments[index],
                        );
                        // return ListTile(
                        //   leading: CircleAvatar(child: FlutterLogo()),
                        //   title: Text(
                        //     comments[index],
                        //   ),
                        //   trailing: Icon(Icons.report),
                        // );
                      });
                },
              ),
            ],
          ),
          Flexible(
            child: Container(
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
                      DocumentReference ref =
                          _firestore.collection('comments').doc(widget.id);
                      ref.set({
                        'postId': ref.id,
                        // 'userId': loggedInUser.uid,
                        'created': FieldValue.serverTimestamp(),
                      });

                      DocumentReference ref1 = _firestore
                          .collection('comments')
                          .doc(widget.id)
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid);
                      //.collection('users') as DocumentReference;
                      ref1.set({
                        'comment': commentText,
                        'commentSenderId': commentSenderId,
                        'commentSender': commentSender,
                        'commentSenderImageUrl': commentSenderImageUrl,
                        'created': FieldValue.serverTimestamp(),
                      });
                    },
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool bookmark = false;
  Widget bookmarks() {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('bookmarks')
            .doc(widget.id)
            .collection('bookmarkedByUsers')
            //.orderBy('created', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final bookmarksData = snapshot.data?.docs;
          final count1 = bookmarksData?.length;
          List<int> likes = [];
          for (var bookmark in bookmarksData!) {
            final likesCount = bookmark['postTitle'];
            final postSender = bookmark['sender'];
            final postSenderId = bookmark['senderId'];
            final postSenderImage = bookmark['senderProfileImageUrl'];
            final postType = bookmark['postType'];
            final postImageUrl = bookmark['postImageUrl'];
            final postLikeCounter = bookmark['postLikeCounter'];
          }

          return GestureDetector(
              child: Row(
                children: [
                  Icon(
                    // conditions below change the color of star when liked to yellow when pressed else color remains
                    bookmark ? Icons.bookmark : Icons.bookmark_border,
                    color: bookmark ? Colors.white : null,
                  ),
                  Text(count1.toString()),
                ],
              ),
              onTap: () async {
                setState(() {
                  //TODO: Work on star state update being same for user post being from the same user.
                  bookmark = !bookmark;
                  // int count = await getCount();
                  // return count;
                });
                if (bookmark == false) {
                  DocumentReference ref1 = FirebaseFirestore.instance
                      .collection("bookmarks")
                      .doc(widget.id);
                  DocumentReference ref2 = FirebaseFirestore.instance
                      .collection("userBookmarkedPost")
                      .doc(FirebaseAuth.instance.currentUser?.uid);

                  await ref1
                      .collection('bookmarkedByUsers')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .delete();

                  await ref2
                      .collection('allBookmarkedPost')
                      .doc(widget.id)
                      .delete();

                  await _firestore
                      .collection('bookmarks')
                      .doc(widget.id)
                      .update({
                    'bookmarksCounter': count1,
                  });
                  await _firestore
                      .collection('postdata')
                      .doc(widget.id)
                      .update({
                    'bookmarksCounter': count1,
                  });
                }

                ///////////////////////////////////////////////////////////////

                else if (bookmark == true) {
                  //postLikeCounter();

                  DocumentReference ref = FirebaseFirestore.instance
                      .collection("bookmarks")
                      .doc(widget.id);
                  DocumentReference ref2 = FirebaseFirestore.instance
                      .collection("userBookmarkedPost")
                      .doc(FirebaseAuth.instance.currentUser?.uid);

                  await ref.set({
                    'postId': ref.id,
                    // 'userId': loggedInUser.uid,
                    'created': FieldValue.serverTimestamp(),
                  });

                  DocumentReference ref1 = FirebaseFirestore.instance
                      .collection("bookmarks")
                      .doc(widget.id)
                      .collection('bookmarkedByUsers')
                      .doc(FirebaseAuth.instance.currentUser?.uid);
                  // as CollectionReference;
                  await ref1.set({
                    'bookmarkedById': widget.postSenderId,
                    // 'userId': loggedInUser.uid,
                    'created': FieldValue.serverTimestamp(),
                  });
                  // DocumentReference ref3 = FirebaseFirestore.instance
                  //     .collection("userBookmarkedPost")
                  //     .doc(widget.id);

                  await ref2.collection('allBookmarkedPost').doc(ref.id).set({
                    'postId': ref.id,
                    'postTitle': widget.postText,
                    'sender': FirebaseAuth.instance.currentUser?.displayName,
                    'senderProfileImageUrl': widget.postSenderImageUrl,
                    'senderId': FirebaseAuth.instance.currentUser?.uid,
                    'postType': widget.postType,
                    'postImageUrl': widget.postImageUrl,
                    'created': FieldValue.serverTimestamp(),
                  });

                  await _firestore
                      .collection('bookmarks')
                      .doc(widget.id)
                      .update({
                    'bookmarksCounter': count1! + 1,
                  });
                  await _firestore
                      .collection('postdata')
                      .doc(widget.id)
                      .update({
                    'bookmarksCounter': count1 + 1,
                  });
                }
              });
        });
  }
}

class CommentsList extends StatefulWidget {
  CommentsList(
      {required this.commentSender,
      required this.commentSenderId,
      required this.commentText,
      required this.commentSenderImageUrl,

      //this.postLikeCounter,
      required this.id});

  final String commentSender;
  final String commentSenderId;
  final String commentText;

  final String commentSenderImageUrl;

  //final int postLikeCounter;
  final String id;

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        foregroundImage: NetworkImage(
          widget.commentSenderImageUrl,
        ),
      ),
      title: Text(
        widget.commentSender,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        widget.commentText,
      ),
      trailing: const Icon(Icons.report),
    );
  }
}

const double fabSize = 56;

// class CustomChatAnimation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => OpenContainer(
//         transitionDuration: const Duration(seconds: 1),
//         openBuilder: (context, _) => ChatScreen(),
//         closedShape: const CircleBorder(),
//         closedBuilder: (context, openContainer) => Container(
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//           ),
//           height: fabSize,
//           width: fabSize,
//         ),
//       );
// }
