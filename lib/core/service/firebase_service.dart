import 'package:http/http.dart'as http ;
import 'package:untitled/core/model/student.dart';
import 'package:untitled/core/model/user/user_auth_error.dart';
import 'package:untitled/core/model/user/user_request.dart';
import 'dart:io';
import 'dart:convert';
import '../model/user.dart';

class FirebaseService{
  static const String FIREBASE_URL = "https://hwafire-3d6f9-default-rtdb.firebaseio.com/";
  static const String FIREBASE_AUTH_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAjqa2_JSXPOoOD0c1uHHCqsbgCONnmuBY";

  Future postUser(UserRequest request) async {
    var jsonModel = json.encode(request.toJson());
    var response = await http.post(Uri.parse(FIREBASE_AUTH_URL), body: jsonModel);

    switch(response.statusCode){
      case HttpStatus.ok:
        return true;
      default:
        var errorJson = json.decode(response.body);
        var error = FirebaseAuthError.fromJson(errorJson);
        return error;
    }
  }


  Future<List<User>> getUsers() async {
    var response = await http.get(Uri.parse("$FIREBASE_URL/users.json"));

    switch(response.statusCode){
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        final userList = jsonModel.
        map((e) => User.fromJson(e as Map <String, dynamic>))
            .toList().cast<User>();
        return userList;
      default:
        return Future.error(response.statusCode);
    }
  }

  Future<List<Student>> getStudents() async {
    var response = await http.get(Uri.parse("$FIREBASE_URL/students.json"));

    switch(response.statusCode){
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body) as Map;
        final studentList = <Student>[];

        jsonModel.forEach((key, value) {
          Student student = Student.fromJson(value);
          student.key = key;
          studentList.add(student);
        });
        return studentList;
      default:
        return Future.error(response.statusCode);
    }


  }


}