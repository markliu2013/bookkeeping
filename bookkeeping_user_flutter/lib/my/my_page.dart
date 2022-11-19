import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/commons/commons.dart';
import '/login/login.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    return Scaffold(
        appBar: AppBar(
          title: const Text('我的'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text('登录用户名：'),
                trailing: Text(state.session?.userSessionVO.userName ?? '')
              ),
              ListTile(
                title: Text('会员到期日：'),
                trailing: Text(DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(state.session?.userSessionVO.vipTime ?? 0)))
              ),
              ListTile(
                title: Text('当前组：'),
                trailing: Text(state.session?.defaultGroup.name ?? '')
              ),
              ListTile(
                title: Text('当前账本：'),
                trailing: Text(state.session?.defaultBook.name ?? '')
              ),
              Divider(),
              ListTile(
                title: Text('账本管理'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, '/books');
                },
              ),
              Divider(),
              ListTile(
                title: const Text('支出类别'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, '/expense-categories');
                }
              ),
              ListTile(
                title: const Text('收入类别'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, '/income-categories');
                }
              ),
              ListTile(
                title: const Text('交易标签'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, '/tags');
                }
              ),
              ListTile(
                title: const Text('交易对象'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, '/payees');
                }
              ),
              Divider(),
              ListTile(
                title: const Text('提醒事项'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, '/items-index');
                }
              ),
              Divider(),
              ListTile(
                  title: const Text('api地址'),
                  trailing: Text(session['apiUrl']),
                  onTap: () {
                    //Navigator.pushNamed(context, );
                  }
              ),
              Divider(),
              ListTile(
                title: const Text('使用指南'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WebViewPage(title: '使用指南', url: 'https://docs.jz.jiukuaitech.com/'),
                    ),
                  );
                }
              ),
              Divider(),
              ListTile(
                  title: const Text('当前版本号：'),
                  trailing: const Text('1.0.2')
              ),
              Divider(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                    child: const Text('退出登录'),
                    onPressed: () async {
                      if (await confirm(
                        context,
                        content: Text('确定退出吗？'),
                        textOK: Text('确定'),
                        textCancel: Text('取消'),
                      )) {
                        BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                      }
                    }
                )
              )
            ],
          ),
        )
    );
  }
}