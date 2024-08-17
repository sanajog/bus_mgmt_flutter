import 'package:bus_management/constants/button.dart';
import 'package:bus_management/constants/snackbar.dart';
import 'package:bus_management/features/auth/service/service.dart';
import 'package:bus_management/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupViewState();
}

final _gap = SizedBox(
  height: 15,
);

bool obscureText = true;

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneNumController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final Service _Service = Service();
final _key = GlobalKey<FormState>();

void _register(BuildContext context) async {
  if (_key.currentState!.validate()) {
    try {
      var response = await _Service.register(
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          phoneNumController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim());
      print('Registration successful: $response');
      EasyLoading.show(
          status: 'Please Wait...', maskType: EasyLoadingMaskType.black);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, AppRoute.signinRoute);
        EasyLoading.showSuccess(
          'Registered Successfully ',
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

class _SignupViewState extends ConsumerState<SignupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' SignUp',
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
                    radius: 110,
                    child: Image.asset(
                      'assets/busregister.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        controller: firstNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'FirstName'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter Fullname';
                          } else {
                            return null;
                          }
                        },
                      ),
                      _gap,
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'LastName'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter LastName';
                          } else {
                            return null;
                          }
                        },
                      ),
                      _gap,
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter Email';
                          } else if (!value.contains('@')) {
                            return 'please enter valid email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      _gap,
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: obscureText == true
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            labelText: 'Password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter Password';
                          } else {
                            return null;
                          }
                        },
                      ),
                      _gap,
                      TextFormField(
                        controller: phoneNumController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phonenumber'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter PhoneNumber';
                          } else if (value.length < 10) {
                            return 'please enter valid number';
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
                          text: 'Signup',
                          onPressed: () {
                            _register(context);
                          })),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.signinRoute);
                  },
                  child: Text(
                    'Already have an account?  Login',
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
