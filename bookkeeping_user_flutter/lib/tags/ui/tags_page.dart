import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/routes.dart';
import '/components/components.dart';
import '/commons/commons.dart';
import '/tags/tags.dart';

class TagsPage extends StatefulWidget {
  @override
  State<TagsPage> createState() => _TagPagesState();
}

class _TagPagesState extends State<TagsPage> {

  @override
  void initState() {
    BlocProvider.of<TagTreeBloc>(context).add(TagTreeRefreshed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TagTreeBloc>().state;
    return MultiBlocListener(
      listeners: [
        BlocListener<TagTreeBloc, TagTreeState>(
          listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              BlocProvider.of<TagTreeBloc>(context).add(TagTreeRefreshed());
            }
          },
        ),
        BlocListener<TagTreeBloc, TagTreeState>(
          listenWhen: (previous, current) => previous.toggleStatus != current.toggleStatus,
          listener: (context, state) {
            if (state.toggleStatus == LoadDataStatus.success) {
              BlocProvider.of<TagTreeBloc>(context).add(TagTreeRefreshed());
            }
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () => _onWillPop(state),
        child: BlocBuilder<TagTreeBloc, TagTreeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('标签'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      fullDialog(context, TagFormPage(type: 1));
                    }
                  )
                ]
              ),
              body: Builder(
                builder: (BuildContext context) {
                  switch (state.status) {
                    case LoadDataStatus.progress:
                    case LoadDataStatus.initial:
                      return const PageLoading();
                    case LoadDataStatus.success:
                      if (state.currentTags.isEmpty) return Empty();
                      return _buildList(context, state.currentTags);
                    default:
                      return PageError(onTap: () { BlocProvider.of<TagTreeBloc>(context).add(TagTreeRefreshed()); });
                  }
                },
              ),
            );
          },
        )
      ),
    );
  }

  Widget _buildList(BuildContext context, List<TagTree> tags) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: tags.length,
      itemBuilder: (context, index) {
        TagTree tagTree = tags[index];
        return ListTile(
          dense: true,
          title: Text(tagTree.name, style: theme.textTheme.bodyText1),
          subtitle: tagTree.notes != null && tagTree.notes!.isNotEmpty ? Text(tagTree.notes!, style: theme.textTheme.caption) : null,
          trailing: tagTree.children != null && tagTree.children!.isNotEmpty ? Icon(Icons.keyboard_arrow_right) : null,
          onTap: () {
            if (tagTree.children != null && tagTree.children!.isNotEmpty) {
              BlocProvider.of<TagTreeBloc>(context).add(TagItemClicked(tagTree: tagTree));
            } else {
              Navigator.pushNamed(context, '/tag-detail', arguments: TagDetailArguments(tag: Tag.fromTree(tagTree)));
            }
          },
          onLongPress: () {
            Navigator.pushNamed(context, '/tag-detail', arguments: TagDetailArguments(tag: Tag.fromTree(tagTree)));
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Future<bool> _onWillPop(state) async {
    if (state.currentLevel == 1) return true;
    BlocProvider.of<TagTreeBloc>(context).add(TagBackClicked());
    return false;
  }

}