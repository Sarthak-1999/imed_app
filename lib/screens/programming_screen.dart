import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeLinksPlayer extends StatefulWidget {
  static const String id = 'youtubeLinksPlayer_screen';
  @override
  _YoutubeLinksPlayerState createState() => _YoutubeLinksPlayerState();
}

class _YoutubeLinksPlayerState extends State<YoutubeLinksPlayer> {
  TextEditingController _addItemController = TextEditingController();
  late DocumentReference linkRef;
  List<String> videoID = [];
  bool showItem = false;
  final youtube =
      RegExp(r"^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programming Videos'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: _addItemController,
              onEditingComplete: () {
                if (youtube.hasMatch(_addItemController.text)) {
                  _addItemFuntion();
                } else {
                  FocusScope.of(this.context).unfocus();
                  _addItemController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Invalid Link, Please provide a valid link'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                  labelText: 'Your Video URL',
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.add, size: 32),
                    onTap: () {
                      if (youtube.hasMatch(_addItemController.text)) {
                        _addItemFuntion();
                      } else {
                        FocusScope.of(this.context).unfocus();
                        _addItemController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Invalid Link, Please provide a valid link'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                  )),
            ),
          ),
          Flexible(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: ListView.builder(
                      itemCount: videoID.length,
                      itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.all(8),
                            child: YoutubePlayer(
                              controller: YoutubePlayerController(
                                  initialVideoId: YoutubePlayer.convertUrlToId(
                                          videoID[index])
                                      .toString(),
                                  flags: YoutubePlayerFlags(
                                    autoPlay: false,
                                  )),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                              progressColors: ProgressBarColors(
                                  playedColor: Colors.red,
                                  handleColor: Colors.red),
                            ),
                          )))),
        ],
      ),
    );
  }

  @override
  void initState() {
    linkRef = FirebaseFirestore.instance.collection('links').doc('urls');
    super.initState();
    getData();
    print(videoID);
  }

  _addItemFuntion() async {
    await linkRef.set({
      _addItemController.text.toString(): _addItemController.text.toString()
    }, SetOptions(merge: true));
    const SnackBar(
      content: Text('Added Successfully'),
      duration: Duration(seconds: 3),
    );
    setState(() {
      videoID.add(_addItemController.text);
    });
    print('added');
    FocusScope.of(context).unfocus();
    _addItemController.clear();
  }

//   getData() async {
//    final vidData= await linkRef
//         .get()
//         .then((value) => value.data();
// for ( key in value) {
//    if (!videoID.contains(value)) {
//                 videoID.add(value);
//               }
// }

//             )
//         .whenComplete(() => setState(() {
//               videoID.shuffle();
//               showItem = true;
//             }));
//   }
// }

  getData() async {
    await linkRef
        .get()
        .then((value) => value.data() != null
            ? (value) => ((key, value) {
                  if (!videoID.contains(value)) {
                    videoID.add(value);
                  }
                })
            : value)
        .whenComplete(() => setState(() {
              videoID.shuffle();
              showItem = true;
            }));
  }
}
