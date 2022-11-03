import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '/components/components.dart';
import '/commons/commons.dart';
import '/flows/flows.dart';
import '/add_flow/add_flow.dart';
import '/login/login.dart';

class FlowDetailPage extends StatefulWidget {

  final FlowModel flow;
  FlowDetailPage({
    required this.flow
  });

  @override
  State<FlowDetailPage> createState() => _FlowDetailPageState();
}


class _FlowDetailPageState extends State<FlowDetailPage> {

  @override
  void initState() {
    BlocProvider.of<FlowFetchBloc>(context).add(FlowLoadDefault(flow: widget.flow));
    BlocProvider.of<FlowFetchBloc>(context).add(FlowImagesFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FlowsBloc, FlowsState>(
          listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              Message.success('操作成功！');
              // Navigator.of(context).pop();
              // 下面这个可以解决黑屏问题，原因未知。TODO
              if(Navigator.canPop(context)){
                Navigator.of(context).pop();
              }else{
                SystemNavigator.pop();
              }
            }
          }
        ),
        BlocListener<FlowsBloc, FlowsState>(
          listenWhen: (previous, current) => previous.confirmStatus != current.confirmStatus,
          listener: (context, state) {
            if (state.confirmStatus == LoadDataStatus.success) {
              Message.success('操作成功！');
              BlocProvider.of<FlowFetchBloc>(context).add(FlowFetched());
              // Navigator.of(context).pop();
            }
          }
        ),
        BlocListener<FlowFetchBloc, FlowFetchState>(
          listenWhen: (previous, current) => previous.deleteImageStatus != current.deleteImageStatus,
          listener: (context, state) {
            if (state.deleteImageStatus == LoadDataStatus.success) {
              Message.success('图片删除成功！');
              BlocProvider.of<FlowFetchBloc>(context).add(FlowImagesFetched());
            }
          }
        ),
        BlocListener<FlowFetchBloc, FlowFetchState>(
          listenWhen: (previous, current) => previous.uploadImageStatus != current.uploadImageStatus,
          listener: (context, state) {
            if (state.uploadImageStatus == LoadDataStatus.success) {
              Message.success('图片上传成功！');
              BlocProvider.of<FlowFetchBloc>(context).add(FlowImagesFetched());
            }
          }
        )
      ],
      child: BlocBuilder<FlowFetchBloc, FlowFetchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('账单详情'),
              actions: _buildActions(context, state)
            ),
            body: Builder(
              builder: (context) {
                switch (state.status) {
                  case LoadDataStatus.progress:
                  case LoadDataStatus.initial:
                    return const PageLoading();
                  case LoadDataStatus.success:
                    return _buildBody(context, state);
                  default:
                    return PageError(onTap: () { BlocProvider.of<FlowFetchBloc>(context).add(FlowFetched()); });
                }
              }
            )
          );
        }
    )
    );
  }

  List<Widget> _buildActions(BuildContext context, FlowFetchState state) {
    FlowModel? flow = state.flow;
    return [
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: state.status == LoadDataStatus.success && flow != null ? () {
          fullDialog(context, AddFlowPage(type: 2, flow: flow));
        } : null
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: state.status == LoadDataStatus.success && flow != null ? () async {
          if (widget.flow.status == 3 ) {
            Message.error('已退款的账单必须先删除对应的退款记录。');
            return;
          }
          if (await confirm(
            context,
            content: Text(widget.flow.status != 2 ? '删除账单会撤回对应账户余额变动且无法恢复' : '删除之后无法恢复' + '，确定删除吗？'),
            textOK: Text("确定"),
            textCancel: Text("取消"),
          )) {
            BlocProvider.of<FlowsBloc>(context).add(FlowsDeleted(widget.flow.id.toString()));
          }
        } : null,
      )
    ];
  }
  
  Widget _buildActionBar(BuildContext context, FlowModel flow) {
    final state = context.watch<AuthBloc>().state;
    return OverflowBar(
      overflowAlignment: OverflowBarAlignment.center,
      spacing: 20,
      children: [
        ElevatedButton(
          child: const Text('复制'),
          onPressed: flow.type != 4 ? () {
            fullDialog(context, AddFlowPage(type: 3, flow: flow));
          } : null
        ),
        ElevatedButton(
          child: const Text('退款'),
          // 支出和收入，而且状态正常，不是退款的情况才能退款
          onPressed: ((flow.type == 1 || flow.type == 2) && (flow.status == 1 && flow.amount > 0)) ? () {
            fullDialog(context, AddFlowPage(type: 4, flow: flow));
          } : null
        ),
        ElevatedButton(
            child: const Text('确认'),
            onPressed: flow.status == 2 ? () async {
              if (await confirm(
                context,
                content: Text("状态将更改为确认，确定此操作吗？"),
                textOK: Text("确定"),
                textCancel: Text("取消"),
              )) {
                BlocProvider.of<FlowsBloc>(context).add(FlowsConfirmed(flow));
              }
            } : null
        ),
        ElevatedButton(
          child: const Text('图片'),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: new Icon(Icons.camera_alt),
                      title: const Text('拍照'),
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                        if (photo != null) {
                          BlocProvider.of<FlowFetchBloc>(context).add(FlowImageUploaded(photo.path, flow.id.toString(), state.session?.userSessionVO.id.toString() ?? ''));
                        }
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: const Text('图片库'),
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                        if (photo != null) {
                          BlocProvider.of<FlowFetchBloc>(context).add(FlowImageUploaded(photo.path, flow.id.toString(), state.session?.userSessionVO.id.toString() ?? ''));
                        }
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: new Icon(Icons.cancel),
                      title: const Text('取消'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
            );
          }
        ),
      ],
    );
  }
  
  Widget _buildBody(BuildContext context, FlowFetchState state) {
    TextStyle? style1 = Theme.of(context).textTheme.bodyText2;
    TextStyle? style2 = Theme.of(context).textTheme.bodyText1;
    if (state.uploadImageStatus == LoadDataStatus.progress) {
      return const PageLoading();
    }
    FlowModel flow = state.flow!;
    List<FlowImage> images = state.images;
    return SingleChildScrollView(
      child: Column(
        children: [
          // 放不下变两行可以用Wrap https://github.com/flutter/flutter/issues/53642
          if (flow.type != 4) _buildActionBar(context, flow),
          SizedBox(height: 15),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(children: [Text("描述：", style: style1), Text(flow.description ?? "", style: style2)]),
                  SizedBox(height: 15),
                  Row(children: [Text("交易类型：", style: style1), Text(flow.typeName, style: style2)]),
                  SizedBox(height: 15),
                  Row(children: [Text("时间：", style: style1), Text(flow.createTimeFormatted, style: style2)]),
                  SizedBox(height: 15),
                  Row(children: [Text("金额：", style: style1), Text(flow.amount.toStringAsFixed(2), style: style2)]),
                  SizedBox(height: 15),
                  if (flow.needConvert)
                    Row(children: [Text("折合${flow.toCurrencyCode}：", style: style1), Text(flow.convertedAmount != null ? flow.convertedAmount.toString() : '', style: style2)]),
                  if (flow.needConvert) SizedBox(height: 15),
                  Row(children: [Text("账户：", style: style1), Text(flow.accountName ?? "", style: style2)]),
                  SizedBox(height: 15),
                  if(flow.type == 1 || flow.type == 2) Row(children: [Text("类别：", style: style1), Text(flow.categoryName ?? "", style: style2)]),
                  if(flow.type == 1 || flow.type == 2) SizedBox(height: 15),
                  if(flow.type != 4) Row(children: [Text("标签：", style: style1), Text(flow.tagsName ?? "", style: style2)]),
                  if(flow.type != 4) SizedBox(height: 15),
                  if(flow.type == 1 || flow.type == 2) Row(children: [Text("交易对象：", style: style1), Text(flow.payee?.name ?? "", style: style2)]),
                  if(flow.type == 1 || flow.type == 2) SizedBox(height: 15),
                  Row(children: [Text("状态：", style: style1), Text(flow.statusName, style: style2)]),
                  SizedBox(height: 15),
                  Row(children: [Text("备注：", style: style1), Flexible(child: Text(flow.notes ?? "", style: style2))]),
                ],
              )
          ),
          Column(
            children: images.map((e) => (
              Column(
                children: [
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      if (await confirm(
                        context,
                        content: const Text('确定删除此账单图片吗？'),
                        textOK: Text("确定"),
                        textCancel: Text("取消"),
                      )) {
                        BlocProvider.of<FlowFetchBloc>(context).add(FlowImageDeleted(e.id.toString()));
                      }
                    },
                    child: Image.network(e.url),
                  )
                ],
              )
            )).toList(),
          ),
        ],
      ),
    );
  }

}