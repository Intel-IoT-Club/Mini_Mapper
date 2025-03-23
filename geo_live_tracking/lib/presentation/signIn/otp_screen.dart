import 'package:flutter/material.dart';
import 'package:geo_live_tracking/data_layer/auth/auth.dart';
import 'package:geo_live_tracking/presentation/home/home.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  final Auth _auth = Auth();

  void _verifyOTP() async {
    String otp = _otpController.text.trim();
    if (otp.isNotEmpty) {
      bool isSuccess = await _auth.verifyOTP(otp);
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful!")));
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid OTP")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter OTP first")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Enter OTP sent to ${widget.phoneNumber}"),
            SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "OTP",
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
