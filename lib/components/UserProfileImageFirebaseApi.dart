import 'dart:io';
import 'package:imed_app/components/firebase_file.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProfileImageFirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  // static UploadTask uploadBytes(String destination, Uint8List data) {
  //   try {
  //     final ref = FirebaseStorage.instance.ref(destination);
  //
  //     return ref.putData(data);
  //   } on FirebaseException catch (e) {
  //     return null;
  //   }
  // }

  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }
}
