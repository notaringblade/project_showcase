import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> storeImage(String name, Uint8List file) async {
    Reference ref = storage.ref().child(name).child(auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> postThumbnail(
      String name, String postId, Uint8List file) async {
    Reference ref = storage.ref().child(name).child(postId).child('thumbnail');

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<List<String>> postImages(
      String name, String postId, List<Uint8List> file) async {
    List<String> images = [];

    for (int i = 0; i < file.length; i++) {
      print(i);
      Reference ref = storage.ref().child(name).child(postId).child('image$i');

      UploadTask uploadTask = ref.putData(file[i]);

      TaskSnapshot snap = await uploadTask;

      String downloadUrl = await snap.ref.getDownloadURL();
      images.add(downloadUrl);

      print(images);
    }

    return images;
  }

  Future deleteImages(String name, String postId) async {
    await FirebaseStorage.instance
        .ref()
        .child(name)
        .child(postId)
        .listAll()
        .then((value) {
      value.items.forEach((element) {
        FirebaseStorage.instance.ref(element.fullPath).delete();
      });
    });
  }
}
