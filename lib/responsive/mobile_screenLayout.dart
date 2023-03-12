import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frincle_v2/provider/user_provider.dart';
import 'package:frincle_v2/utils/color.dart';
import 'package:frincle_v2/utils/global_varialbles.dart';
import 'package:provider/provider.dart';
import '../models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationtoPage(int page) {
    pageController.jumpToPage(page);
  }

  void changePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        title: Text(
          'frincle',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ))
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: changePage,
        children: homeScreeItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: navigationtoPage,
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color:
                    _page == 0 ? Theme.of(context).primaryColor : Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.emoji_emotions,
                color:
                    _page == 1 ? Theme.of(context).primaryColor : Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color:
                    _page == 2 ? Theme.of(context).primaryColor : Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color:
                    _page == 3 ? Theme.of(context).primaryColor : Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline_outlined,
                color:
                    _page == 4 ? Theme.of(context).primaryColor : Colors.black,
              ),
              label: ''),
        ],
      ),
    );
  }
}
