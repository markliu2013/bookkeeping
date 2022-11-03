import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/components.dart';
import '/commons/commons.dart';
import '/tags/tags.dart';

class TagDetailPage extends StatefulWidget {

  final Tag tag;
  TagDetailPage({
    required this.tag
  });

  @override
  State<TagDetailPage> createState() => _TagDetailPageState();
}

class _TagDetailPageState extends State<TagDetailPage> {

  @override
  void initState() {
    BlocProvider.of<TagFetchBloc>(context).add(TagLoadDefault(tag: widget.tag));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TagTreeBloc, TagTreeState>(
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
        BlocListener<TagTreeBloc, TagTreeState>(
          listenWhen: (previous, current) => previous.toggleStatus != current.toggleStatus,
          listener: (context, state) {
            if (state.toggleStatus == LoadDataStatus.success) {
              Message.success('操作成功！');
              BlocProvider.of<TagFetchBloc>(context).add(TagFetched());
            }
          },
        )
      ],
      child: BlocBuilder<TagFetchBloc, TagFetchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('标签详情'),
              actions: _buildActions(context, state.tag ?? widget.tag)
            ),
            body: Builder(
              builder: (context) {
                switch (state.status) {
                  case LoadDataStatus.progress:
                  case LoadDataStatus.initial:
                    return const PageLoading();
                  case LoadDataStatus.success:
                    return _buildBody(context, state.tag ?? widget.tag);
                  default:
                    return PageError(onTap: () { BlocProvider.of<TagFetchBloc>(context).add(TagFetched()); });
                }
              },
            )
          );
        }
      )
    );
  }

  List<Widget> _buildActions(BuildContext context, Tag tag) {
    return [
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          fullDialog(context, TagFormPage(type: 1, tag: tag));
        }
      ),
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          fullDialog(context, TagFormPage(type: 2, tag: tag));
        }
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          if (await confirm(
            context,
            content: Text("确定删除${tag.name}吗？"),
            textOK: Text("确定"),
            textCancel: Text("取消"),
          )) {
            BlocProvider.of<TagTreeBloc>(context).add(TagDeleted(tag.id.toString()));
          }
        }
      )
    ];
  }

  Widget _buildBody(BuildContext context, Tag tag) {
    final theme = Theme.of(context);
    TextStyle? style1 = theme.textTheme.bodyText2;
    TextStyle? style2 = theme.textTheme.bodyText1;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(children: [Text("父级名称：", style: style1), Text(tag.parentName ?? '', style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("标签名称：", style: style1), Text(tag.name, style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("备注：", style: style1), Flexible(child: Text(tag.notes ?? '', style: style2))]),
            SizedBox(height: 15),
            Row(children: [Text("是否可支出：", style: style1), Text(boolToString(tag.expenseable), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否可收入：", style: style1), Text(boolToString(tag.incomeable), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否可转账：", style: style1), Text(boolToString(tag.transferable), style: style2)]),
            SizedBox(height: 15),
            Row(children: [Text("是否可用：", style: style1), Text(boolToString(tag.enable), style: style2)]),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  child: Text(tag.enable ? '禁用' : '启用'),
                  onPressed: () {
                    BlocProvider.of<TagTreeBloc>(context).add(TagToggled(tag.id.toString()));
                  }
              ),
            )
          ],
        )
      ),
    );
  }

}