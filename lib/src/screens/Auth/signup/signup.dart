import 'package:flutter/material.dart';
import 'package:falih/src/screens/Auth/widgets_auth/text_form_field.dart';
import 'package:falih/src/screens/Auth/widgets_auth/custom_rich_text.dart';
import 'package:falih/src/config/images.dart';
import 'package:falih/src/screens/Auth/widgets_auth/gradient_text.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isChecked = false;
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
                    child: const Text("Create Account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                  ),
                  // Text Fields
                  const CustomTextForm(
                    hintText: '+967',
                    prefixIcon: Icon(Icons.phone_android),
                  ),
                  const CustomTextForm(
                    hintText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  const CustomTextForm(
                    hintText: 'Governorate',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  const CustomTextForm(
                    hintText: 'Shool Name',
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  const CustomTextForm(
                    hintText: 'Grade',
                    prefixIcon: Icon(Icons.gas_meter_rounded),
                  ),
                  const CustomTextForm(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  const CustomTextForm(
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          }),
                      CustomRichText(),
                    ],
                  ),
                  MaterialButton(
                    color: Color.fromARGB(255, 255, 255, 255),
                    height: 50,
                    minWidth: 300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    textColor: Colors.black,
                    onPressed: () {},
                    child: Text(
                      'Create Account',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF9A9393)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have an account? ',
                        style: TextStyle(
                            // fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                      GradientText(
                        text: ' Login instead',
                      )
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
