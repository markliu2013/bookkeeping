import 'package:flutter/material.dart';

class PageLoading extends StatelessWidget {

  const PageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  
}