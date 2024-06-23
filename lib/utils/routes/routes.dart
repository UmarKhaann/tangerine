import 'package:flutter/material.dart';
import 'package:tangerine/screens/auth/login.dart';
import 'package:tangerine/screens/auth/signup.dart';
import 'package:tangerine/utils/routes/routes_name.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.loginView:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RoutesName.signUpView:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
