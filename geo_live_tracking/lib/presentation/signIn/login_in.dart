import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_live_tracking/config.dart';
import 'package:geo_live_tracking/presentation/widget/singin_field.dart';

class LoginPage extends StatelessWidget {
   const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 50),
                child: SvgPicture.asset("assets/login.svg", width: double.infinity, height: 247),
              ),
            
              Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                child: Column(
                  children: [
                 
                   SignInField(text: "Phone number",icon: Icon(Icons.phone_outlined),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: Container(
                        width: double.infinity,
                        height: 58,
                        decoration: BoxDecoration(
                          color: AppConfig.buttonColor2,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Jost',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Doesn't have a accoutnt?",style: TextStyle(color: Colors.grey),),
                        SizedBox(width: 3,),
                      InkWell(
                          onTap: (){
                           Navigator.of(context).pop();
                            },
                          child: Text("Sing Up",style: TextStyle(color: AppConfig.primaryColor,fontWeight: FontWeight.w500)))
                      ],
                    )
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
