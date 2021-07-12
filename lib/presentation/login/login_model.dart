import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier {
  String email = '';
  String pass = '';

  Future<void> login() async {
    if (email.isEmpty) {
      throw ('メールアドレスを入力して下さい。');
    }
    if (pass.isEmpty) {
      throw ('パスワードを入力して下さい。');
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('メールアドレスまたはパスワードが異なります。');
      } else if (e.code == 'wrong-password') {
        throw ('メールアドレスまたはパスワードが異なります。');
      }
    } catch (e) {
      throw ('ログインに失敗しました。');
    }
  }
}
