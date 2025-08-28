import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/apple_sign_in_button.dart';
import '../components/google_sign_in_button.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;

  const LoginPage({
    this.togglePages,
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  // auth cubit
  late final authCubit = context.read<AuthCubit>();

  // login button pressed
  void login() {
    // prepare email & pw
    final String email = emailController.text;
    final String pw = pwController.text;

    // ensure that the fields are filled
    if (email.isNotEmpty && pw.isNotEmpty) {
      // login
      authCubit.login(email, pw);
    }

    // fields are empty
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  // forgot password box
  void openForgotPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Forgot Password',
            style: GoogleFonts.bebasNeue(
              color: Colors.orange,
            ),
          ),
          content: MyTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
          ),
          actions: [
            // cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Cancel'),
            ),

            // reset button
            ElevatedButton(
              onPressed: () async {
                String message = await authCubit.forgotPassword(
                  emailController.text,
                );
                if (message == 'Password reset email sent! Check your inbox') {
                  Navigator.pop(context);
                  emailController.clear();
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter an email'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_open,
                  size: 80,
                  color: Colors.orange,
                ),
                SizedBox(height: 10),
                Text(
                  'Coffee App',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 70),
                MyTextField(
                  hintText: 'Email',
                  controller: emailController,
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  hintText: 'Password',
                  controller: pwController,
                  obscureText: true,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: openForgotPassword,
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MyButton(
                  onTap: login,
                  text: 'Login',
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.orange)),
                    Text(
                      '  Or sign in with  ',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.orange)),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyAppleSignInButton(
                      onTap: () => authCubit.signInWithApple(),
                    ),
                    SizedBox(width: 10),
                    GoogleSignInButton(
                      onTap: () => authCubit.signInWithGoogle(),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.orange),
                    ),
                    InkWell(
                      onTap: widget.togglePages,
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
