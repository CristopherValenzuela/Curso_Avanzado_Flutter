import 'package:curzo_avanzado_flutter_plat/User/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:curzo_avanzado_flutter_plat/Place/ui/screens/home_trips.dart';
import 'package:curzo_avanzado_flutter_plat/Place/ui/screens/search_trips.dart';
import 'package:curzo_avanzado_flutter_plat/User/ui/screens/profile_trips.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class PlatziTripsCupertino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.indigo),
            label: (""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.indigo),
            label: (""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.indigo),
            label: (""),
          ),
        ]),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) => HomeTrips(),
              );
              break;
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) => SearchTrips(),
              );
              break;
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return BlocProvider<UserBloc> (
                      child: ProfileTrips(),
                      bloc: UserBloc(),
                  );
                },
              );
              break;
            default:
              return CupertinoTabView(
                builder: (BuildContext context) => HomeTrips(),
              );
          }
        },
      ),
    );
  }
}
