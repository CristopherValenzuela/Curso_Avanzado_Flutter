import 'dart:async';
import 'dart:html';
import 'dart:io';
import 'package:curzo_avanzado_flutter_plat/User/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:curzo_avanzado_flutter_plat/Place/ui/screens/add_place_screen.dart';
import 'circle_button.dart';
import 'package:image_picker/image_picker.dart';

class ButtonsBar extends StatelessWidget {

late UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    userBloc = BlocProvider.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: 10.0
        ),
        child: Row(
          children: <Widget>[
            //cambiar la contraseña
            CircleButton(true, Icons.vpn_key , 20.0, Color.fromRGBO(255, 255, 255, 0.6), () =>{}),
            //Añadiremos un nuevo lugar
            CircleButton(false, Icons.add, 40.0, Color.fromRGBO(255, 255, 255, 1), () {
              ImagePicker().pickImage(
                  source: ImageSource.camera
              ).then((image) {
                Navigator.push(context,
                    MaterialPageRoute(builder:(BuildContext context) => AddPlaceScreen(image:(image!.path))));
              } as FutureOr Function(XFile? value)).catchError((onError) => print(onError));


              } ),
            //cer_rar session
            CircleButton(true, Icons.exit_to_app, 20.0, Color.fromRGBO(255, 255, 255, 0.6),
              () => userBloc.signOut()
              ),

          ],
        )
    );
  }

}