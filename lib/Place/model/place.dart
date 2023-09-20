import 'package:flutter/cupertino.dart';

import '../../User/model/user.dart';

class Place {
  String? id;
  final String name;
  final String description;
  final String urlImage;
  int likes;
  //User? userOwner;

  Place({
    Key? key,
    this.likes = 0,
    required this.name,
    required this.description,
    required this.urlImage,
    //this.userOwner
  });
}