
import 'package:curzo_avanzado_flutter_plat/User/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../../model/user.dart';
import '../widgets/button_bar.dart';
import '../widgets/user_info.dart';


class ProfileHeader extends StatelessWidget {

   late User user ;

  ProfileHeader( this.user);

  @override
  Widget build(BuildContext context) {
      final title = Text(
      'Profile',
      style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0
      ),
    );

    return Container(
      margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 50.0
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              title
            ],
          ),
          UserInfo(user),
          ButtonsBar()
        ],
      ),
    );
  }
  Widget showProfileData (AsyncSnapshot,snapshot){
      if(!snapshot.hasData || snapshot.hasError){
      print("No logeado");
      return  Container(
        margin: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 50.0
        ),
        child: const Column(
          children: <Widget>[
               CircularProgressIndicator(),
              Text("No se pudo cargar la informacion. Haz login")
          ],
        ),
      );
      }else{
        print("Logeado");
        print(snapshot.data);
        user = User(
            name: snapshot.data.displayName,
            email: snapshot.data.email,
            photoURL: snapshot.data.photoURL, uid: ''
        );
        const title = Text(
          'Profile',
          style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30.0
          ),
        );

        return Container(
          margin: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 50.0
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  title
                ],
              ),
              UserInfo(user),
              ButtonsBar()
            ],
          ),
        );

      }

  }
}