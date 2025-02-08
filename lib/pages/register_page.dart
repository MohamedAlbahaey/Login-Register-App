import 'package:auth/components/error_dialog.dart';
import 'package:auth/components/my_textfield.dart';
import 'package:auth/components/my_button.dart';
import 'package:auth/components/square_tile.dart';
import 'package:auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({
    super.key, 
    required this.onTap
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void registerUser() async{ 

    // show loading circle
    showDialog(
      context: context, 
      builder: (context){
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try register
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: confirmPasswordController.text == passwordController.text ? passwordController.text : throw FirebaseAuthException(code: 'passwords-not-matching')
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
                    size: 80,
                  ),
              
                  const SizedBox(height: 40),
              
                  //welcome back, you've been missed
                  Text(
                    "Let's create an account for you!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
              
                  const SizedBox(height: 25,),
              
                  // email textfield
                  MytextField(
                    controller: emailController,
                    hintText: 'Email',
                    obsecureText: false,
                  ),
              
                  const SizedBox(height: 10,),
              
                  // password textfield
                  MytextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obsecureText: true,
                  ),
              
                  const SizedBox(height: 10,),

                  // confirm password textfield
                  MytextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm password',
                    obsecureText: true,
                  ),
              
                  const SizedBox(height: 25,),
                  
                  //sign up button
                  MyButton( 
                    title: 'Sign Up',
                    onTap: registerUser,
                  ),
              
                  const SizedBox(height: 50,),
              
                  // Or continue with
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
              
                  //google + apple register
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
              
                  // Already have an account? Login Now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                
                      const SizedBox(width: 4,),
                
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login Now',
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