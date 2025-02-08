// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auth/components/error_dialog.dart';
import 'package:auth/components/my_textfield.dart';
import 'package:auth/components/my_button.dart';
import 'package:auth/components/square_tile.dart';
import 'package:auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  final Function()? onTap;
  const Loginpage({
    super.key,
    required this.onTap,
  });

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in function
  void signUserIn() async{ 

    // show loading circle
    showDialog(
      context: context, 
      builder: (context){
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in 
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(errorCode: e.code),
      );
    } catch (e) {
      // Handle other errors
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(errorCode: 'unknown'),
      );
    }  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
              
                  const SizedBox(height: 50,),
              
                  //welcome back, you've been missed
                  Text(
                    "Welcome back, you've been missed!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
              
                  const SizedBox(height: 25,),
              
                  //email textfield
                  MytextField(
                    controller: emailController,
                    hintText: 'Enter your email',
                    obsecureText: false,
                  ),
              
                  const SizedBox(height: 10,),
              
                  //password textfield
                  MytextField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    obsecureText: true,
                  ),
              
                  const SizedBox(height: 10,),
              
                  //forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
              
                  const SizedBox(height: 25,),
                  
                  //sign in button
                  MyButton(
                    title: 'Sign In',
                    onTap: signUserIn,
                  ),
              
                  const SizedBox(height: 50,),
              
                  //or continue with)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                        ),
                    
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("Or continue with",
                          style: TextStyle(color: Colors.grey[700]) ,
                          ),
                        ),
                        
                        Expanded(
                          child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                        ),
                      ],
                    ),
                  ),
              
                  const SizedBox(height: 50),
              
                  //google + apple sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        imagePath: 'lib/images/google.png',
                        onTap: () => AuthService().signInWithGoogle(),
                      ),
              
                      const SizedBox(width: 20),
              
                      SquareTile(
                        imagePath: 'lib/images/apple.png',
                        onTap: (){},
                      ),
                    ],
                  ),
              
                  SizedBox(height: 50,),
              
                //not a member? register Now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
              
                    const SizedBox(width: 4,),
              
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                          ),
                      ),
                    ),
                  ],
                ),
              
                ],
              ),
            ),
          ),
        ),
    );
  }
}