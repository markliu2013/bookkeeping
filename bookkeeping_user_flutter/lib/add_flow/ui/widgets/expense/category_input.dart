import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_select/awesome_select.dart';

import '/commons/commons.dart';
import '/add_flow/add_flow.dart';
import '/categories/categories.dart';
import '/login/login.dart';

class CategoryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryState = context.watch<ExpenseCategorySelectBloc>().state;
    final authState = context.watch<AuthBloc>().state;
    final defaultCurrencyCode = authState.session!.defaultGroup.defaultCurrencyCode;
    return BlocBuilder<AddExpenseBloc, AddExpenseState>(
      buildWhen: (previous, current) => previous.request.categories != current.request.categories || previous.currencyCode != current.currencyCode,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartSelect<String>.multiple
            (
              key: Key(new DateTime.now().millisecondsSinceEpoch.toString()),
              title: '分类',
              selectedValue: state.request.categoryIds,
              onChange: (selected) {
                context.read<AddExpenseBloc>().add(AddExpenseCategoryChanged(selected!.value ?? [], selected.title ?? []));
              },
              choiceItems: categoryState is ExpenseCategorySelectStateLoadSuccess ? modelToChoice(categoryState.categories) : [],
              choiceType: S2ChoiceType.chips,
              modalFilter: true,
              modalFilterAuto: true,
              tileBuilder: (context, state) {
                return S2Tile.fromState(
                  state,
                  isLoading: categoryState is ExpenseCategorySelectStateLoadInProgress,
                  padding: EdgeInsets.zero,
                );
              }
            ),
            for ( var i in state.request.categories ?? []) buildAddCategoryItem(i, defaultCurrencyCode, state.currencyCode, context)
          ],
        );
      }
    );
  }

  Widget buildAddCategoryItem(CategoryIdAmountRequest item, String defaultCurrencyCode, String? currencyCode, BuildContext context) {
    return
      Container(
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(item.categoryName, style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(width: 10),
                  Expanded(
                      child: TextField(
                        controller: TextEditingController(text: item.amount != 0 ? removeDecimalZero(item.amount) : ''),
                        keyboardType: TextInputType.number,
                        onChanged: (amount) => context.read<AddExpenseBloc>().add(AddExpenseAmountChanged(item.categoryId, amount)),
                        decoration: InputDecoration(),
                      )
                  )
                ]
            ),
            if (currencyCode != null && defaultCurrencyCode != currencyCode)
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('折合${defaultCurrencyCode}', style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(width: 10),
                    Expanded(
                        child: TextField(
                          controller: TextEditingController(text: item.convertedAmount != null ? removeDecimalZero(item.convertedAmount!) : null),
                          keyboardType: TextInputType.number,
                          onChanged: (amount) => context.read<AddExpenseBloc>().add(AddExpenseConvertedAmountChanged(item.categoryId, amount)),
                          decoration: InputDecoration(),
                        )
                    )
                  ]
              )
          ],
        )
      );
  }

}