import 'package:alevelapp/src/mixins/validator_mixin.dart';
import 'package:alevelapp/src/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidatorMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email;
  String password;
  String firstName;
  String lastName;
  String city;
  String contactNumber;
  String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo(),
              SizedBox(height: 8.0),
              welcomeText(),
              SizedBox(height: 10.0),
              _firstNameField(),
              SizedBox(height: 8.0),
              _lastNameField(),
              SizedBox(height: 8.0),
              _userNameField(),
              SizedBox(height: 8.0),
              _emailField(),
              SizedBox(height: 8.0),
              _passwordField(),
              SizedBox(height: 8.0),
              _cityField(),
              SizedBox(height: 8.0),
              _contactNumberField(),
              Container(margin: EdgeInsets.only(bottom: 25.0)),
              _registerButton(),
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
        maxRadius: 40.0,
        minRadius: 10.0,
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
          Text(
            'Enter your details',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _firstNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'First Name',
        hintText: 'Buddhika',
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter first name';
        }
      },
      onSaved: (String value) {
        this.firstName = value;
      },
    );
  }

  Widget _lastNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Last name',
        hintText: 'Chathuranga',
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter last name';
        }
      },
      onSaved: (String value) {
        this.lastName = value;
      },
    );
  }

  Widget _userNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'User Name',
        hintText: 'hackerbuddy96',
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter username';
        }
      },
      onSaved: (String value) {
        this.userName = value;
      },
    );
  }

  Widget _emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'name@email.com',
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: emailValidator,
      onSaved: (String value) {
        this.email = value;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'password',
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      ),
      obscureText: true,
      validator: passwordValidator,
      onSaved: (String value) {
        this.password = value;
      },
    );
  }

  Widget _cityField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'City',
        hintText: 'Ratnapura',
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter username';
        }
      },
      onSaved: (String value) {
        this.city = value;
      },
    );
  }

  Widget _contactNumberField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Mobile',
        hintText: '071234567',
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter mobile number';
        }
      },
      onSaved: (String value) {
        this.contactNumber = value;
      },
    );
  }


  Widget _registerButton() {
    return Material(
      borderRadius: BorderRadius.circular(32.0),
      color: Colors.blueAccent,
      shadowColor: Colors.blueAccent.shade100,
      elevation: 5.0,
      child: MaterialButton(
        minWidth: 150.0,
        height: 45.0,
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            postRequest();
          }
        },
        child: Text('Register'),
      ),
    );
  }

  void postRequest() async {
    var url = 'https://frightful-warlock-77972.herokuapp.com/user/register';

    var body = {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
      'city': city,
      'contactNumber': contactNumber
    };

    print(body);

    http.post(url, body: body).then((dynamic response) {
      Map<String, dynamic> res = json.decode(response.body);
      print(res);
      if (res['success'] == true) {
        print(res['msg']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }
}
