import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;

  const RegisterPage({
    super.key,
    this.togglePages,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // ! text controllers
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();
  final nameController = TextEditingController();

  // ! register button pressed
  void register() {
    // prepare info
    final String name = nameController.text;
    final String email = emailController.text;
    final String pw = pwController.text;
    final String confirmPw = confirmPwController.text;

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    // ensure fields aren't empty
    if (email.isNotEmpty &&
        name.isNotEmpty &&
        pw.isNotEmpty &&
        confirmPw.isNotEmpty) {
      // ensure passwords match
      if (pw == confirmPw) {
        // register user
        authCubit.register(name, email, pw);
      } else {
        // show error - passwords don't match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Passwords don't match",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    // fields are empty
    else {
      // show error - fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 40),

              // ! logo
              Icon(
                Icons.lock_open,
                size: 80,
                color: Colors.orange,
              ),

              SizedBox(height: 10),

              // ! name of app
              Text(
                "Let's create an account for you",
                style: GoogleFonts.bebasNeue(
                  fontSize: 20,
                  color: Colors.orange,
                ),
              ),

              SizedBox(height: 20),

              // ! name textfield
              MyTextField(
                hintText: 'Name',
                controller: nameController,
                obscureText: false,
              ),

              SizedBox(height: 10),

              // ! email textfield
              MyTextField(
                hintText: 'Email',
                controller: emailController,
                obscureText: false,
              ),

              SizedBox(height: 10),

              // ! password textfield
              MyTextField(
                hintText: 'Password',
                controller: pwController,
                obscureText: true,
              ),

              SizedBox(height: 10),

              // ! confirm password textfield
              MyTextField(
                hintText: 'Confirm password',
                controller: confirmPwController,
                obscureText: true,
              ),

              SizedBox(height: 20),

              // ! Sign up button
              MyButton(
                onTap: register,
                text: 'Sign up',
              ),

              SizedBox(height: 25),

              // ! already have an account? login now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                  InkWell(
                    onTap: widget.togglePages,
                    child: Text(
                      'Login now',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
