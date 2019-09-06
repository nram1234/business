class ValidationData{

  String vEmail(String value){


    // var email = "tony@starkindustries.com";
    bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if(!emailValid){
      return 'enter a valid email';
    }
    return null;
  }
  String vPassword(String value){
    if(value.length<6){
      return 'Password must be at least 7 characters';
    }
    return null;
  }
  String username(String value){
    if(value.trim().isEmpty){
      return 'please enter your name';
    }
    return null;
  }
  String userphone(String value){
    if(value.trim().isEmpty){
      return 'please enter your phone';
    }
    return null;
  }
  String checkdata(String value){
    if(value.trim().isEmpty){
      return 'please enter valid data';
    }
    return null;
  }
}