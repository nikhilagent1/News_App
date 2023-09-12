import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/ForgotPassword.dart';
import 'package:news_app/NewsApp.dart';
import 'package:news_app/Signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //-----------------------------------------------------------------------------variables start
  bool _securedText = true;
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  var name = '';
  var password = '';
  var _formkey = GlobalKey<FormState>();
  //------------------------------------------------------------------------------variables end
  //------------------------------------------------------------------------------functions
  userlogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: name, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewsApp(),
        ),
      );
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        print('No User Found For That Email');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('No User Found For That Email',
                style: TextStyle(fontSize: 18.0))));
      } else if (e.code == 'wrong-password') {
        print('Wrong Password Entered By User');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Wrong Password Entered By User',
                style: TextStyle(fontSize: 18.0))));
      }
    }
  }

//-------------------------------------------------------------------------------------------google signin
  googleLogin() async {
    // print("google Login method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var result = await _googleSignIn.signIn();
      if (result == null) {
        return;
      }
      // print("Navigator.pushReplacement");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewsApp(),
        ),
      );
      // print("Executing Else part");
      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: userData.accessToken,
        idToken: userData.idToken,
      );
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // print("Result $result");
      // print(result!.displayName);
      // print(result.email);
      // print(result.photoUrl);
    } catch (error) {
      print(error);
    }
  }
  //------------------------------------------------------------------------------function end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.yellow[
                300], /*border: Border.all(color:Colors.amberAccent,width: 2.0,style:BorderStyle.solid))*/
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: 480,
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.amber[400],
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                        color: Colors.greenAccent,
                        width: 2.0,
                        style: BorderStyle.solid)),
                child: Form(
                    key: _formkey,
                    child: Column(children: [
                      Center(
                        child: Text(
                          'Hello!!',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 35.0,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          'Please Login To Your Account',
                          style: TextStyle(
                              color: Colors.green[400],
                              fontSize: 18.0,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 350,
                        child: TextFormField(
                          controller: _namecontroller,
                          decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: TextStyle(fontSize: 15),
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.deepPurple,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please Enter E-mail Address';
                            if (!RegExp(r'\w+@\w+\.\w+').hasMatch(value))
                              return 'Invalid E-mail Address format';
                            return null;
                          },
                        ),
                      ),
                      Container(
                          width: 350,
                          child: TextFormField(
                            controller: _passwordcontroller,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(fontSize: 15),
                                prefixIcon: Icon(
                                  Icons.security,
                                  color: Colors.deepPurple,
                                ),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _securedText
                                          ? Icons.remove_red_eye
                                          : Icons.security,
                                      color: Colors.deepPurple,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _securedText = !_securedText;
                                      });
                                    })),
                            obscureText: _securedText,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Please Enter Password';
                              if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$')
                                  .hasMatch(value))
                                return '''password atleast 8 characters include one upper case one lower
  case one symbol''';
                              return null;
                            }, //password atleast 8 characters one upper case one lower case one symbol
                          )),
                      SizedBox(height: 10.0),
                      Container(
                          padding: EdgeInsets.only(left: 200),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
                            },
                            child: Text('Forgot Password',
                                style: TextStyle(
                                    color: Colors.deepPurple, fontSize: 15)),
                          )),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                            onPressed: () {
                              print('name' + _namecontroller.text);
                              print('password' + _passwordcontroller.text);
                              if (_formkey.currentState!.validate())
                                setState(() {
                                  name = _namecontroller.text;
                                  name = name.trim();
                                  password = _passwordcontroller.text;
                                });
                              userlogin();
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('New To NEWS APP?',
                                style: TextStyle(
                                  color: Colors.deepPurple[200],
                                  fontSize: 15.0,
                                )),
                            SizedBox(
                              width: 5.0,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup_page()));
                              },
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ]),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Or Sign up with social links',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              print('Google pressed');
                              googleLogin();
                            },
                            icon: ImageIcon(AssetImage('Images/google.png')),
                            iconSize: 50,
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     print('Facebook pressed');
                          //   },
                          //   icon: ImageIcon(AssetImage('Images/facebook.png')),
                          //   iconSize: 50,
                          // ),
                          // IconButton(
                          //   onPressed: () {
                          //     print('Twitter pressed');
                          //   },
                          //   icon: ImageIcon(AssetImage('Images/Twitter.png')),
                          //   iconSize: 50,
                          // ),
                        ],
                      )
                    ])),
              )
            ],
          )),
    )));
  }
}
