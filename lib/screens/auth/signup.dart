import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tangerine/repository/auth_repo.dart';
import 'package:tangerine/res/components/custom_input_field.dart';
import 'package:tangerine/utils/routes/routes_name.dart';
import 'package:tangerine/utils/utils.dart';

import '../../../res/components/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static final ValueNotifier<bool> btnLoading = ValueNotifier<bool>(false);
  static final ValueNotifier<bool> checkBox = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 19, 39),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(flex: 3, child: Container()),
                Card(
                  margin: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: const Color.fromARGB(255, 51, 48, 64),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            child: IconButton(onPressed: (){
                              ImagePicker().pickImage(source: ImageSource.gallery);
                            }, icon: const Icon(Icons.person, size: 50,)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomInputField(
                          hintText: 'Name',
                          controller: _usernameController,
                        ),
                        CustomInputField(
                          hintText: 'Email',
                          controller: _fullNameController,
                        ),
                        CustomInputField(
                            hintText: 'Password',
                            isPasswordField: true,
                            controller: _passwordController),
                        CustomInputField(
                            hintText: 'Confirm Password',
                            isPasswordField: true,
                            controller: _confirmPasswordController),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: checkBox,
                              builder: (context, value, child) {
                                return Checkbox(
                                  value: checkBox.value,
                                  onChanged: (value) {
                                    checkBox.value = value!;
                                  },
                                );
                              },
                            ),
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'I agree to Tangerine ',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 249, 136, 31)),
                                    ),
                                    TextSpan(
                                      text: 'Terms and conditions ',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    TextSpan(
                                      text: 'and ',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 249, 136, 31)),
                                    ),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ValueListenableBuilder(
                              valueListenable: btnLoading,
                              builder: (context, value, child) {
                                return CustomButton(
                                  text: 'Create',
                                  onPressed: () {
                                    if (_passwordController.text !=
                                        _confirmPasswordController.text) {
                                      Utils.showTopSnackbar(
                                          context, 'password do not match');
                                    }

                                    if (_formkey.currentState!.validate() &&
                                        checkBox.value == true) {
                                      btnLoading.value = true;
                                      AuthRepo.signUpUser(
                                        context: context,
                                        fullName: _fullNameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                      btnLoading.value = false;
                                    }
                                  },
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Text(
                        'Already a user?',
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, RoutesName.loginView);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 249, 136, 31)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
