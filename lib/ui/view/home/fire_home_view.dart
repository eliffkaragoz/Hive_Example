import 'package:flutter/material.dart';
import 'package:untitled/core/service/firebase_service.dart';

import '../../../core/model/student.dart';
import '../../../core/model/user.dart';

class FireHomeView extends StatefulWidget {
  const FireHomeView({Key? key}) : super(key: key);

  @override
  State<FireHomeView> createState() => _FireHomeViewState();
}

class _FireHomeViewState extends State<FireHomeView> {

  FirebaseService? service;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service = FirebaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: studentFutureBuilder(),
    );
  }

  FutureBuilder<List<Student>> studentFutureBuilder() {
    return FutureBuilder<List<Student>>(
      future: service?.getStudents() ,
      builder: (context,snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.done:
            if(snapshot.hasData)
              return _lisStudent(snapshot.data!);
            else
              return _notFoundWidget;
          default:
            return _waitingWidget;
        }
      },
    );
  }

  FutureBuilder<List<User>> userFutureBuilder() {
    return FutureBuilder<List<User>>(
      future: service?.getUsers() ,
      builder: (context,snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.done:
            if(snapshot.hasData)
              return _listUser(snapshot.data!);
            else
              return _notFoundWidget;
              break;
          default:
            return _waitingWidget;

        }
      },
    );
  }

  Widget _listUser(List<User> list){
    return ListView.builder(itemCount: list.length,itemBuilder: (context,index) => _userCard(list[index]));
  }

  Widget _lisStudent(List<Student> list){
    return ListView.builder(itemCount: list.length,itemBuilder: (context,index) => _studentCard(list[index]));
  }
  Widget _userCard(User user){
    return Card(
      child: ListTile(
        title: Text(user.name!),
      ),
    );
  }
  Widget _studentCard(Student student){
    return Card(
      child: ListTile(
        title: Text(student.name!),
        subtitle: Text(student.number.toString()),
      ),
    );
  }

  Widget get _notFoundWidget => Center(
    child: Text("not found"),
  );

  Widget get _waitingWidget => Center(child: CircularProgressIndicator(),);
}
