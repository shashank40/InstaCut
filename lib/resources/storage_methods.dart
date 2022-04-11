import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      ////// ref is reference to folder of photos on firebase
      /////// childName will  be received via constaructor
      /// also we can get uid
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);
    ////// upload task to upload file
    TaskSnapshot snapshot = await uploadTask; // when we await uploadtask we get
    /// a snapshot.
    String downloadUrl = await snapshot.ref.getDownloadURL();
    //// download URL saved on firebase for it to fetch as soon as we open
    return downloadUrl;
  }
}
