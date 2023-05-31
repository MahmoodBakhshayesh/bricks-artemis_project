enum FlightFilterEnum {
  all,
  register,
  noRegister
}

extension FlightFilterEnumDetails on FlightFilterEnum {
  String get title {
    switch (this) {
      case FlightFilterEnum.all :
        return "All";
      case FlightFilterEnum.register :
        return "Register";
      case FlightFilterEnum.noRegister :
        return "No Register";
    }
  }
}