import 'package:flutter/material.dart';
import 'package:curzo_avanzado_flutter_plat/widgets/gradient_back.dart';
import 'package:curzo_avanzado_flutter_plat/Place/ui/widgets/card_image_list.dart';

class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        GradientBack(height: 250.0),
        CardImageList()
      ],
    );
  }

}