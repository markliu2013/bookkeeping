import 'package:flutter/material.dart';
import '/commons/commons.dart';
import '/charts/charts.dart';

class CircularLegend extends StatelessWidget {

  final List<XY> xys;

  CircularLegend({
    required this.xys
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: xys.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        XY xy = xys[index];
        return ListTile(
          dense: true,
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Text(xy.x, style: theme.textTheme.titleSmall),
          subtitle: Text(removeDecimalZero(xy.y), style: theme.textTheme.caption),
          trailing: Text(removeDecimalZero(xy.percent)+"%", style: theme.textTheme.titleMedium),
        );
      }
    );
  }

}
