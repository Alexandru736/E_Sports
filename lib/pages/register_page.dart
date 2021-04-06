import 'package:e_sports/models/cities.dart';
import 'package:e_sports/models/user.dart';
import 'package:e_sports/pages/home_page.dart';
import 'package:e_sports/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {

  Future<User> _futureUser;
  String userId;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  String _email;
  String _password;
  String _displayName;

  @override
  void initState() {
    super.initState();
    _futureUser = User.createUser(User.post(_nameController.text, _emailController.text));
  }
  Widget input(Icon icon, String hint, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.black38, fontSize: 20),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Color(0xffA6AFDE),
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Color(0xffA6AFDE),
                width: 3,
              ),
            ),
            prefixIcon: Padding(
              child: IconTheme(
                data: IconThemeData(color: Color(0xffA6AFDE)),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            )),
      ),
    );
  }

  Widget registerButton() {
    return InkWell(
      onTap : () async {
        setState(() {
          _futureUser.then((user) => userId = user.id);
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage(null)));
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
          'Register',
          style: TextStyle(fontSize: 20, color: Color(0xff6876C7)),
        ),
      ),
    );
  }

  Widget alreadyAccount() {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Have an account ? ", style: TextStyle(color: Colors.black38, fontSize: 16)),
          Text("Login", style: TextStyle(color: Color(0xffA6AFDE), fontSize: 16)),
        ],
      ),
      onTap: (){
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text("Sign Up"),
        ),
        backgroundColor: Color(0xff4D5EBD),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 70,),
              LoginPageState.title("Sign", "Up"),
              SizedBox(height: 70,),
              input(Icon(Icons.account_circle),
                  "Display Name", _nameController),
              SizedBox(height: 10),
              input(Icon(Icons.email),
                  "Email", _emailController),
              SizedBox(height: 10),
              input(Icon(Icons.lock),
                  "Password", _passwordController),
              SizedBox(height: 50),
              registerButton(),
              SizedBox(height: 50),
              alreadyAccount()
            ],
          )
        ),
      ),
    );
  }
}
