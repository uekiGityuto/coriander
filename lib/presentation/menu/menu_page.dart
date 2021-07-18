import 'package:coriander/presentation/main/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'menu_model.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuModel>(
      create: (_) => MenuModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('メニュー'),
        ),
        body: Consumer<MenuModel>(
          builder: (context, model, child) {
            return ListView(children: [
              Ink(
                child: ListTile(
                  title: Text('ログアウト'),
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    await model.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  },
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
