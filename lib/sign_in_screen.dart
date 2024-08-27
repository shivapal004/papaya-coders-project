import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:papaya_coders_project/api_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();
  String? token;

   Future<void> login() async{
     token = await apiService.login(emailController.text, passwordController.text);
     if(token != null){
       getData();
     }
     else{
       log("Login Failed!");
     }
   }

   Future<void> getData() async{
     if(token == null){
       return;
     }
     final data = await apiService.getData(token!);
     if(data != null){
       log(jsonEncode(data));
     }
     else{
       log("Failed to fetch data");
     }
   }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
      
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's Sign in",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28
                    ),
                  ),
                ),
      
                const SizedBox(height: 10,),
      
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Welcome Back \nYou've been missed!",
                    style: TextStyle(
                      fontSize: 20
                    )
                  ),
                ),
      
                const SizedBox(height: 15,),
      
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    suffixIcon: const Icon(Icons.phone)
                  ),
                ),
      
                const SizedBox(height: 20,),
      
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      suffixIcon: const Icon(Icons.lock)
                  ),
                ),
      
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: (){},
                    child: const Text("Resend OTP!"),
                    ),
                  ),
      
                const SizedBox(height: 20,),
      
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      )
                    ),
                      onPressed: (){
                        login();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Sign in", style: TextStyle(fontSize: 16),),
                          const SizedBox(width: 8,),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: const Icon(Icons.arrow_forward_ios, size: 10,),),
                        ],
                      )
                  ),
                ),
      
                const SizedBox(height: 20,),
      
                const Text("By logging in, you agree to our"),
      
                RichText(
                  text: const TextSpan(
                    text: 'Terms & Conditions ',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '& ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
      
              ]
            ),
          )
      ),
    );
  }
}
