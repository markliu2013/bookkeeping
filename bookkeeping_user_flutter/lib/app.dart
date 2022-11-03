import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/categories/categories.dart';
import '/flows/flows.dart';
import '/payees/payees.dart';
import '/tags/tags.dart';
import '/accounts/accounts.dart';
import '/login/login.dart';
import '/books/books.dart';
import '/charts/charts.dart';
import '/items/items.dart';
import '/currency/currency.dart';
import 'themes.dart';
import 'routes.dart';

class App extends StatelessWidget {

  const App({
    Key? key,
    required this.loginRepository,
    required this.accountRepository,
    required this.payeeRepository,
    required this.tagRepository,
    required this.categoryRepository,
    required this.flowRepository,
    required this.bookRepository,
    required this.reportRepository,
    required this.itemRepository,
    required this.currencyRepository,
  }) : super(key: key);

  final LoginRepository loginRepository;
  final AccountRepository accountRepository;
  final PayeeRepository payeeRepository;
  final TagRepository tagRepository;
  final CategoryRepository categoryRepository;
  final FlowRepository flowRepository;
  final BookRepository bookRepository;
  final ReportRepository reportRepository;
  final ItemRepository itemRepository;
  final CurrencyRepository currencyRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: loginRepository),
        RepositoryProvider.value(value: accountRepository),
        RepositoryProvider.value(value: categoryRepository),
        RepositoryProvider.value(value: payeeRepository),
        RepositoryProvider.value(value: tagRepository),
        RepositoryProvider.value(value: flowRepository),
        RepositoryProvider.value(value: bookRepository),
        RepositoryProvider.value(value: reportRepository),
        RepositoryProvider.value(value: itemRepository),
        RepositoryProvider.value(value: currencyRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(loginRepository: loginRepository)..add(AppStarted())
          ),
          BlocProvider(
            create: (_) => FlowsBloc(flowRepository: flowRepository)
          ),
          BlocProvider(
            create: (_) => PayeeExpenseableBloc(payeeRepository: payeeRepository)..add(PayeeExpenseableLoaded())
          ),
          BlocProvider(
            create: (_) => PayeeIncomeableBloc(payeeRepository: payeeRepository)..add(PayeeIncomeableLoaded())
          ),
          BlocProvider(
            create: (_) => PayeeEnableBloc(payeeRepository: payeeRepository)..add(PayeeEnableLoaded())
          ),
          BlocProvider(
            create: (_) => TagExpenseableBloc(tagRepository: tagRepository)..add(TagExpenseableLoaded())
          ),
          BlocProvider(
            create: (_) => TagIncomeableBloc(tagRepository: tagRepository)..add(TagIncomeableLoaded())
          ),
          BlocProvider(
            create: (_) => TagTransferableBloc(tagRepository: tagRepository)..add(TagTransferableLoaded())
          ),
          BlocProvider(
            create: (_) => TagEnableBloc(tagRepository: tagRepository)..add(TagEnableLoaded())
          ),
          BlocProvider(
            create: (_) => ExpenseCategorySelectBloc(categoryRepository: categoryRepository)..add(ExpenseCategorySelectLoaded())
          ),
          BlocProvider(
            create: (_) => IncomeCategorySelectBloc(categoryRepository: categoryRepository)..add(IncomeCategorySelectLoaded())
          ),
        ],
        child: Builder(builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => AccountExpenseableBloc(accountRepository: accountRepository)..add(AccountExpenseableLoaded())
              ),
              BlocProvider(
                create: (_) => AccountIncomeableBloc(accountRepository: accountRepository)..add(AccountIncomeableLoaded())
              ),
              BlocProvider(
                create: (_) => AccountTransferFromAbleBloc(accountRepository: accountRepository)..add(AccountTransferFromAbleLoaded())
              ),
              BlocProvider(
                create: (_) => AccountTransferToAbleBloc(accountRepository: accountRepository)..add(AccountTransferToAbleLoaded())
              ),
              BlocProvider(
                create: (_) => AccountEnableBloc(accountRepository: accountRepository)..add(AccountEnableLoaded())
              ),
              BlocProvider(
                create: (_) => CategoryTreeBloc(
                  categoryRepository: categoryRepository,
                  expenseCategorySelectBloc: BlocProvider.of<ExpenseCategorySelectBloc>(context),
                  incomeCategorySelectBloc: BlocProvider.of<IncomeCategorySelectBloc>(context),
                )
              ),
              BlocProvider(
                create: (_) => CategoryFetchBloc(categoryRepository: categoryRepository)
              ),
              BlocProvider(
                create: (_) => TagTreeBloc(
                  tagRepository: tagRepository,
                  tagExpenseableBloc: BlocProvider.of<TagExpenseableBloc>(context),
                  tagIncomeableBloc: BlocProvider.of<TagIncomeableBloc>(context),
                  tagTransferableBloc: BlocProvider.of<TagTransferableBloc>(context),
                  tagEnableBloc: BlocProvider.of<TagEnableBloc>(context),
                )
              ),
              BlocProvider(
                create: (_) => TagFetchBloc(tagRepository: tagRepository)
              ),
              BlocProvider(
                create: (_) => BookFetchBloc(bookRepository: bookRepository)
              ),
              BlocProvider(
                create: (_) => FlowFetchBloc(flowRepository: flowRepository)
              ),
              BlocProvider(
                create: (_) => AccountsBloc(accountRepository: accountRepository)
              ),
              BlocProvider(
                create: (_) => AccountAdjustBalanceBloc(accountRepository: accountRepository)
              ),
              BlocProvider(
                create: (_) => AccountFetchBloc(accountRepository: accountRepository)
              ),
              BlocProvider(
                create: (_) => PayeesBloc(payeeRepository: payeeRepository)
              ),
              BlocProvider(
                create: (_) => PayeeFetchBloc(payeeRepository: payeeRepository)
              ),
              BlocProvider(
                create: (_) => BooksBloc(
                  bookRepository: bookRepository,
                  authBloc: BlocProvider.of<AuthBloc>(context),
                  flowsBloc: BlocProvider.of<FlowsBloc>(context),
                  expenseCategorySelectBloc: BlocProvider.of<ExpenseCategorySelectBloc>(context),
                  incomeCategorySelectBloc: BlocProvider.of<IncomeCategorySelectBloc>(context),
                  tagExpenseableBloc: BlocProvider.of<TagExpenseableBloc>(context),
                  tagIncomeableBloc: BlocProvider.of<TagIncomeableBloc>(context),
                  tagTransferableBloc: BlocProvider.of<TagTransferableBloc>(context),
                  tagEnableBloc: BlocProvider.of<TagEnableBloc>(context),
                  payeeExpenseableBloc: BlocProvider.of<PayeeExpenseableBloc>(context),
                  payeeIncomeableBloc: BlocProvider.of<PayeeIncomeableBloc>(context),
                  payeeEnableBloc: BlocProvider.of<PayeeEnableBloc>(context),
                )
              ),
              BlocProvider(
                create: (_) => BookFetchBloc(bookRepository: bookRepository)
              ),
              BlocProvider(
                  create: (_) => ReportAssetBloc(reportRepository: reportRepository)..add(ReportAssetLoaded())
              ),
              BlocProvider(
                  create: (_) => ReportDebtBloc(reportRepository: reportRepository)..add(ReportDebtLoaded())
              ),
              BlocProvider(
                create: (_) => ReportExpenseCategoryBloc(reportRepository: reportRepository)..add(ReportExpenseCategoryRefreshed()),
              ),
              BlocProvider(
                create: (_) => ReportIncomeCategoryBloc(reportRepository: reportRepository)..add(ReportIncomeCategoryRefreshed()),
              ),
              BlocProvider(
                create: (_) => ItemsBloc(itemRepository: itemRepository)
              ),
              BlocProvider(
                create: (_) => CurrencyAllBloc(currencyRepository: currencyRepository)..add(CurrencyAllLoaded()),
              )
            ],
          child: AppView()
        );
        })
      )
    );
  }
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh'),
      ],
      locale: const Locale('zh'),
      title: '九快记账',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routes: AppRouter.routes,
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: AppRouter.generateRoute,
      onUnknownRoute: AppRouter.unknownRoute,
    );
  }
}