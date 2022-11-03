import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/login/bloc/auth/auth_bloc.dart';
import '/components/components.dart';
import '/commons/commons.dart';
import '/accounts/accounts.dart';
import '/books/books.dart';

class BookDetailPage extends StatefulWidget {

  final Book book;
  BookDetailPage({
    required this.book
  });

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {

  @override
  void initState() {
    BlocProvider.of<BookFetchBloc>(context).add(BookLoadDefault(book: widget.book));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BooksBloc, BooksState>(
          listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              Message.success('操作成功！');
              // Navigator.pop(context);
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              } else {
                SystemNavigator.pop();
              }
            }
          }
        ),
        BlocListener<BooksBloc, BooksState>(
          listenWhen: (previous, current) => previous.defaultStatus != current.defaultStatus,
          listener: (context, state) {
            if (state.defaultStatus == LoadDataStatus.success) {
              Message.success('操作成功！');
            }
          },
        )
      ],
      child: BlocBuilder<BookFetchBloc, BookFetchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('账本详情'),
              actions: _buildActions(context, state.book ?? widget.book)
            ),
            body: Builder(
              builder: (context) {
                switch (state.status) {
                  case LoadDataStatus.progress:
                  case LoadDataStatus.initial:
                    return const PageLoading();
                  case LoadDataStatus.success:
                    return _buildBody(context, state.book ?? widget.book);
                  default:
                    return PageError(onTap: () { BlocProvider.of<AccountFetchBloc>(context).add(AccountFetched()); });
                }
              },
            )
          );
        }
      )
    );
  }

  List<Widget> _buildActions(BuildContext context, Book book) {
    return [
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          //fullDialog(context, AccountFormPage(type: 2, accountType: account.type, account: account));
        }
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          if (await confirm(
            context,
            content: Text("确定删除${book.name}吗？"),
            textOK: Text("确定"),
            textCancel: Text("取消"),
          )) {
            //BlocProvider.of<BooksBloc>(context).add(BookDeleted(book.id.toString()));
          }
        }
      )
    ];
  }

  Widget _buildBody(BuildContext context, Book book) {
    final theme = Theme.of(context);
    TextStyle? style1 = theme.textTheme.bodyText2;
    TextStyle? style2 = theme.textTheme.bodyText1;
    final state = context.watch<AuthBloc>().state;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            OverflowBar(
              overflowAlignment: OverflowBarAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                    child: const Text('设置'),
                    onPressed: () {

                    }
                ),
                ElevatedButton(
                  child: const Text('设为默认'),
                  onPressed: state.session?.defaultBook.id != book.id ? () {
                    BlocProvider.of<BooksBloc>(context).add(BookSetDefault(book));
                  } : null
                )
              ]
            ),
            SizedBox(height: 15),
            Row(children: [Text("账本名称：", style: style1), Text(book.name, style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("所属组：", style: style1), Text(book.group.name, style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否展示描述：", style: style1), Text(boolToString(book.descriptionEnable), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否展示时间：", style: style1), Text(boolToString(book.timeEnable), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否支出图片：", style: style1), Text(boolToString(book.imageEnable), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("默认支出账户：", style: style1), Text(book.defaultExpenseAccount?.name ?? '', style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("默认收入账户：", style: style1), Text(book.defaultIncomeAccount?.name ?? '', style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("默认支出类别：", style: style1), Text(book.defaultExpenseCategory?.name ?? '', style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("默认收入类别：", style: style1), Text(book.defaultIncomeCategory?.name ?? '', style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("默认转出账户：", style: style1), Text(book.defaultTransferFromAccount?.name ?? '', style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("默认转入账户：", style: style1), Text(book.defaultTransferToAccount?.name ?? '', style: style2)]),
          ],
        )
      ),
    );
  }

}