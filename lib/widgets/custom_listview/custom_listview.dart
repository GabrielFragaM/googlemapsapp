
import 'package:flutter/material.dart';

import '../../constants/app_config/app_config.dart';

class CustomListView extends StatelessWidget {

  final List<Widget> children;


  const CustomListView({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(left: AppConfig.paddingLeft, right: AppConfig.paddingRight),
      children: children,
    );
  }
}