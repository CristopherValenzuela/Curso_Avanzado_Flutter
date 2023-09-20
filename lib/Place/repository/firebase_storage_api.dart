import 'dart:html';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageAPI {
  final Reference _storageReference = FirebaseStorage.instance.ref();

  Future<UploadTask> uploadFile(String path, image ) async{

    return Future.value(_storageReference.child(path).putFile(image));

  }
}