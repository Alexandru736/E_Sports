import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  static String baseUrl = "https://5ddbb358041ac10014de140b.mockapi.io/";
  static int uniqueId = 200;
  String id;
  String createdAt;
  String name;
  String email;
  String avatar;

  User(String id, String createdAt, String name, String avatar, String email) {
    this.id = id;
    this.createdAt = createdAt;
    this.name = name;
    this.avatar = avatar;
    this.email = email;
  }

  User.post(String name, String email) {
    this.id = uniqueId.toString();
    this.createdAt = DateTime.now().toString();
    uniqueId += 1;
    this.name = name;
    this.email = email;
    this.avatar = "https://s3.amazonaws.com…ter/d_nny_m_cher/128.jpg";
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json['id'],
        json['createdAt'],
        json['name'],
        json['avatar'],
        json['email'],
    );
  }

  //POST USER
  static Future<User> createUser(User user) async {
    var url = Uri.parse(baseUrl + 'user');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'id' : user.id,
        'createdAt': user.createdAt,
        'name': user.name,
        'avatar': user.avatar,
        'email': user.email,
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('Successful POST ' + response.statusCode.toString());
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print('BIG FAIL');
      throw Exception('Failed to load album');
    }
  }

  //POST LOGIN
  static Future<User> loginUser(User user) async {
    var url = Uri.parse(baseUrl + 'login');
    print(user.email);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "username": "Karolann24@yahoo.com",
        "password": "Test"
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('Successful LOGIN ' + response.statusCode.toString());
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print('status code ' + response.statusCode.toString() + ' ' + response.request.toString());
      throw Exception('Failed to load user');
    }
  }
}