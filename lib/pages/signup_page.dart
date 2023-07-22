import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewegoo/pages/signin_page.dart';



import '../service/auth_service.dart';
import 'main_page.dart';


class SignUpPage extends StatefulWidget {
  static const String id='signup_page';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading=false;
  var fullNameController = TextEditingController () ;
  var emailController = TextEditingController () ;
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();
  void _callSignIpPage(){
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }
  void _doSignUp() {
    String fullname = fullNameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();

    if (fullname.isEmpty || email.isEmpty || password.isEmpty) return;
    if (cpassword != password) {

      return;
    }
    setState(() {
      isLoading=true;
    });
    AuthService.signUpUser( email, password).then((value) => {
      responseSignUp(value!),

    });
  }
  void responseSignUp(User firebaseUser){
    setState(() {
      isLoading=false;
    });
    Navigator.pushReplacementNamed(context, MainPage.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //fullName
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child:  TextField(
                      controller: fullNameController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "FullName",

                        hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  //email
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
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
                      color: Colors.white54.withOpacity(0.2),
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
                  //password
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child:  TextField(
                      obscureText: true,
                      controller: cpasswordController,
                      style: TextStyle(color: Colors.black),

                      decoration: InputDecoration(

                        hintText: "Confirm Password",

                        hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),

                  //signIn
                  GestureDetector(
                    onTap: _doSignUp,
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
                      const Text("Already have an account?!",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: _callSignIpPage,
                        child: const Text(
                          "Sign In",
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

              isLoading ? Center(child: CircularProgressIndicator(),):
              SizedBox.shrink()
            ],
          )
      ),
    );
  }
}
