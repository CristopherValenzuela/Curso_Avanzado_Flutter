import 'package:curzo_avanzado_flutter_plat/Place/repository/firebase_storage_api.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepository {

  final _firebaseStorageAPI = FirebaseStorageAPI();

  Future<UploadTask> uploadFile(String path, image ) => _firebaseStorageAPI.uploadFile(path, image);

}