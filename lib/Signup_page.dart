import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/LoginPage.dart';

class Signup_page extends StatefulWidget {
  const Signup_page({super.key});

  @override
  State<Signup_page> createState() => _Signup_pageState();
}

class _Signup_pageState extends State<Signup_page> {
  //----------------------------------------------------------------------------variables
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();
  bool _securedText = true;
  bool _securedText1 = true;
  var name = '';
  var password = '';
  var confirmPassword = '';
  var _formkey = GlobalKey<FormState>();
  //----------------------------------------------------------------------------variables end
  //----------------------------------------------------------------------------functions start
  registration() async {
    if (password == confirmPassword) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: name, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Registration successful',
                style: TextStyle(fontSize: 18.0))));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('Password Is Too Weak');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Password Is Too Weak',
                  style: TextStyle(fontSize: 18.0))));
        } else if (e.code == 'email-already-in-use') {
          print('Email Already Exists');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Email Already Exists',
                  style: TextStyle(fontSize: 18.0))));
        }
      }
    } else {
      print("Password Confirm doesn't match");
    }
  }

  //----------------------------------------------------------------------------functions stop
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
                            'Please Signup First',
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
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          width: 350,
                          child: TextFormField(
                            controller: _confirmpasswordcontroller,
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: Icon(
                                  Icons.security,
                                  color: Colors.deepPurple,
                                ),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _securedText1
                                          ? Icons.remove_red_eye
                                          : Icons.security,
                                      color: Colors.deepPurple,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _securedText1 = !_securedText1;
                                      });
                                    })),
                            obscureText: _securedText1,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Please Enter Password';
                              if (_passwordcontroller.text !=
                                  _confirmpasswordcontroller.text)
                                return 'Password Do Not Match ';
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              onPressed: () {
                                print('name' + _namecontroller.text);
                                print('password = ' + _passwordcontroller.text);
                                if (_formkey.currentState!.validate())
                                  setState(() {
                                    name = _namecontroller.text;
                                    password = _passwordcontroller.text;
                                    confirmPassword =
                                        _confirmpasswordcontroller.text;
                                  });
                                registration();
                              },
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'GO BACK',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
