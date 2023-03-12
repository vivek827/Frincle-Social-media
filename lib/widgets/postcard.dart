import 'package:flutter/material.dart';
import 'package:frincle_v2/screens/login_screen.dart';
import 'package:frincle_v2/service/auth_service.dart';
import '../screens/all_achievements.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.snap['proImage']),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(widget.snap['username'])
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 300,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                padding: EdgeInsets.all(8),
                child: Stack(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Image.network(
                          widget.snap['photoUrl'],
                        )),
                  ],
                ),
              ),
            ),
            Container(
                width: 300,
                height: 25,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Text(widget.snap['description'])),
            ElevatedButton(
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                },
                child: Text('sign out'))
          ],
        ),
      ],
    ));
  }
}
