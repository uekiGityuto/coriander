import 'package:coriander/presentation/book_list/book_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';

class LoginPage extends StatelessWidget {
  final mailEditingController = TextEditingController();
  final passEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
        create: (_) => LoginModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('ログイン'),
          ),
          body: Consumer<LoginModel>(
            builder: (context, model, child) {
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: mailEditingController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), hintText: 'メールアドレス'),
                    onChanged: (text) {
                      model.email = text;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passEditingController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), hintText: 'パスワード'),
                    obscureText: true,
                    onChanged: (text) {
                      model.pass = text;
                    },
                  ),
                ),
                ElevatedButton(
                    child: Text('ログイン'),
                    onPressed: () async {
                      try {
                        await model.login();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookListPage()),
                        );
                      } catch (e) {
                        await _showDialog(context, e.toString());
                      }
                    })
              ]);
            },
          ),
        ));
  }

  Future _showDialog(BuildContext context, String msg) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(msg),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2.0))),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
