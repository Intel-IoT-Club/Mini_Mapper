import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final Auth _instance = Auth._internal();
  factory Auth() => _instance;
  Auth._internal();

  String? _verificationId; // Store it privately

  /// Send OTP to the given phone number
  Future<void> signInWithPhone(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await auth.signInWithCredential(credential);
          print("User signed in automatically");
        } catch (e) {
          print("Auto sign-in failed: $e");
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.message}");
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId; // Store verification ID
        print("OTP Sent! Verification ID stored.");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId; // Still store it for later
        print("Timeout! Try again.");
      },
    );
  }

  /// Verify the OTP manually using the verificationId
  Future<bool> verifyOTP(String smsCode) async {
    if (_verificationId == null) {
      print("Error: No verification ID found!");
      return false;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
      UserCredential userCredential = await auth.signInWithCredential(credential);
      print("User signed in: ${userCredential.user?.uid}");
      return true;
    } catch (e) {
      print("Error verifying OTP: $e");
      return false;
    }
  }
}
