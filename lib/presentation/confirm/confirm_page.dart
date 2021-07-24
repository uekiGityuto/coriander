import 'package:coriander/presentation/book_list/book_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'confirm_model.dart';

class ConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfirmModel>(
        create: (_) => ConfirmModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('確認'),
          ),
          body: Consumer<ConfirmModel>(
            builder: (context, model, child) {
              return Center(
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('確認メールを送信しましたので、\n'
                          'メール内のリンクを押下して認証して下さい。\n'
                          '認証後に「次へ」ボタンを押下して下さい。')),
                  SizedBox(
                    width: 330,
                    child: ElevatedButton(
                        child: Text('次へ'),
                        onPressed: () {
                          if (model.confirm()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookListPage()),
                            );
                          }
                        }),
                  )
                ]),
              );
            },
          ),
        ));
  }
}
