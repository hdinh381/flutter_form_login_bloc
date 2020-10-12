import 'package:flutter/material.dart';
import 'package:flutter_app_form_login/src/blocs/login_blog.dart';
import 'package:flutter_app_form_login/src/resources/home_page.dart';
class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = new LoginBloc();
  bool _showPass = true;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  var _userNameError = 'Usename khong hop le';
  var _passError = 'Password khong hop le';
  var _userInvalid = false;
  var _passInvalid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Container(
                width: 70,
                height: 70,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffdBd8d8),
                ),
                child: FlutterLogo(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Text(
                "Hello \nWellcome Back",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child:
              StreamBuilder(
                stream: bloc.userStream,
                builder: (context,snapshot) => TextField(
                  controller: _userController,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: "USERNAME",
                    errorText: snapshot.hasError? snapshot.error : null,
                    labelStyle: TextStyle(
                      color: Color(0xfff888888),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),


            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  StreamBuilder(
                    stream: bloc.passStream,
                    builder: (context, snapshot) => TextField(
                      controller: _passController,
                      obscureText: _showPass,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: "PASSWORD",
                        errorText: snapshot.hasError ? snapshot.error : null,
                        labelStyle: TextStyle(
                          color: Color(0xfff888888),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onToggleShowPass,
                    child: Text(
                      _showPass ? 'SHOW' : 'HIDE',
                      style: TextStyle(fontSize: 13, color: Colors.blue,fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: RaisedButton(
                  onPressed: onSignInClicked,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  color: Colors.blue,
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            Container(
              height: 130,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'NEW USER? SIGN UP',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  Text(
                    'FORGOT PASSWORD?',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void onSignInClicked() {
    if (bloc.isValidInfo(_userController.text, _passController.text)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
    //   setState(() {
    //     if(_userController.text.length<6 || !_userController.text.contains('@')) {
    //       _userInvalid = true;
    //     } else _userInvalid = false;
    //     if(_passController.text.length<6) _passInvalid = true;
    //     else _passInvalid = false;
    //     if(_userInvalid == false && _passInvalid == false) {
    //       // Navigator.push(context, MaterialPageRoute(builder: gotoHome));
    //     }
    //   });
    // }
    // Widget gotoHome(BuildContext context){
    //   return HomePage();
    // }
  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}