import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_live_tracking/data_layer/auth/auth.dart';
import 'package:geo_live_tracking/config.dart';
import 'package:geo_live_tracking/presentation/signIn/login_in.dart';
import 'package:geo_live_tracking/presentation/widget/singin_field.dart';
import 'package:geo_live_tracking/presentation/signIn/otp_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _phoneController = TextEditingController();
  final Auth _auth = Auth();

  void _sendOTP() async {
    String phone = _phoneController.text.trim();
    if (phone.isNotEmpty) {
      await _auth.signInWithPhone(phone);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationPage(phoneNumber: phone),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid phone number")),
      );
    }
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
                child: SvgPicture.asset("assets/signIn.svg", width: double.infinity, height: 247),
              ),
              Text("Sign In", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  children: [
                    SignInField(text: "User name", icon: Icon(Icons.person_outlined)),
                    SizedBox(height: 20),
                    SignInField(
                      text: "Phone number",
                      keyboardType: TextInputType.phone,
                      icon: Icon(Icons.phone_outlined),
                      controller: _phoneController,
                    ),
                    SizedBox(height: 20),
                    SignInButton(onPressed: _sendOTP),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?", style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 3),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          child: Text("Login", style: TextStyle(color: AppConfig.primaryColor, fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: 58,
          decoration: BoxDecoration(
            color: AppConfig.buttonColor2,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              "Sign In",
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
    );
  }
}
