import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; // Needed for PlatformException
import 'package:shopping_l/forget.dart';
import 'package:shopping_l/homepage.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _rememberMe = false;

  // Control the password visibility
  bool _obscureText = true;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  Future<void> login_with_email_password() async {
    try {
      final user_credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );

      print(user_credential);
      print('User logged in successfully =======-----------------');
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('auth message is ----  ${e.message}');
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/shopping login.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color.fromARGB(77, 0, 0, 0),
                BlendMode.darken,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildTextField(
                    hintText: 'Email',
                    prefixIcon: Icons.email,
                    isPassword: false,
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    hintText: 'Password',
                    prefixIcon: Icons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  _buildRememberForgot(),
                  const SizedBox(height: 32),
                  _buildSignInButton(),
                  const SizedBox(height: 16),
                  _buildGoogleSignInButton(),
                  const SizedBox(height: 40),
                  _buildSignUpPrompt(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Sign in to continue',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData prefixIcon,
    required bool isPassword,
  }) {
    return TextField(

      controller: hintText == 'Email' ? emailcontroller : passwordcontroller,
      // For password, use _obscureText. For email, false.
      obscureText: isPassword ? _obscureText : false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(prefixIcon, color: Colors.white70),
        // Add a suffix icon for password fields to toggle visibility.
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.white70,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
        filled: true,
        fillColor: const Color.fromARGB(26, 255, 255, 255),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 1),
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
              fillColor: WidgetStateProperty.all(Colors.white),
            ),
            const Text('Remember me',
                style: TextStyle(color: Colors.white)),
          ],
        ),
        TextButton(
          onPressed: () => Get.to(const Forgot()),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
          child: const Text(
            'Forgot Password?',
            style: TextStyle(decoration: TextDecoration.none),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return Container(
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
          backgroundColor:
          Colors.transparent, // Transparent background.
          shadowColor: Colors.transparent, // No shadow.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => login_with_email_password(),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SIGN IN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: TextButton(
        onPressed: () {
          // Implement Google sign-in action here.
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/google_logo.png',
              width: 24.0,
              height: 24.0,
            ),
            const SizedBox(width: 10),
            const Text(
              'Sign in with Google',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpPrompt() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(width: 4),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'register');
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shopping_l/homepage.dart';
// import 'package:shopping_l/register.dart';
//
// class MyLogin extends StatefulWidget {
//   const MyLogin({super.key});
//
//   @override
//   State<MyLogin> createState() => _MyLoginState();
// }
//
// class _MyLoginState extends State<MyLogin> {
//   final emailcontroller = TextEditingController();
//   final passwordcontroller = TextEditingController();
//   final formkey = GlobalKey<FormState>();
//
//   @override
//   void dispose() {
//     emailcontroller.dispose();
//     passwordcontroller.dispose();
//     super.dispose();
//   }
//
//   Future<void> login_with_email_password() async {
//     try {
//       final user_credential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//         email: emailcontroller.text.trim(),
//         password: passwordcontroller.text.trim(),
//       );
//
//       print(user_credential);
//       print('User logged in successfully =======-----------------');
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//         } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       } else {
//         print('auth message is ----  ${e.message}');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Sign in')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: emailcontroller,
//
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               controller: passwordcontroller,
//               decoration: const InputDecoration(
//                 hintText: 'Password',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () async {
//                 // if (formkey.currentState!.validate())
//
//                 await login_with_email_password();
//               },
//               child: const Text('Sign in'),
//             ),
//             const SizedBox(height: 10),
//
//             TextButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => MyRegister()),
//                 );
//               },
//               child: Text('Sign up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }