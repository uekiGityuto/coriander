import 'package:coriander/presentation/book_list/book_list_page.dart';
import 'package:coriander/presentation/confirm/confirm_page.dart';
import 'package:coriander/presentation/login/login_page.dart';
import 'package:coriander/presentation/signup/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('コリアンダー'),
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 330,
                      child: ElevatedButton(
                          child: Text('メールアドレスで登録'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()),
                            );
                          }),
                    ),
                    SizedBox(
                      width: 330,
                      child: ElevatedButton(
                          child: Text('Googleで登録'),
                          onPressed: () async {
                            await model.signInWithGoogle();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookListPage()),
                            );
                          }),
                    ),
                    new Divider(color: Colors.black),
                    SizedBox(
                      width: 330,
                      child: ElevatedButton(
                        child: Text('メールアドレスでログイン'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen, //ボタンの背景色
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 330,
                      child: ElevatedButton(
                        child: Text('Googleでログイン'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen, //ボタンの背景色
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
