import 'package:curzo_avanzado_flutter_plat/User/bloc/bloc_user.dart';
import 'package:curzo_avanzado_flutter_plat/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:curzo_avanzado_flutter_plat/User/ui/screens/profile_header.dart';
import 'package:curzo_avanzado_flutter_plat/User/ui/widgets/profile_background.dart';
import 'package:curzo_avanzado_flutter_plat/User/ui/widgets/profile_places_list.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileTrips extends StatelessWidget {
late UserBloc userBloc;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of<UserBloc>(context);
    
    return StreamBuilder(
        stream: userBloc.authStatus,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.none:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return showProfileData(snapshot);
            case ConnectionState.done:
              return showProfileData(snapshot);
            default:
          }
          return CircularProgressIndicator();
        }
    );





      /*Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            ProfileHeader(),//User datos
            ProfilePlacesList()//User uid

          ],
        ),
      ],
    );*/
  }

  Widget showProfileData(AsyncSnapshot snapshot){
    if(snapshot.hasData || snapshot.hasError) {
      print("No Logeado");
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              Text("Usuario no logeado.Haz Login")
            ],
          ),
        ],
      );
    }else{
      print("Logeado");
      var user = User(
          uid:snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoUrl
      );
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              ProfileHeader(user),//User datos
              ProfilePlacesList(user)//User uid

            ],
          ),
        ],
      );
    }
  }

}