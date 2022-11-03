import 'package:flutter/cupertino.dart';
import '/categories/categories.dart';
import '/flows/flows.dart';
import '/payees/payees.dart';
import '/tags/tags.dart';
import '/accounts/accounts.dart';
import '/login/login.dart';
import '/books/books.dart';
import '/charts/charts.dart';
import '/currency/currency.dart';
import '/items/items.dart';
import 'app.dart';

void main() {
  // BlocOverrides.runZoned(
  //   () {
  //     runApp(App(
  //       loginRepository: LoginRepository(),
  //     ));
  //   },
  //   blocObserver: AppBlocObserver(),
  // );
  runApp(App(
    loginRepository: LoginRepository(),
    accountRepository: AccountRepository(),
    categoryRepository: CategoryRepository(),
    payeeRepository: PayeeRepository(),
    tagRepository: TagRepository(),
    flowRepository: FlowRepository(),
    bookRepository: BookRepository(),
    reportRepository: ReportRepository(),
    itemRepository: ItemRepository(),
    currencyRepository: CurrencyRepository(),
  ));

  // runApp(new MaterialApp(home: PositionedTiles()));

}