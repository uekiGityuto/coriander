import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coriander/domain/Book.dart';
import 'add_book_model.dart';

class AddBookPage extends StatelessWidget {
  final textEditingController = TextEditingController();
  Book book;
  bool _isUpdate;

  AddBookPage({this.book}) {
    _isUpdate = this.book != null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
        create: (_) => AddBookModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(_isUpdate ? '本を編集' : '本を追加'),
          ),
          body: Consumer<AddBookModel>(
            builder: (context, model, child) {
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: textEditingController..text = book?.title,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), hintText: '本のタイトル'),
                    onChanged: (text) {
                      model.title = text;
                    },
                  ),
                ),
                ElevatedButton(
                    child: Text(_isUpdate ? '本を編集する' : '本を追加する'),
                    onPressed: () async {
                      if (_isUpdate) {
                        // 本を編集する
                        await _updateBook(model, context);
                      } else {
                        // 本を追加する
                        await _addBook(model, context);
                      }
                    })
              ]);
            },
          ),
        ));
  }

  Future _addBook(AddBookModel model, BuildContext context) async {
    try {
      await model.addBook();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('追加しました。'),
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
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(e.toString()),
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

  Future _updateBook(AddBookModel model, BuildContext context) async {
    await model.updateBook(book);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('更新しました。'),
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
    Navigator.of(context).pop();
  }
}
