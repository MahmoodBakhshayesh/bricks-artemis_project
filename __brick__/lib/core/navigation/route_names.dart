import 'package:flutter/material.dart';

enum RouteNames {
  splash,
  login,
  home,
  flights,
  airlines,
  aircrafts,
  airports,
  users,
  addFlight,
  checkin,
  board
}

extension RouteNamesDetails on RouteNames {
  String get path {
    switch (this) {
      case RouteNames.addFlight:
        return 'addFlight';
      case RouteNames.checkin:
        return 'checkin';
      case RouteNames.board:
        return 'board';
      case RouteNames.splash:
        return '/';
      case RouteNames.login:
        return '/login';
      default:
        return "/$name";
    }
  }

  String get title {
    switch (this) {
      default:
        return (name.characters.first.toUpperCase() + name.replaceFirst(name.characters.first, ""));
    }
  }

  bool get isMainRoute {
    return [
      RouteNames.flights,
      RouteNames.airlines,
      RouteNames.airports,
      RouteNames.aircrafts,
      RouteNames.users,
    ].contains(this);
  }


  // MainController get controller {
  //   switch(this){
  //     case RouteNames.splash:
  //       return LoginController();
  //     case RouteNames.login:
  //       return LoginController();
  //     case RouteNames.home:
  //       return HomeController();
  //     case RouteNames.flights:
  //       return FlightsController();
  //     case RouteNames.airlines:
  //      return AirlinesController();
  //     case RouteNames.aircrafts:
  //      return AircraftsController();
  //     case RouteNames.airports:
  //       return AirportsController();
  //     case RouteNames.users:
  //       return UsersController();
  //   }
  // }
}
