import 'package:flutter/material.dart';
import 'package:tangerine/repository/auth_repo.dart';
import 'package:tangerine/res/components/custom_button.dart';
import 'package:tangerine/res/components/custom_input_field.dart';
import 'package:tangerine/utils/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static final ValueNotifier<bool> btnLoading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 19, 39),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      CustomInputField(
                        focusNode: _emailFocusNode,
                        hintText: 'Email',
                        controller: _emailController,
                        keyboardInputType: TextInputType.emailAddress,
                      ),
                      CustomInputField(
                          focusNode: _passwordFocusNode,
                          hintText: 'Password',
                          isPasswordField: true,
                          controller: _passwordController),
                      const TextButton(
                        onPressed: null,
                        child: Text(
                          '   forgot password?',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomButton(
                            text: 'Sign In',
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                btnLoading.value = true;
                                AuthRepo.logInUser(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text);
                                btnLoading.value = false;
                              }
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
              const Text(
                "No Tangerine account?",
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RoutesName.signUpView);
                },
                child: const Text(
                  'Create Account',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 249, 136, 31)),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
