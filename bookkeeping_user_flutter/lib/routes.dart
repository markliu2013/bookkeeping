import 'package:bookkeeping_user_flutter/charts/charts.dart';
import 'package:bookkeeping_user_flutter/items/items.dart';
import 'package:flutter/material.dart';
import '/components/components.dart';
import 'start_page.dart';
import 'index.dart';
import '/accounts/accounts.dart';
import '/categories/categories.dart';
import '/flows/flows.dart';
import '/payees/payees.dart';
import '/books/books.dart';
import '/tags/tags.dart';

class AppRouter {

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => StartPage(),
    '/index': (context) => IndexPage(),
    '/flows-filter': (context) => FlowsFilterPage(),
    '/expense-categories': (context) => ExpenseCategoryPage(),
    '/income-categories': (context) => IncomeCategoryPage(),
    '/payees': (context) => PayeesPage(),
    '/books': (context) => BooksPage(),
    '/tags': (context) => TagsPage(),
    '/charts-expense-category-filter': (context) => ChartsExpenseCategoryFilterPage(),
    '/charts-income-category-filter': (context) => ChartsIncomeCategoryFilterPage(),
    '/items-index': (context) => ItemsIndexPage()
  };

  static final String initialRoute = '/';

  static final RouteFactory generateRoute = (settings) {
    if (settings.name == '/flow-detail') {
      final args = settings.arguments as FlowDetailArguments;
      return MaterialPageRoute(
          builder: (_) => FlowDetailPage(flow: args.flow)
      );
    }
    if (settings.name == '/account-detail') {
      final args = settings.arguments as AccountDetailArguments;
      return MaterialPageRoute(
          builder: (_) => AccountDetailPage(account: args.account)
      );
    }
    if (settings.name == '/payee-detail') {
      final args = settings.arguments as PayeeDetailArguments;
      return MaterialPageRoute(
          builder: (_) => PayeeDetailPage(payee: args.payee)
      );
    }
    if (settings.name == '/book-detail') {
      final args = settings.arguments as BookDetailArguments;
      return MaterialPageRoute(
          builder: (_) => BookDetailPage(book: args.book)
      );
    }
    if (settings.name == '/category-detail') {
      final args = settings.arguments as CategoryDetailArguments;
      return MaterialPageRoute(
          builder: (_) => CategoryDetailPage(category: args.category, categoryType: args.categoryType)
      );
    }
    if (settings.name == '/tag-detail') {
      final args = settings.arguments as TagDetailArguments;
      return MaterialPageRoute(
          builder: (_) => TagDetailPage(tag: args.tag)
      );
    }
    return null;
  };

  static final RouteFactory unknownRoute = (settings) {
    return MaterialPageRoute(
        builder: (_) => const PageError(msg: '路由找不到')
    );
  };

}

class FlowDetailArguments {
  final FlowModel flow;
  FlowDetailArguments({
    required this.flow,
  });
}

class AccountDetailArguments {
  final Account account;
  AccountDetailArguments({
    required this.account,
  });
}

class PayeeDetailArguments {
  final Payee payee;
  PayeeDetailArguments({
    required this.payee,
  });
}

class BookDetailArguments {
  final Book book;
  BookDetailArguments({
    required this.book,
  });
}

class CategoryDetailArguments {
  final int categoryType;
  final Category category;
  CategoryDetailArguments({
    required this.category,
    required this.categoryType
  });
}

class TagDetailArguments {
  final Tag tag;
  TagDetailArguments({
    required this.tag,
  });
}