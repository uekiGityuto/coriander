import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignupModel extends ChangeNotifier {
  String email = '';
  String pass = '';

  Future<void> signup() async {
    if (email.isEmpty) {
      throw ('メールアドレスを入力して下さい。');
    }
    if (pass.isEmpty) {
      throw ('パスワードを入力して下さい。');
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);

      User user = userCredential.user;
      CollectionReference collection =
          FirebaseFirestore.instance.collection('users');
      await collection.add({
        'uid': user.uid,
        'email': user.email,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('パスワードが弱いです。');
      } else if (e.code == 'email-already-in-use') {
        throw ('メールアドレスが既に登録されています。');
      }
    } catch (e) {
      throw ('登録に失敗しました。');
    }
  }
}
