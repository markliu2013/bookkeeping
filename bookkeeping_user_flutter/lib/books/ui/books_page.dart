import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '/routes.dart';
import '/commons/commons.dart';
import '/books/books.dart';
import '/components/components.dart';

class BooksPage extends StatefulWidget {
  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    BlocProvider.of<BooksBloc>(context).add(BooksRefreshed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BooksBloc, BooksState>(
          listenWhen: (previous, current) =>
          previous.loadMoreStatus != current.loadMoreStatus,
          listener: (context, state) {
            if (state.loadMoreStatus == LoadDataStatus.success) {
              _refreshController.loadComplete();
            } else if (state.loadMoreStatus == LoadDataStatus.failure) {
              _refreshController.loadFailed();
            } else if (state.loadMoreStatus == LoadDataStatus.empty) {
              _refreshController.loadNoData();
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('账本'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
              }
            )
          ]
        ),
        body: BlocBuilder<BooksBloc, BooksState>(
          buildWhen: (previous, current) => previous.status != current.status || previous.books != current.books,
          builder: (context, state) {
            switch (state.status) {
              case LoadDataStatus.progress:
              case LoadDataStatus.initial:
                return const PageLoading();
              case LoadDataStatus.success:
                if (state.books.isEmpty) return Empty();
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  child: _buildList(context, state.books),
                  onRefresh: () async {
                    BlocProvider.of<BooksBloc>(context).add(BooksRefreshed());
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    BlocProvider.of<BooksBloc>(context).add(BooksLoadMore());
                  },
                );
              default:
                return PageError(onTap: () {
                  BlocProvider.of<BooksBloc>(context).add(BooksRefreshed());
                });
            }
          }
        ),
      )
    );
  }

  Widget _buildList(BuildContext context, List<Book> books) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: books.length,
      itemBuilder: (context, index) {
        Book book = books[index];
        return ListTile(
          dense: false,
          title: Text(book.name, style: theme.textTheme.bodyText1),
          subtitle: book.notes != null && book.notes!.isNotEmpty ? Text(book.notes!, style: theme.textTheme.caption) : null,
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.pushNamed(context, '/book-detail', arguments: BookDetailArguments(book: book));
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

}