import 'package:falih/src/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_button.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';
import 'package:falih/src/config/images.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Form(
        // Container for background image
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: const AssetImage(
                    Images.backgroundImageOfAuth,
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                      BlendMode.lighten))),
          padding: const EdgeInsets.all(20),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Container(
                    child: Image.asset(
                      Images.logoFalih,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 130),
                    child: const Text("Welcome Back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Text Field
                  const CustomTextForm(
                    hintText: '+967',
                    prefixIcon: Icon(Icons.phone_android),
                  ),
                  // Text Field
                  const CustomTextForm(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  // Forget password
                  Container(
                    margin: const EdgeInsets.only(right: 190),
                    child: const InkWell(
                        child: Text('Forget Passwrod',
                            style: TextStyle(
                                color: AppColors.shadowColor,
                                fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // Login Button
                  const GradientButton(
                    text: 'Login',
                    height: 50,
                    width: 150,
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not registerd yet? ',
                        style: TextStyle(
                            // fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                      GradientText(text: ' Create an Account', route: 'signup')
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
