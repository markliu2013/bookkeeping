import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/login/login.dart';
import '/add_flow/add_flow.dart';
import '/flows/flows.dart';
import '/accounts/accounts.dart';

class AddFlowPage extends StatelessWidget {

  final int type; // 1-新增，2-修改，3-复制，4-退款
  final FlowModel? flow;

  AddFlowPage({
    required this.type,
    this.flow,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
            AddExpenseBloc(
              flowRepository: RepositoryProvider.of<FlowRepository>(context),
              authBloc: BlocProvider.of<AuthBloc>(context),
              accountExpenseableBloc: BlocProvider.of<AccountExpenseableBloc>(context),
            )..add(AddExpenseDefaultLoaded(type, flow?.expense)),
        ),
        BlocProvider(
          create: (_) =>
          AddIncomeBloc(
            flowRepository: RepositoryProvider.of<FlowRepository>(context),
            authBloc: BlocProvider.of<AuthBloc>(context),
            accountIncomeableBloc: BlocProvider.of<AccountIncomeableBloc>(context),
          )..add(AddIncomeDefaultLoaded(type, flow?.income)),
        ),
        BlocProvider(
          create: (_) =>
          AddTransferBloc(
            flowRepository: RepositoryProvider.of<FlowRepository>(context),
            authBloc: BlocProvider.of<AuthBloc>(context),
            accountTransferFromAbleBloc: BlocProvider.of<AccountTransferFromAbleBloc>(context),
            accountTransferToAbleBloc: BlocProvider.of<AccountTransferToAbleBloc>(context),
          )..add(AddTransferDefaultLoaded(type, flow?.transfer)),
        ),
      ],
      child: type == 1 ? TabPage() : NoTabPage(type: type, flow: flow!)
    );
  }
}