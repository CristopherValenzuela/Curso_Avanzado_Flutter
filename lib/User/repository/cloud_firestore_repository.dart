import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curzo_avanzado_flutter_plat/User/repository/cloud_firestore_api.dart';
import '../../Place/model/place.dart';
import '../../Place/ui/widgets/card_image.dart';
import '../model/user.dart';
import '../ui/widgets/profile_place.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDateFirestore(User user) => _cloudFirestoreAPI.updateUserDate(user);
  Future<void> updatePlaceData(Place place)=> _cloudFirestoreAPI.updatePlaceDate(place);

  List<ProfilePlace>buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreAPI.buildMyPlaces(placesListSnapshot);
  List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreAPI.buildPlaces(placesListSnapshot);
}