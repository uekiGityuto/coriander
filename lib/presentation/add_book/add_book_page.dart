import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coriander/domain/Book.dart';
import 'add_book_model.dart';

class AddBookPage extends StatelessWidget {
  final textEditingController = TextEditingController();
  Book book;
  final bool _isUpdate;

  AddBookPage({this.book}) : this._isUpdate = book != null;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
        create: (_) => AddBookModel(),
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text(_isUpdate ? '本を編集' : '本を追加'),
              ),
              body: Consumer<AddBookModel>(
                builder: (context, model, child) {
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8.0, right: 8.0, bottom: 0.0),
                      child: SizedBox(
                        width: 200.0,
                        height: 200.0,
                        child: InkWell(
                            child: model.imageFile == null
                                ? Container(
                                    color: Colors.grey,
                                  )
                                : Image.file(model.imageFile),
                            onTap: () async {
                              await model.showImagePicker();
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8.0, right: 8.0, bottom: 0.0),
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
                            model.startLoading();
                            await _addBook(model, context);
                          }
                        })
                  ]);
                },
              ),
            ),
            Consumer<AddBookModel>(builder: (context, model, child) {
              return model.isLoading
                  ? Container(
                      color: Colors.grey.withOpacity(0.4),
                      child: Center(child: CircularProgressIndicator()))
                  : Container();
            }),
          ],
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
