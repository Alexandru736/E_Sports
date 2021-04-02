import 'package:e_sports/pages/home_page.dart';
import 'package:e_sports/pages/login_page.dart';
import 'package:flutter/cupertino.dart';

class Wrapper extends StatelessWidget {

  final user = null;

  @override
  Widget build(BuildContext context) {
    if(user == null)
      return LoginPage();
    else
      return HomePage();
  }
}
