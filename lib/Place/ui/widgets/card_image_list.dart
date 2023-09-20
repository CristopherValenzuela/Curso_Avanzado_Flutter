import 'package:curzo_avanzado_flutter_plat/User/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'card_image.dart';

class CardImageList extends StatelessWidget {
  late UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      height: 350.0,
      child:StreamBuilder(
        stream: userBloc.placesStream,
        builder:(context,AsyncSnapshot snapshot ){
          switch(snapshot.connectionState){
          case ConnectionState.waiting:
          return CircularProgressIndicator();
          case ConnectionState.none:
          return CircularProgressIndicator();
          case ConnectionState.active:
          return listViewPlaces(userBloc.buildPlaces(snapshot.data.docs));
          case ConnectionState.done:
          return listViewPlaces(userBloc.buildPlaces(snapshot.data.docs));
          default:
          }
          return CircularProgressIndicator();

          }

      )
    );
  }

  Widget listViewPlaces(List<CardImageWithFabIcon> placesCard){
    return ListView(
      padding:const EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children:placesCard,
    );
  }

/*ListView(
        padding:const EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children:,
      ),*/

}