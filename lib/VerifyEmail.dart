// ignore: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Needed for SystemUiOverlayStyle
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopping_l/register.dart';
import 'package:shopping_l/wrapper.dart';
// Make sure to create and import MyRegister

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    sendVerifyLink();

    // Periodically check the verification status every 3 seconds.
    timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      await FirebaseAuth.instance.currentUser!.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        timer?.cancel(); // Stop the timer once verified.
        Get.offAll(const Wrapper()); // Navigate to the home screen.
      }
    });
  }

  // Sends the email verification link.
  sendVerifyLink() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification().then((value) {
      Get.snackbar(
        "Email sent",
        "Please verify your email",
        margin: const EdgeInsets.all(30),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when closing the widget.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extend background behind the AppBar including system status bar.
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Optionally, you can remove the leading back icon if you are using the custom button below.
        // If you still want an app bar with a back arrow, note that sometimes this page might not have any back route.
        title: const Text(
          'Verification',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Ensure the system status bar is transparent.
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
        ),
      ),
      // Use SizedBox.expand so that the background image covers the entire screen.
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/shopping login.png'),
              // Ensure your asset is correctly declared in pubspec.yaml.
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Open your mail and click on the link provided to verify your email.\n\nOnce verified, you will be automatically signed in!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    // Adjust for contrast based on your background image.
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                // This button allows the user to return to the registration page.

                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Navigate to the registration page in case the user entered the wrong email.
                      Get.offAll(const MyRegister());
                    },
                    child: const Text(
                      'Wrong Email or Password ? Go Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
