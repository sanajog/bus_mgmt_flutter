import 'package:bus_management/constants/button.dart';
import 'package:bus_management/constants/snackbar.dart';
import 'package:bus_management/features/auth/service/service.dart';
import 'package:bus_management/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInViewState();
}

final _gap = SizedBox(
  height: 15,
);

bool obscureText = true;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final Service _Service = Service();
final _key = GlobalKey<FormState>();

void _login(BuildContext context) async {
  if (_key.currentState!.validate()) {
    try {
      final result = await _Service.login(
          _emailController.text.trim(), _passwordController.text.trim());
      print('Login Successfully ${result}');
      EasyLoading.show(
          status: 'Please Wait...', maskType: EasyLoadingMaskType.black);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, AppRoute.homeRoute);
        EasyLoading.showSuccess(
          'Loggedin in',
        );
        EasyLoading.dismiss();
      });
    } catch (e) {
      if (e is Exception) {
        showSnackBar(
            color: Colors.red,
            message: e.toString().replaceFirst('Exception: ', ''),
            context: context);
      } else {
        showSnackBar(message: 'An unexpected error occurred', context: context);
      }
    }
  }
}

class _SignInViewState extends ConsumerState<SignInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' SignIn',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 130,
                    child: Image.asset(
                      'assets/busregister.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please fill this form to Signup',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      _gap,
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter Email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      _gap,
                      TextFormField(
                        controller: _passwordController,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: obscureText == true
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            border: OutlineInputBorder(),
                            labelText: 'Password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter password';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                _gap,
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                          text: 'SignIn',
                          onPressed: () {
                            _login(context);
                          })),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.signupviewRoute);
                  },
                  child: Text(
                    "Don't have an account?  Signup",
                    style: TextStyle(color: Colors.black),
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
