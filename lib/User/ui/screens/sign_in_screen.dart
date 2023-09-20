import 'package:curzo_avanzado_flutter_plat/User/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:curzo_avanzado_flutter_plat/widgets/gradient_back.dart';
import 'package:curzo_avanzado_flutter_plat/widgets/button_green.dart';
import 'package:curzo_avanzado_flutter_plat/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curzo_avanzado_flutter_plat/platzi_trips_cupertino.dart';
import 'package:curzo_avanzado_flutter_plat/User/model/user.dart' as appModel;

class SignInScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SingInScreen();
  }

}

class _SingInScreen extends State<SignInScreen>{

  //dudas con el codigo 21 ya que no deja continuar si no esta "late".
  late UserBloc userBloc;
  late double screenWidht;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    screenWidht = MediaQuery.of(context).size.width;
    userBloc = BlocProvider.of(context);
    return signInGoogleUI();
  }

  Widget _handleCurretSession(){
    return StreamBuilder(
        stream: userBloc.authStatus,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          //snapshot = data = objeto-User
          if(!snapshot.hasData || snapshot.hasError){
            return signInGoogleUI();
          } else{
            return PlatziTripsCupertino();
          }
        }
    );
  }


  Widget signInGoogleUI(){
      return Scaffold(
        body: Stack(
          alignment:Alignment.center ,
        children:[
          GradientBack(height: null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Container(
                    width: screenWidht,
                    child: Text("Welcome \n This is your Travel App",
                      style: TextStyle(
                          fontSize: 37.0,
                          fontFamily: "Lato",
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
              ),

              ButtonGreen(text: "Login with Gmail",
                  onPressed:() async {
                userBloc.signOut();
                userBloc.signIn().then((UserCredential user) => print ("El usuario es ${user.user} "));
                  },
                width: 300.0,
                height: 50.0,
              )
            ],
          )
        ],
        ),

      );
  }
  
}