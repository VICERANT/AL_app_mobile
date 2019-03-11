import 'package:shared_preferences/shared_preferences.dart';
import 'package:alevelapp/src/screens/register_screen/register_screen.dart';
import 'package:alevelapp/src/values/api_urls.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../mixins/validator_mixin.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidatorMixin {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String token;
  String email;
  String password;

  //<<<<<<<<<< Snack Bar >>>>>>>>

  _showSnackBar(String invalidMsg) {
    final snackBar = SnackBar(
      content: Text(
        invalidMsg,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.blueGrey,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo(),
              SizedBox(height: 8.0),
              welcomeText(),
              SizedBox(height: 45.0),
              emailField(),
              SizedBox(height: 8.0),
              passwordField(),
              SizedBox(height: 24.0),
              loginButton(),
              forgetPasswordButton(),
              createAccountButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Center(
      child: CircleAvatar(
        child: Image(image: AssetImage('assets/images/icon.png')),
        maxRadius: 70.0,
        minRadius: 20.0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget welcomeText() {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            "A-Level",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Log in to start studying...',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        labelText: 'User Name',
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      ),
//      validator: (value) {
//        if (value.isEmpty) return 'please enter username';
//      },
      onSaved: (String value) {
        this.email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.keyboard),
        labelText: 'Password',
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      ),
//      validator: passwordValidator,
      onSaved: (String value) {
        this.password = value;
      },
    );
  }

  Widget loginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(32.0),
        color: Colors.blueAccent,
        shadowColor: Colors.blueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 150.0,
          height: 45.0,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _postRequest();
            }
          },
          child: Text('Log In'),
        ),
      ),
    );
  }

  Widget forgetPasswordButton() {
    return FlatButton(
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
      onPressed: () {},
    );
  }

  Widget createAccountButton() {
    return FlatButton(
      child: Text(
        'Create new Account',
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/register');
      },
    );
  }

  void _postRequest() async {
//    var body = {'email': email, 'password': password};
    var body = {'email': "dldndasanayaka@gmail.com", 'password': "passwordkugd"};

    print(body);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _buildLoadingDialog();
        });

    http.post(ApiUrls.login, body: body).then((dynamic response) {
      Map<String, dynamic> res = json.decode(response.body);
      Navigator.pop(context);
      print(res['state']);
      switch (res['state']) {
        case 1:
          {
            token = res["JWT_Token"];
            _savePreference();
            break;
          }
        case 2:
          {
            invalidAuth("Oops! This user doesn't exist!!");
            break;
          }
        case 3:
          {
            //TODO: navigate to verification view
            break;
          }
        case 5:
          {
            invalidAuth("Something went wrong! Try Again!");
            break;
          }
        case 6:
          {
            invalidAuth("Username or Password incorrect!");

            break;
          }
      }
    });
  }

  void invalidAuth(String invalidMsg) {
    setState(() {
      _showSnackBar(invalidMsg);
      _formKey.currentState.reset();
    });
  }

  _savePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("token", token);
    });
    Navigator.of(context).pushNamed('/home');
  }

  Widget _buildLoadingDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          leading: CircularProgressIndicator(),
          title: Text('Loading...'),
        ),
      ),
    );
  }
}
