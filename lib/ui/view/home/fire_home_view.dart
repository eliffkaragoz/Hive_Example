import 'package:flutter/material.dart';
import 'package:untitled/core/service/firebase_service.dart';

import '../../../cache/user_cache_manager.dart';
import '../../../core/model/student.dart';
import '../../../core/model/user.dart';

class FireHomeView extends StatefulWidget {
  const FireHomeView({Key? key}) : super(key: key);

  @override
  State<FireHomeView> createState() => _FireHomeViewState();
}

class _FireHomeViewState extends State<FireHomeView> {

  List<User>? _items;

  late final ICacheManager<User> cacheManager;
  FirebaseService? service;
  final _dummyString = 'https://i.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service = FirebaseService();
    cacheManager = UserCacheManager('userCacheBox');
    fetchDatas();

  }


  Future<void> fetchDatas() async {
    await cacheManager.init();
    if (cacheManager.getValues()?.isNotEmpty ?? false) {
      _items = cacheManager.getValues();
    } else {
      _items = await service?.getUsers();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          cacheManager.getValues();
          if (_items?.isNotEmpty ?? false) {
            await cacheManager.addItems(_items!);
            print("Ekleme yapıldı");
          }
        },
      ),
      body: (_items?.isNotEmpty ?? false)
          ? ListView.builder(
        itemCount: _items?.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(_dummyString)),
              title: Text('${_items?[index].name}'),
            ),
          );
        },
      )
          : const CircularProgressIndicator(),

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