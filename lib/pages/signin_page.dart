import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewegoo/pages/signup_page.dart';


import '../service/auth_service.dart';
import 'main_page.dart';


class SignInPage extends StatefulWidget {
  static const String id = "signin_page";

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  var isLoading= false;
  var emailController = TextEditingController () ;
  var passwordController = TextEditingController();

  void _callSignUpPage() {
    Navigator.pushReplacementNamed(context, SignUpPage.id);
  }
  void _doSignIn(){
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;
    setState(() {
      isLoading= true;
    });
    AuthService. signInUser (email, password).then((value) => {
      responseSignIn (value!),});

  }
  void responseSignIn (User firebaseUser){
    setState(() {
      isLoading=false;
    });
    Navigator.pushReplacementNamed(context, MainPage.id);}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(20),

          color: Colors.white,

          alignment: Alignment.center,
          child:Center(child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //email
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(7),
                    ),
                    child:  TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Email",

                        hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  //password
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(7),
                    ),
                    child:  TextField(
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Password",

                        hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  //signIn
                  GestureDetector(
                    onTap: _doSignIn,
                    child:Container(
                        height: 50,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(child: Text('SignIn',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),)
                    ), ),

                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Dont have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: _callSignUpPage,
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),


                ],
              ),
              isLoading ? Center(
                child: CircularProgressIndicator(),
              ):
              SizedBox.shrink()
            ],
          ),)
      ),
    );
  }
}