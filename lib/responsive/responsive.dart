import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frincle_v2/provider/user_provider.dart';
import 'package:frincle_v2/responsive/web_screenlayout.dart';
import 'package:provider/provider.dart';

import '../utils/global_varialbles.dart';
import './web_screenlayout.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileSceenLayout;
  const ResponsiveLayout(
      {super.key,
      required this.webScreenLayout,
      required this.mobileSceenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) {
        if (Constraints.maxWidth > webscreen) {
          return widget.webScreenLayout;
        } else {
          return widget.mobileSceenLayout;
        }
      },
    );
  }
}
