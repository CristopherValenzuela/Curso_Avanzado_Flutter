import 'dart:io';
import 'package:curzo_avanzado_flutter_plat/Place/model/place.dart';
import 'package:curzo_avanzado_flutter_plat/User/bloc/bloc_user.dart';
import 'package:curzo_avanzado_flutter_plat/User/model/user.dart';
import 'package:curzo_avanzado_flutter_plat/widgets/button_purple.dart';
import 'package:curzo_avanzado_flutter_plat/widgets/gradient_back.dart';
import 'package:curzo_avanzado_flutter_plat/widgets/text_input.dart';
import 'package:curzo_avanzado_flutter_plat/widgets/title_header.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../widgets/card_image.dart';
import '../widgets/title_imput_location.dart';
import 'package:flutter/cupertino.dart  ';
import 'package:firebase_auth/firebase_auth.dart';

class AddPlaceScreen extends StatefulWidget{

   File image;

  AddPlaceScreen({super.key,  required this.image});


  @override
  State<StatefulWidget> createState() {
    return _AddPlaceScreen();
  }

}
class _AddPlaceScreen extends State<AddPlaceScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final _controllerTitlePlace = TextEditingController();
    final _controllerDescriptionPlace =TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          GradientBack(height: 300.0),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 25.0,left: 5.0),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 45,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

                Flexible(
                child: Container(
                  child: Container(
                    padding: EdgeInsets.only(top: 45.0,left: 20.0,right: 10.0),
                    child: TitleHeader(title: 'Add a new Place'),
                  )
                ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 120.0,bottom: 20.0),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CardImageWithFabIcon(
                    pathImage: widget.image.path,
                    iconData:Icons.camera_alt,
                    width: 350.0,
                    height: 250.0,
                    onPressedFabIcon: () {  },
                    left: 20.0,
                  ),
                ), //Foto
                Container(//textfiel title
                  margin:EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child:TextInput(
                    hintText: 'Title',
                    inputType: TextInputType.text,
                    maxLines: 1,
                    controller: _controllerTitlePlace,
                  ),
                ),
                TextInput(
                    hintText: "Description",
                    inputType: TextInputType.multiline,
                    maxLines: 4,
                    controller: _controllerDescriptionPlace,
                ),
                Container(
                  margin:EdgeInsets.only(top: 20.0),
                   child: TextInpuLocation(
                     hintText: 'Add Location',
                     iconData: Icons.location_on_outlined,
                     controller: _controllerDescriptionPlace),
                ),
                Container(
                  width: 70.0,
                  child: ButtonPurple(
                    buttonText: "Add Place",
                    onPressed: () {
                      //1.Firebase Storage
                      //url de la imagen
                      //url-
                      //ID de usuario logiado actualmente
                      userBloc.currentUsuario().then((user) {
                        if (user != null) {
                          String uid = user.uid;
                          //Manera de guardar las fotos con nombre  fecha y dia unico
                          String path ="${uid}/${DateTime.now().toString()}.jpg";
                          userBloc.uploadFile(path, widget.image).then((UploadTask storageTask) {
                          storageTask.then((TaskSnapshot snapshot) {
                          snapshot.ref.getDownloadURL().then((imageUrl){

                            //2.Cloud Firestore
                            //Place -title, description,url,userOwner,likes
                            userBloc.updatePlaceData(Place(
                              name: _controllerTitlePlace.text,
                              description: _controllerDescriptionPlace.text,
                              likes: 0,
                              urlImage: imageUrl,
                            )).whenComplete(() {
                              print("Termino");
                              Navigator.pop(context);

                            });
                              });


                      },
                      );
                    }
                  );
               }
                }
              );
                    }
            ),

          )
        ],
      ),
      )
    ]
    )
    );
  }

}