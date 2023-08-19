import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //------------------------------------------------------------------------------variables
  TextEditingController _emailcontroller = TextEditingController();
  var email = '';
  var _formkey = GlobalKey<FormState>();
  //------------------------------------------------------------------------------variables end
  //------------------------------------------------------------------------------functions start
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password Reset Email Has Been Send',
              style: TextStyle(fontSize: 18.0))));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('No User Found For That Email.',
                style: TextStyle(fontSize: 18.0))));
      }
    }
  }

  ////-----------------------------------------------------------------------------functions stop
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
                    child: Column(
                      children: [
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
                            controller: _emailcontroller,
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
                                print('email' + _emailcontroller.text);

                                if (_formkey.currentState!.validate())
                                  setState(() {
                                    email = _emailcontroller.text;
                                  });
                                resetPassword();
                              },
                              child: Text(
                                'SEND E-MAIL',
                                style: TextStyle(color: Colors.white),
                              )),
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
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('GO BACK',
                                    style: TextStyle(color: Colors.white))))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
