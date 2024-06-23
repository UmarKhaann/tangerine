import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/utils.dart';

class AuthRepo {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static signUpUser({
    required context,
    required String fullName,
    required String email,
    required String password,
  }) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password);
        Utils.showTopSnackbar(context, 'User created successfully!');
  }

  static logInUser({context, email, password}) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password);
        Utils.snackBarMessage(context, "User Logged In Successfully!");
  }
}
