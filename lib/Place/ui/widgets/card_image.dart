import 'dart:io';
import 'package:flutter/material.dart';
import 'package:curzo_avanzado_flutter_plat/widgets/floating_action_button_green.dart';


class  CardImageWithFabIcon extends StatelessWidget {

  double height;
  double width ;
  double left ;
  String pathImage = "assets/img/beach.jpeg";
  VoidCallback onPressedFabIcon;
  final IconData iconData;



  CardImageWithFabIcon({
    super . key,
    required this.pathImage,
    required this.width,
    required this.height,
    required this.onPressedFabIcon,
    required this.iconData,
    required this.left

});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final card = Container(
      height: height,
      width: width,
      margin:EdgeInsets.only(
        left: left
      ),

      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
                image: pathImage.contains('assets') ? NetworkImage(pathImage)
              :  FileImage( File(pathImage)) as ImageProvider,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: const <BoxShadow>[
          BoxShadow (
            color:  Colors.black38,
            blurRadius: 15.0,
            offset: Offset(0.0, 7.0)
          )
        ]

      ),
    );

    return Stack(
      alignment: const Alignment(0.9,1.1),
      children: <Widget>[
        card,
        FloatingActionButtonGreen(
          iconData: iconData,
          onPressed: onPressedFabIcon,
        )
      ],
    );
  }

}