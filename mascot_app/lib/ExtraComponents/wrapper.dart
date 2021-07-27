import 'package:flutter/cupertino.dart';
import 'package:mascot_app/Login/Loginmain.dart';
import 'package:mascot_app/mainApp.dart';
import 'package:mascot_app/objects/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget{
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final user = Provider.of<UserModel>(context);

    if(user == null){
      return Login();
    }
    
    //show main system routes
    return HomePage();
  }
}