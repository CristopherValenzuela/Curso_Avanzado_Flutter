import 'dart:html';
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curzo_avanzado_flutter_plat/User/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart'as auth;
import 'package:flutter/cupertino.dart%20%20';
import 'package:flutter/material.dart';
import '../../Place/model/place.dart';
import '../../Place/ui/widgets/card_image.dart';
import '../ui/widgets/profile_place.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String PLACES = "places";

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;



  void updateUserDate(User user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return await ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'lastSignIn': DateTime.now()
    },SetOptions(merge: true));
  }

  Future<void> updatePlaceDate(Place place)async {
    CollectionReference refPlaces = _db.collection(PLACES);

    auth.User? user= _auth.currentUser;
    await  refPlaces.add({
    'name': place.name,
    'descrption': place.description,
    'likes': place.likes,
    'urlImage': place.urlImage,
    'userOwner': _db.doc("${USERS}/${user!.uid}")
      //reference
    }).then ((DocumentReference dr ) {
      ((DocumentSnapshot snapshot) {
        snapshot.id;
        DocumentReference refUsers = _db.collection(USERS).doc(user.uid);
        refUsers.update({
          "myPlaces": FieldValue.arrayUnion([_db.doc("${USERS}/${user.uid}")])
        });
      });
    });

  }

  List<ProfilePlace>buildMyPlaces(List<DocumentSnapshot> placesListSnapshot){
    List<ProfilePlace> profilePlaces = List<ProfilePlace>.empty(growable: true);
    placesListSnapshot.forEach((p) {
      profilePlaces.add(ProfilePlace(
          Place(
        name: p["name"],
        description: p["description"],
        urlImage: p ["urlImage"],
        likes: p["likes"]  )));
    });
      return profilePlaces;
    }

    List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot){
        List<CardImageWithFabIcon> placesCard = List<CardImageWithFabIcon>.empty(growable: true);
        double width = 300.0;
        double height= 350.0;
        double left = 20.0;
        IconData iconData = Icons.favorite_border;

        placesListSnapshot.forEach((p) {
          placesCard.add(CardImageWithFabIcon(
              pathImage: p ["imageUrl"],
              width: width,
              height: height,
              left:left,
              onPressedFabIcon: (){
                //like
                likePlace:[p];
              },
              iconData: iconData,
          ));
        });
        return placesCard;

    }

    Future likePlace(String idPlace) async{ 
      await _db.collection(PLACES).doc(idPlace).get()
          .then((DocumentSnapshot ds) {
            int likes = ds["Likes"];

            _db.collection(PLACES).doc(idPlace)
                .update({
                "likes": likes+1
            });



      });
    }



  }


