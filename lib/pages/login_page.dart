import 'package:e_sports/models/cities.dart';
import 'package:e_sports/models/user.dart';
import 'package:e_sports/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  Future<User> _futureUser;
  String userId;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  static Widget title(String s1, String s2) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: s1,
          style: GoogleFonts.portLligatSans(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Color(0xffA6AFDE)),
          children: [
            TextSpan(
                text: s2,
                style: TextStyle(color: Colors.black38, fontSize: 50))
          ]),
    );
  }

  Widget email(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: 45,
        padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
        child: TextField(
          controller: _emailController,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              Icons.person,
              color: Color(0xffA6AFDE),
            ),
            hintText: 'Email',
          ),
        ));
  }

  Widget loginButton() {
    return InkWell(
      onTap : () async {
        // TODO: Endpoint disabled
        // _futureUser = User.loginUser(User.post("", _emailController.text));
        // setState(() {
        //   _futureUser.then((user) => userId = user.id);
        // });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage(Cities.list_of_cities)));
      },
      child: Container(
        width: 200,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffA6AFDE),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color(0xff6876C7)),
        ),
      ),
    );
  }

  Widget password(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.vpn_key,
            color: Color(0xffA6AFDE),
          ),
          hintText: 'Password',
        ),
      ),
    );
  }


  static Widget sign_up(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Don't have an account ? ", style: TextStyle(color: Colors.black38, fontSize: 16)),
          Text("Sign Up", style: TextStyle(color: Color(0xff828ED1), fontSize: 16)),
        ],
      ),
      onTap: (){
        try {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        } catch(e) {
          print(e.toString());
        }
      },
    );
  }
  
  static Widget forgot_pass() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 16, right: 32
        ),
        child: Text('Forgot Password ?',
          style: TextStyle(
              color: Colors.grey
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text("Login"),
          ),
          backgroundColor: Color(0xff4D5EBD),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              SizedBox(
                height: 70,
              ),
              title("Kite", "Surfing"),
              SizedBox(height: 90),
              email(context),
              SizedBox(height: 25,),
              password(context),
              SizedBox(height: 5,),
              forgot_pass(),
              SizedBox(height: 60,),
              loginButton(),
              SizedBox(height: 80,),
              sign_up(context)
            ]),
          ),
        ));
  }
}
