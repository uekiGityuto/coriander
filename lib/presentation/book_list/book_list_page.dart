import 'package:coriander/presentation/add_book/add_book_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
        create: (_) => BookListModel()..fetchBooks(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('本一覧'),
          ),
          body: Consumer<BookListModel>(
            builder: (context, model, child) {
              final books = model.books;
              final listTiles = books
                  .map(
                    (book) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        leading: Image.network(book.imageUrl.isEmpty
                            ? 'https://pps-life.com/sp/img/blog/noImage-large.png'
                            : book.imageUrl),
                        title: Text(book.title),
                        trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddBookPage(book: book),
                                  fullscreenDialog: true,
                                ),
                              );
                              model.fetchBooks();
                            }),
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text('削除しますか？'),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2.0))),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () async {
                                      // 削除する
                                      await model.deleteBook(book);
                                      await model.fetchBooks();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                  .toList();
              return ListView(
                children: listTiles,
              );
            },
          ),
          floatingActionButton:
              Consumer<BookListModel>(builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBookPage(),
                    fullscreenDialog: true,
                  ),
                );
                model.fetchBooks();
              },
            );
          }),
        ));
  }
}
