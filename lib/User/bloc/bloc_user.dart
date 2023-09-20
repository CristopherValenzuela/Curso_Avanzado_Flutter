import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curzo_avanzado_flutter_plat/Place/repository/firebase_storage_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:curzo_avanzado_flutter_plat/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curzo_avanzado_flutter_plat/User/repository/cloud_firestore_repository.dart';
import 'package:curzo_avanzado_flutter_plat/User/repository/cloud_firestore_api.dart';
import 'package:curzo_avanzado_flutter_plat/User/model/user.dart' as userModel;

import '../../Place/model/place.dart';
import '../../Place/ui/widgets/card_image.dart';
import '../ui/widgets/profile_place.dart';

class UserBloc implements Bloc{

  final _auth_repository = AuthRepository();

  //flujo de datos -Streams
  //Stream - Firebase
  Stream<User?> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User?> get authStatus => streamFirebase;
  Future<User?> currentUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }
  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<UploadTask> uploadFile(String path, image ) => _firebaseStorageRepository.uploadFile(path, image);
  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance.collection(CloudFirestoreAPI().PLACES).snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;


  //caso uso
  //1.signIn a la aplicación Google
  Future<UserCredential> signIn() => _auth_repository.signInFirebase();

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository =CloudFirestoreRepository();
  void updateUserDateFirestore(userModel.User user) => _cloudFirestoreRepository.updateUserDateFirestore(user);
  Future<void> updatePlaceData(Place place) => _cloudFirestoreRepository.updatePlaceData(place);
  List<ProfilePlace>buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);
  Stream<QuerySnapshot> myPlacesListStream(String uid) => FirebaseFirestore.instance.collection(CloudFirestoreAPI().PLACES).where(
    "userOwner", isEqualTo: FirebaseFirestore.instance.doc(
    "${CloudFirestoreAPI().USERS}/${uid}")).snapshots();

  List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildPlaces(placesListSnapshot);



  signOut(){
    _auth_repository.signOut();
  }


  @override
  void dispose() {
    // TODO: implement dispose



  }
  
}