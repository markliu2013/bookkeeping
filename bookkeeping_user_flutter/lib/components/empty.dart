import 'package:flutter/material.dart';

class Empty extends StatelessWidget {

  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.feedback_outlined, size: 70),
          Text('无数据', style: theme.textTheme.headline4),
        ],
      ),
    );
  }
  
}