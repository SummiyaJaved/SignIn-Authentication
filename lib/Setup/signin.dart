import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herbs_app/screens/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;

  //create a global key have a form state
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Form(
        //implement key
        key: _formkey,
        child: Column(
          children: [
            //Implement fields
            //for email
            TextFormField(
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please type an  email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),

            //For Password
            TextFormField(
              validator: (input) {
                if (input.length < 6) {
                  return 'Your Password needs to be atleast 6 characters password';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            MaterialButton(
              onPressed: signIn,
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
         var user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
        // Navigate to home

      } catch (e) {
        print(e.message);
      }
      // Login to firebase

    }
  }
}
