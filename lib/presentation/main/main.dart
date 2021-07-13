import 'package:coriander/presentation/book_list/book_list_page.dart';
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
              child: Column(
                children: [
                  Text(
                    model.kboyText,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  ElevatedButton(
                      child: Text('サインアップ'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      }),
                  ElevatedButton(
                      child: Text('ログイン'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }),
                  // TODO: 完成したら消す
                  ElevatedButton(
                      child: Text('本一覧'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookListPage()),
                        );
                      })
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
