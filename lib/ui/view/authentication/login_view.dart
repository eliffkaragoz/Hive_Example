import 'package:flutter/material.dart';
import 'package:untitled/components/elevated_button_widget.dart';
import 'package:untitled/core/model/user/user_auth_error.dart';
import 'package:untitled/core/model/user/user_request.dart';
import 'package:untitled/core/service/firebase_service.dart';
import 'package:untitled/extension/context_extension.dart';
import 'package:untitled/ui/view/home/fire_home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? username;
  String? password;
  FirebaseService service = FirebaseService();

  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('LOGIN', style: context.theme.textTheme.headline6?.copyWith(color: Colors.white),),),
      key: scaffold,
      body: Center(
        child: Padding(
          padding: context.paddingAll(value: context.height * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildTextFieldEmail(),
              SizedBox(height: context.height * 0.04,),
              buildTextFieldPassword(),
              SizedBox(height: context.height * 0.04,),
              Center(
                child: buildLoginButton(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildLoginButton(BuildContext context)  {
    return ElevatedButtonWidget(context: context, onPres: () async{
    var result =  await service.postUser(UserRequest(email: username, password: password, returnSecureToken: true));
    if(result is FirebaseAuthError){
      scaffold.currentState?.showSnackBar(SnackBar(content: Text(result.error!.message!),));
    }
    else{
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => FireHomeView())
      );
    }
  }, text: "Login" ,buttonColor: Colors.blue,);


  }

  TextField buildTextFieldPassword() {
    return TextField(
               onChanged: (val){
                setState(() {
                  password = val;
                });
              },decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Password"),);
  }

  TextField buildTextFieldEmail() {
    return TextField(
              onChanged: (val){
                setState(() {
                  username = val;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Username"),);
  }
}
