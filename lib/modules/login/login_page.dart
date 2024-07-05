import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/modules/home/home_page.dart';
import 'package:flutter_weather/widgets/custom_form_field.dart';
import 'package:flutter_weather/widgets/full_width_button.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  static const String route = '/login';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),
            Form(
              // key: controller.formKey,
              child: Column(
                children: [
                  const CustomFormField(
                    hintText: 'your email',
                    type: FormFieldType.email,
                  ),
                  const SizedBox(height: 20),
                  const CustomFormField(
                    hintText: 'your password',
                    isShowPassword: false,
                    type: FormFieldType.password,
                  ),
                  const SizedBox(height: 20),
                  FullWidthButton(
                    onPressed: () {
                      Get.offNamed(HomePage.route);
                    },
                    label: 'Login',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                text: 'Don\'t have an account? ',
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Get.toNamed(RegisterPage.route);
                      },
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    text: 'Register Here',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
